/**
 * 
 */


package com.hook.mark;

import android.app.Application;
import android.content.Context;
import android.content.pm.PackageManager;
import android.util.Log;

import java.lang.reflect.Field;

public class PackageCodePathWraper {

    public static void hookAppDir() {
        
        try{
            Application App = (Application) Class.forName("android.app.ActivityThread")
                    .getMethod("currentApplication").invoke(null, (Object[]) null);
            Context ctx = App.getBaseContext();

            // get current mPackageInfo (loadedApk type)
            Field mPackageInfo = ctx.getClass().getDeclaredField("mPackageInfo");
            mPackageInfo.setAccessible(true);

            // get field mAppDir (which used by getPackageCodePath)
            Field mAppDir = mPackageInfo.getType().getDeclaredField("mAppDir");
            mAppDir.setAccessible(true);
            Log.d("[PackageCodePathWraper]","Original PackageCodePath:" + mAppDir.get(mPackageInfo.get(ctx)).toString());
            mAppDir.set(mPackageInfo.get(ctx),"/data/app/com.lody.whale-hook-success/base.apk");

            Log.d("[PackageCodePathWraper]","PackageCode  Path Hooked!");
        } catch (Exception e) {
            Log.e("[!]PackageCodePathWraper","detectionNode error");
            e.printStackTrace();
        }
    }
}