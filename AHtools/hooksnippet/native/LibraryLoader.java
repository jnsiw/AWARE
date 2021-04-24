/**
 * Original created by jiangwei1-g on 2016/9/7 in kstools.
 */


package com.hook.mark;

import android.util.Log;

public class LibraryLoader {

    static {
        System.loadLibrary("hooking");
    }

    public static void loadStart() {
        new LibraryLoader().Hooking();
        Log.i("[Native Hook Codes]", "hook succ");
    }

    public native void Hooking();
}