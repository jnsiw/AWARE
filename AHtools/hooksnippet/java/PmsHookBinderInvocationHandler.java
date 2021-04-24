/**
 * Original created by jiangwei1-g on 2016/9/7 in kstools.
 */


package com.hook.mark;

import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Log;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;


public class PmsHookBinderInvocationHandler implements InvocationHandler {

    private Object base;

    //correct signature
    private String SIGN;
    private String appPkgName = "";

    public PmsHookBinderInvocationHandler(Object base, String sign, String appPkgName, int hashCode) {
        try {
            this.base = base;
            this.SIGN = sign;
            this.appPkgName = appPkgName;
        } catch (Exception e) {
            Log.d("[Hoook Codes]", "error:" + Log.getStackTraceString(e));
        }
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        if ("getPackageInfo".equals(method.getName())) {
            String pkgName = (String) args[0];
            Integer flag = (Integer) args[1];
            if (flag == PackageManager.GET_SIGNATURES && appPkgName.equals(pkgName)) {
                Signature sign = new Signature(SIGN);
                PackageInfo info = (PackageInfo) method.invoke(base, args);
                info.signatures[0] = sign;
                Thread.dumpStack();
                return info;
            }
        }
        return method.invoke(base, args);
    }

}
