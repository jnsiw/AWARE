/**
 * Original created by jiangwei1-g on 2016/9/7 in kstools.
 */


package com.hook.mark;

import android.content.Context;
import android.content.pm.PackageManager;
import android.util.Log;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class ServiceManagerWraper {

    public static void hookPMS(Context context, String signed, String appPkgName, int hashCode) {
        try {
            // 
            Class<?> activityThreadClass = Class.forName("android.app.ActivityThread");
            Method currentActivityThreadMethod =
                    activityThreadClass.getDeclaredMethod("currentActivityThread");
            Object currentActivityThread = currentActivityThreadMethod.invoke(null);
            // 
            Field sPackageManagerField = activityThreadClass.getDeclaredField("sPackageManager");
            sPackageManagerField.setAccessible(true);
            Object sPackageManager = sPackageManagerField.get(currentActivityThread);
            // 
            Class<?> iPackageManagerInterface = Class.forName("android.content.pm.IPackageManager");
            Object proxy = Proxy.newProxyInstance(
                    iPackageManagerInterface.getClassLoader(),
                    new Class<?>[]{iPackageManagerInterface},
                    new PmsHookBinderInvocationHandler(sPackageManager, signed, appPkgName, 0));
            // 
            sPackageManagerField.set(currentActivityThread, proxy);
            // 
            PackageManager pm = context.getPackageManager();
            Field mPmField = pm.getClass().getDeclaredField("mPM");
            mPmField.setAccessible(true);
            mPmField.set(pm, proxy);
        } catch (Exception e) {
            Log.d("jw", "hook pms error:" + Log.getStackTraceString(e));
        }
    }

    public static void hookPMS(Context context) {
        
        String newSign = "signature_have_been_hooked"; // Could be replaced with the right signature
        hookPMS(context, newSign, "com.hook.mark", 0);
        Log.i("[Hook Codes]", "hook succ");
    }

}