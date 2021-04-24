#! /usr/bin/env python3 
import os
import shutil
import subprocess

import logging
logger = logging.getLogger(name=__name__)

class HookHandler:
    def __init__(self, mode, pathes):
        self.mode = mode

        self.d8 = pathes['d8_path']
        self.javac = pathes['javac_path']
        self.baksmali = pathes['baksmali_path']
        self.androidapi = pathes['androidapi_path']

        self.hookSinppetSmali = []
        self.tmpPath = pathes['tmp_path']
        self.packageName = pathes['APK_real_package_name']
        self.dalvikEntry = pathes['APK_dalvikEntry_path']
        self.copyPath = "./hooksnippet/java"

        # TODO Entry search need enhanced
        self.onCreateIns = (".method public onCreate(Landroid/os/Bundle;)V",
                            ".method protected onCreate(Landroid/os/Bundle;)V",
                            ".method protected attachBaseContext(Landroid/content/Context;)V",
                            ".method protected onCreate()V", # might not exist
                            ".method public onCreate()V",
                            ".method public final onCreate(Landroid/os/Bundle;)V")

        self.hookCodesEntry = ["\n\tinvoke-static/range {p0 .. p0}, Lcom/hook/mark/ServiceManagerWraper;->hookPMS(Landroid/content/Context;)V\n\tinvoke-static {}, Lcom/hook/mark/PackageCodePathWraper;->hookAppDir()V\n",
                                "\n\tinvoke-static/range {p0 .. p0}, Lcom/hook/mark/ServiceManagerWraper;->hookPMS(Landroid/content/Context;)V\n\tinvoke-static {}, Lcom/hook/mark/PackageCodePathWraper;->hookAppDir()V\n",
                                "\n\tinvoke-static {p1}, Lcom/hook/mark/ServiceManagerWraper;->hookPMS(Landroid/content/Context;)V\n\tinvoke-static {}, Lcom/hook/mark/PackageCodePathWraper;->hookAppDir()V\n"]

        self._signIns = 'const-string v0, "signature_have_been_hooked"'
        self._trueSignIns = 'const-string v0, "' + pathes['APK_signature'] + '"'
        self._prevHandle()
        
    def _prevHandle(self):
        for index,codes in enumerate(self.hookCodesEntry):
            self.hookCodesEntry[index] = codes.replace("com/hook/mark", self.packageName.replace('.','/'))

    def codeReplacing(self, files, mark, real):
        """ replace the mark in the file
        """
        for file in files:
            with open(file,'r') as f:
                codeSnippet = f.read()
        # searching the mark
                codeSnippet = codeSnippet.replace(mark, real)
            with open(file,'w') as f:
                f.write(codeSnippet)
    
    def hookSnippetGenerating(self):
        # tmp/hooksnippet/
        # 1. javac generate class with androidapi
        # 2. d8 class -> dex
        # 3. dex -> smali
        codePath = os.path.join(self.tmpPath, 'hooksnippet')
        if not os.path.exists(codePath):
            shutil.copytree(self.copyPath,codePath)

        # fake the pakcage name
        tmpjava = []
        for file in os.listdir(codePath):
            if file.endswith('.java'):
                tmpjava.append(os.path.join(codePath, file))
        logger.debug(f"Replacing packageinfos in {tmpjava} with {self.packageName}")
        self.codeReplacing(tmpjava, "com.hook.mark", self.packageName)
        
        # logger.debug(f"[+] Unzipping the apk file {self.filePath}")
        p = subprocess.Popen(self.javac + " -classpath " + self.androidapi + " " + os.path.join(codePath,"*.java"), shell=True, stdout=subprocess.PIPE)
        logger.debug(p.stdout.read().decode())
        p.wait()

        p = subprocess.Popen(self.d8 + " --release " + os.path.join(codePath,"*.class") + " --output " + codePath, shell=True, stdout=subprocess.PIPE)
        logger.debug(p.stdout.read().decode())
        p.wait()

        p = subprocess.Popen(["java", "-jar", self.baksmali, "-o", codePath,os.path.join(codePath,"classes.dex")], stdout=subprocess.PIPE)
        logger.debug(p.stdout.read().decode())
        p.wait()

        # TODO move addr and clean
        for root, dirs, files in os.walk(codePath):
            for file in files:
                if file.endswith('.smali'):
                    self.hookSinppetSmali.append(os.path.join(codePath,file))
                    try:
                        shutil.copyfile(os.path.join(root,file), os.path.join(codePath,file))
                    except:
                        logger.warning("[!] The smali old file {} still exist".format(*self.hookSinppetSmali))
                        if (input("Delete old files? (Y/N)")=='Y'):
                            # if need delet old files
                            # TODO
                            for file in self.hookSinppetSmali:
                                p = subprocess.Popen("rm -r "+ file, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
                                logger.debug(p.stdout.read().decode())
                                p.wait()
                            shutil.copyfile(os.path.join(root,file), os.path.join(codePath,file))
                        pass


    def pathInvalid(self):
        for file in self.hookSinppetSmali:
            if not os.path.exists(file):
                return True
            else:
                return False
    
    def codeInserting(self, file, codeSnippet):
        # insert codesnippet in the location
        # default insert in the onCreate function
        
        pass

    def codeSignReplacing(self):
        if not self.mode:
            return 1
        # 1. find 
        if self.pathInvalid():
            return 1
        # open smali code file
        self.codeReplacing(self.hookSinppetSmali, self._signIns, self._trueSignIns)
        # replace the sign in the snippet

        # replace code in hookPMS

    def hookSnippetInjecting(self):
        """
         1. find hook code location (OnCreate)
         2. Inject hook code entry snippet
        """
        if self.pathInvalid():
            return 1

        # TODO if hooked then not hook
        with open(self.dalvikEntry) as f:
            codeSnippet = f.read()
        for index,types in enumerate(self.onCreateIns):
            try:
                insertLocation = codeSnippet.index(types)
                break
            except:
                continue
        insertLocation = insertLocation + codeSnippet[insertLocation:].index('.locals')
        # insertLocation = insertLocation + codeSnippet[insertLocation:].index('onCreate') # should not before system start (NO PRIVILIDGE)
        insertLocation = insertLocation + codeSnippet[insertLocation:].index('\n')
        codeSnippet = codeSnippet[:insertLocation] + self.hookCodesEntry[index%2] + codeSnippet[insertLocation:]
        with open(self.dalvikEntry,'w') as f:
            f.write(codeSnippet)
        logger.info("[+]Finish hooking")

    def hookSnippetCombining(self):
        """ 1. inject hook snippet
         2. add hook code snippet
        """ 
        # TODO increase the strong
        for file in self.hookSinppetSmali:
            try:
                shutil.copyfile(file, 
                    os.path.join(
                        self.dalvikEntry[:self.dalvikEntry.rindex('/')], 
                        file[file.rindex('/')+1:]
                    )
                )
            except:
                # logger.warning(f"[!] The smali old file {*self.hookSinppetSmali} still exist")
                # if (input("Delete old files? (Y/N)")=='Y'):
                #     # if need delet old files
                #     # TODO
                #     for file in self.hookSinppetSmali:
                #         p = subprocess.Popen("rm -r "+ file, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
                #         logger.debug(p.stdout.read().decode())
                #         p.wait()
                #     shutil.copyfile(os.path.join(root,file), os.path.join(codePath,file))
                pass
        logger.info("[+]Finish Combining")
                