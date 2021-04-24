#! /usr/bin/env python3 
import os
import json

from core.APKHandler import APKHandler
from core.HookHandler import HookHandler
from fornative import NativeHookHandler

import logging

logger = logging.getLogger(name=__name__)


class TotalController:
    """ Control for all 
        1. read config files (for using commands)
        2. unzip the apk file (apktool)
            2.1 extract signature information
            2.2 extract apk entry - for insert hook snippet
            2.3 extract native lib entry  - for insert hook snippet
        3. generate hook smali snippet (for insert the target apk)
            3.1 attack mode  - using original signature
            3.1 test mode - using simple strings 
            3.2 java 2 smali (javac dx.jar baksmali.smali)
        4. insert hooking snippet into apk file (fordalvik)
        5. zip the apk file
    """

    def __init__(self, configPath="./configs/config.json", mode="attack"):
        """
        Args:
            filepath: config file's path
        """
        self.dx = None
        self.javac = None
        self.pathes = None

        self.configPath = configPath
        self.mode = (mode == "attack") # True for attack mode; False for test mode;
        self._prevHandle()
        self.hookHandle()
        self.packingHandle()

    def _prevHandle(self):
        """ Handle fo the commands
            1. unpack APK
            2. getAPK information

        """
        with open(self.configPath) as f:
            self.pathes = json.loads(f.read())
        self.apkhandler = APKHandler(self.pathes)

        self.pathes["APK_target_path"] = self.apkhandler.getTargetAPKPath
        self.pathes["APK_package_name"] = self.apkhandler.getPackageName
        self.pathes["APK_signature"] = self.apkhandler.getSignature
        self.pathes["APK_dalvikEntry_path"] = self.apkhandler.getDalvikEntry
        self.pathes["APK_real_package_name"] = self.apkhandler.getRealPackagePath
        
        

    def hookHandle(self):
        """ For the hook snippet generating
            1. generating smali hook code
            2. replace signature code (optional)

        """
        ## public key version
        hookhandler = HookHandler(self.mode, self.pathes) 
        hookhandler.hookSnippetGenerating()
        hookhandler.codeSignReplacing()
        hookhandler.hookSnippetInjecting()
        hookhandler.hookSnippetCombining()
        ## native mode
        # nativehookhandler = NativeHookHandler(self.mode, self.pathes)
        # nativehookhandler.nativeInvokeEntryConstruct()
        # nativehookhandler.nativeHookSnippetReConstruct()
        # nativehookhandler.nativeHookSnippetGenerating()
        # nativehookhandler.hookFrameworkInject()
        pass

    def InsertHandle(self):
        """

        """
        pass
    
    def packingHandle(self):
        self.apkhandler.apkPacking()
        self.apkhandler.apkSign()
        pass


if __name__ == "__main__":
    logging.basicConfig()
    logging.getLogger('core.APKHandler').setLevel('DEBUG')
    logging.getLogger('fornative').setLevel('DEBUG')
    tmp = TotalController("./configs/config.json")
