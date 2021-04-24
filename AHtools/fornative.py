#! /usr/bin/env python3 
import os
import shutil
import logging
import subprocess
from core.HookHandler import HookHandler

logger = logging.getLogger(name=__name__)

class NativeHookHandler(HookHandler):
    def __init__(self, mode, pathes):
        
        """
        find native entry
        loadlibrary entry
        invoke native function codes
        replace in 
        """
        super().__init__(mode, pathes)

        self.targetAPKPath = pathes["APK_target_path"]

        self.copyPath = "./hooksnippet/native"
        self.hookframework = "./hookframework/whale"
        self.hookSMALI = os.path.join(self.hookframework,'smali')
        self.hookLIB = os.path.join(self.hookframework,'lib')
        self.hookCodesEntry = ["\n\tinvoke-static {}, Lcom/hook/mark/LibraryLoader;->loadStart()V\n",
                    "\n\tinvoke-static {}, Lcom/hook/mark/LibraryLoader;->loadStart()V\n"]
        self._prevHandle()
        
    def nativeInvokeEntryConstruct(self):
        """
            construct native method invoke entry - LibraryLoader
        """
        self.hookSnippetGenerating()
        self.hookSnippetInjecting()
        self.hookSnippetCombining()

    def nativeHookSnippetReConstruct(self):
        """
        rewrite c name with class level
        """
        codePath = os.path.join(self.tmpPath, 'hooksnippet','cpp')

        tmpcpp = []
        for file in os.listdir(codePath):
            if file.endswith('.cpp'):
                tmpcpp.append(os.path.join(codePath, file))
        logger.debug(f"Replacing packageinfos in {tmpcpp} with {self.packageName}")
        self.codeReplacing(tmpcpp, "com_hook_mark", self.packageName.replace('.','_'))



    def nativeHookSnippetGenerating(self):
        """
        generate hook snippet
            1. cmake to generate .so files
        """
        oldpath = os.getcwd()
        print(oldpath)
        codePath = os.path.join(self.tmpPath, 'hooksnippet')

        for file in os.listdir(codePath):
            if file.endswith('.sh'):
                cmake = os.path.join('.', file)
        os.chdir(codePath)
        p = subprocess.Popen(cmake , shell=True, stdout=subprocess.PIPE)
        logger.debug(p.stdout.read().decode('ascii'))
        p.wait()
        os.chdir(oldpath)

    def nativeEntryConstruct(self):
        """TODO
        nativeInvokeEntryConstruct stealthy version
        1. find oncreate entry -> inject invoke codes
        2. find virtual method entry(might not exisit) -> inject in the files end
        3. create loadlibrary entry
        """
        pass
        
    def copytree(self, src, dst, symlinks=False, ignore=None):
        for item in os.listdir(src):
            s = os.path.join(src, item)
            d = os.path.join(dst, item)
            if os.path.isdir(s):
                shutil.copytree(s, d, symlinks, ignore)
            else:
                shutil.copy2(s, d)

    def hookFrameworkInject(self):
        """TODO
        inject the hook framework into the package
            0. smali codes (DONE from super)
            1. native hook lib
            2. hook framework
        """
        # the lib path want to insert
        APKlib = os.path.join(self.targetAPKPath,'lib')
        ABIList = [abi for abi in os.listdir(APKlib)]
        # self generate
        hookTrigger = os.path.join(self.tmpPath, 'hooksnippet', 'libs')

        for abi in ABIList:
            self.copytree(
                    os.path.join(self.hookLIB, abi),
                    os.path.join(APKlib, abi)
            )
            self.copytree(
                    os.path.join(hookTrigger,abi),
                    os.path.join(APKlib, abi)
            )
            
        # two pathes not same path to copy
        APKlib = os.path.join(self.targetAPKPath,'smali')

        for root, dirs, files in os.walk(self.hookSMALI):
            for file in files:
                if file.endswith('.smali'):
                    # try:
                        print(root,self.hookSMALI)
                        relativepath = root.replace(self.hookSMALI[1:],'')
                        print(relativepath)
                        src = os.path.join(root,file)
                        dst = os.path.join(APKlib, relativepath[2:], file) # escape the . 
                        logger.debug(f"[+] Copying hook framwork codes from {src} to {dst}")
                        if not os.path.exists(os.path.join(APKlib, relativepath[2:])):
                            os.makedirs(os.path.join(APKlib, relativepath[2:]))
                        shutil.copy(src, dst)
                    # except:
                    #     logger.warning(f"[!] The smali old file {os.path.join(root,file)} still exist")
                    #     if (input("Delete old files? (Y/N)")=='Y'):
                    #         # if need delet old files
                    #         # TODO
                    #         for file in self.hookSinppetSmali:
                    #             p = subprocess.Popen("rm -r "+ file, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
                    #             logger.debug(p.stdout.read())
                    #             p.wait()
                    #         shutil.copy(os.path.join(root,file), os.path.join(codePath,file))
                    #     pass
    
    
    def pathInvalid(self):
        """
        """
        pass
