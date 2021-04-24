#! /usr/bin/env python3 
import os
import binascii
import subprocess
from xml.dom.minidom import parseString

import logging

logger = logging.getLogger(name=__name__)

class APKHandler:
    
    def __init__(self, pathes):
        self.apktool = pathes['apktool_path']
        self.apksigner = pathes['apksigner_path']
        self.filePath = pathes['target_path']
        self.keyStore = pathes['keystore_path']
        self.tmpPath = pathes['tmp_path']
        self.keyStorePass = str.encode(pathes['keystore_pass'])

        self.signature = self.packageName = self.apkname = self.targetAPKPath = self.tmpRepackAPKPath = None

        self.realPackagePath = self.dalvikEntry = self.nativeEntry = None

        self.apkUnpack()
        self.dalvikEntryFinder()
        self.signatureExtrace()
    
    def apkUnpack(self):
        """ Using apktool unzip the apk file
        
        get the smali files
        """
        # mkdir tmp
        apkname = os.path.split(self.filePath)[-1].split('.')[0] 
        targetAPKPath = os.path.join(self.tmpPath, apkname)
        self.apkname = apkname
        self.targetAPKPath = targetAPKPath

        if not os.path.exists(self.tmpPath):
            logger.info(f"[+] Creating tmp path {self.tmpPath}")
            subprocess.Popen(["mkdir", self.tmpPath])
        if os.path.exists(targetAPKPath):
            logger.warning(f"[!] Old file {targetAPKPath} still exist")
            if (input("Delet old files? (Y/N)")=='Y'):
                # if need delet old files
                subprocess.Popen("rm -r " + targetAPKPath, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
                
        # apktool d name.apk
        logger.info(f"[+] Unzipping the apk file {self.filePath}")
        p = subprocess.Popen([self.apktool, "d", self.filePath, "-o", targetAPKPath], stdout=subprocess.PIPE)
        logger.debug(p.stdout.read().decode())
        p.wait()

    def pathInvalid(self):
        if not os.path.exists(self.targetAPKPath):
            logger.error("[!] APK still not unzip")
            return True
        else:
            return False

    def signatureExtrace(self):
        """ Extrace the signature
            find from .RSA
            return sign
        """
        if self.pathInvalid():
            return 1
        # path get CERT.SF
        signPath = os.path.join(self.targetAPKPath, "original", "META-INF")
        for file in os.listdir(signPath):
            if file.endswith(".RSA") or file.endswith(".DSA"):                
                with open(os.path.join(signPath, file),'rb') as f:
                    sign = binascii.hexlify(f.read()).decode('ascii')
                self.signature = sign[0x3c*2:] # from java read
                #TODO delete this
                self.signature = self.signature[:266]+ 'deadbeef'*8 + self.signature[266+64:]
                return 0
        
    
    def getMainActivity(self, activities):
        """ Search MainActivity entry from activities in the xml
        """
        for activity in activities:
            tmpactivity = activity.getAttribute('android:name')
            intents = activity.getElementsByTagName('intent-filter')
            for intent in intents:
                actions = intent.getElementsByTagName('action')
                for action in actions:
                    if action.getAttribute('android:name') == 'android.intent.action.MAIN':
                        # Find the real Entry. Example: Discord using constructor to call
                        if "$" in tmpactivity:
                            tmpactivity = tmpactivity.split('$')[0]
                        # support for multidex smali (start with smali)
                        for dirName in os.listdir(self.targetAPKPath):
                            if dirName.startswith("smali"):
                                self.dalvikEntry = os.path.join(self.targetAPKPath, dirName, *tmpactivity.split('.')) + ".smali"
                                # Check whether path exist
                                print(self.dalvikEntry)
                                if not os.path.exists(self.dalvikEntry):
                                    continue
                                else:
                                    break
                        self.realPackagePath = tmpactivity[:tmpactivity.rfind('.')]
                        logger.debug(f"MainActivity smali file path is:{self.dalvikEntry}")
                        return 1


    def dalvikEntryFinder(self):
        """ Find the dalvik entry
            return enterActivityName
        """
        # path get smali
        # Find from the xml file
        if self.pathInvalid():
            return 1

        with open(os.path.join(self.targetAPKPath,'AndroidManifest.xml'),'r') as f:
            data = f.read()
        dom = parseString(data) 

        # Get pakcage name
        manifests = dom.getElementsByTagName('manifest')
        for manifest in manifests:
            tmppackagename = manifest.getAttribute('package')
        self.packageName = tmppackagename

        # Get MainActivity entry
        activities = dom.getElementsByTagName('activity')
        self.getMainActivity(activities)
        
        # if defined in alias
        # Found in snapchat
        activities = dom.getElementsByTagName('activity-alias')
        self.getMainActivity(activities)

    def nativeEntryFinder(self):
        """ Find the native entry
            load native
            (we use the oncreate entry now, will change to program original native entry for stealthy in future)
        """
        # TODO native path get smali
        # if no native entry
        # if :
            # return None
        pass

    def apkPacking(self):
        """ using apktool 

        """
        if self.pathInvalid():
            return 1
            
        self.tmpRepackAPKPath = os.path.join(self.tmpPath, self.apkname+"-repacked.apk")
        logger.debug(f"[+] Packing the apk dir {self.targetAPKPath} to {self.tmpRepackAPKPath}")

        # apktool b name -o name-repacked.apk
        p = subprocess.Popen([self.apktool, "b", self.targetAPKPath, "-o", self.tmpRepackAPKPath], stdout=subprocess.PIPE)
        logger.debug(p.stdout.read().decode())
        p.wait()

        # TODO check Exception
        if "Unsigned short value out of range" in p.stdout.read():
            pass

    def apkSign(self):
        """ using apksign
        """
        if not os.path.exists(self.tmpRepackAPKPath):
            logger.error("[!] Repacked APK not exist")
            return 1

        logger.debug(f"[+] Signing the apk dir {self.tmpRepackAPKPath}")
        logger.debug("[+] Please input keystore password")
        # apksigner sign --ks app-repack.keystore --out name-repacked-signed.apk name-repacked.apk
        p = subprocess.Popen([self.apksigner, "sign", "--ks", self.keyStore, "--out", self.tmpRepackAPKPath.split('.apk')[0]+"-signed.apk", self.tmpRepackAPKPath], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
        logger.debug(p.communicate(input=self.keyStorePass))
        p.wait()

    @property
    def getTargetAPKPath(self):
        return self.targetAPKPath

    @property
    def getDalvikEntry(self):
        return self.dalvikEntry

    @property
    def getPackageName(self):
        return self.packageName

    @property
    def getSignature(self):
        return self.signature
    
    @property
    def getRealPackagePath(self):
        return self.realPackagePath

if __name__ == "__main__":
    with open("./configs/config.js") as f:
        pathes = json.loads(f.read())
    APKHandler(pathes,"./samples/test.apk")