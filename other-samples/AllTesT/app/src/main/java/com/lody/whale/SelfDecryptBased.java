package com.lody.whale;

public class SelfDecryptBased {
    /**
     * self decrypt code based repackage-proofing methods
     * e.g. SDC <<Droidmarking: Resilient Software Watermarking for Impeding Android Application Repackaging>> ASE'14
     *
     * the following code will use  as exmaple.
     */
    static {
        System.loadLibrary("native-lib");
    }
    public void SDCTrigger(){
        SDCEXEsample();
    }

    public native void SDCEXEsample();
}
