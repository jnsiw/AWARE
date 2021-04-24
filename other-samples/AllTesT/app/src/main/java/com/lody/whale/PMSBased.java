package com.lody.whale;

import android.app.Application;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import android.content.pm.Signature;

import java.security.PublicKey;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import java.util.Map;
import java.util.jar.Attributes;
import java.util.jar.JarFile;
import java.util.jar.Manifest;

public class PMSBased {
    /**
     * PackageManager service based repackage-proofing methods
     * e.g.
     *      SSN <<Repackage-proofing Android Apps>> DSN'16
     *      BOMBDROID <<Resilient Decentralized Android Application Repackaging Detection Using Logic Bombs>> CGO'18
     *
     * the following codes will use SSN as example
     */

    public void detectionNodeNormal(){
        /**
         * the normal version (without reflection)
         */
        try{
            Application App = (Application) Class.forName("android.app.ActivityThread")
                    .getDeclaredMethod("currentApplication").invoke(null, (Object[]) null);
            Context ctx = App.getBaseContext();

            PackageInfo packageInfo = ctx.getPackageManager().getPackageInfo(ctx.getPackageName(),
                    PackageManager.GET_SIGNATURES);

            Signature[] signatures = packageInfo.signatures;
            byte[] sig = signatures[0].toByteArray();
            CertificateFactory ctFty = CertificateFactory.getInstance("X.509");
            X509Certificate cert = (X509Certificate) ctFty.generateCertificate(new ByteArrayInputStream(sig));
//            PublicKey pubKey = cert.getPublicKey();
            String pubkey =  cert.getPublicKey().toString();
//            Log.i("[+]","Public Key: " + pubKey.toString());
        } catch (Exception e) {
            Log.e("[!]detectionNodeNormal","detectionNode error");
            e.printStackTrace();
        }
//        try{
//            Application App = (Application) Class.forName("android.app.ActivityThread")
//                    .getMethod("currentApplication").invoke(null, (Object[]) null);
//            Context ctx = App.getBaseContext();
//
//            // get current mPackageInfo (loadedApk type)
//            Field mPackageInfo = ctx.getClass().getDeclaredField("mPackageInfo");
//            mPackageInfo.setAccessible(true);
//
//            // get field mAppDir (which used by getPackageCodePath)
//            Field mAppDir = mPackageInfo.getType().getDeclaredField("mAppDir");
//            mAppDir.setAccessible(true);
//            mAppDir.set(mPackageInfo.get(ctx),"/data/app/com.hook.success/base.apk");
//
//        } catch (Exception e) {
//            Log.e("[!]detectionNodeNormal","detectionNode error");
//            e.printStackTrace();
//        }

    }

    public void detectionNodeRefelction1(){
//        Log.d("[+]","Begin to fetch public key");
        /**
         * get signature
         */
        byte[] sig = null;
        try{
            // getApplication().getApplicationContext()
            Application App = (Application) Class.forName("android.app.ActivityThread")
                    .getMethod("currentApplication").invoke(null, (Object[]) null);
            Object ctx = App.getApplicationContext();
            // PackageManager packageManager = getPackageManager();
            Method getPackageManager = Class.forName(Context.class.getName()).getDeclaredMethod("getPackageManager");
            Object pm = getPackageManager.invoke(ctx);
            // String packageName = getPackageName()
            Method getPackageName = Class.forName(Context.class.getName()).getDeclaredMethod("getPackageName");
            String pname = (String) getPackageName.invoke(ctx);
            // PackageInfo packageInfo = packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES);
            Method getPackageInfo = pm.getClass().getDeclaredMethod("getPackageInfo", String.class, int.class);
            Class<?> PackageManager =  Class.forName("android.content.pm.PackageManager");
            Field GET_SIGNATURES = PackageManager.getDeclaredField("GET_SIGNATURES");
            Object pinfo = getPackageInfo.invoke(pm, pname, GET_SIGNATURES.getInt(null));
            // Signatures[] signatures = packageInfo.signatures;
            Field signatures = pinfo.getClass().getDeclaredField("signatures");
            Signature[] signs = (Signature[]) signatures.get(pinfo);
            // String signature = signatures[0].toCharsString();
            sig = signs[0].toByteArray();
            // debug
//            Log.i("[+]","App Cert: " + signs[0].toCharsString());
        } catch (Exception e) {
            Log.e("[!]ReflectionBased.detectionNodeRefelction1","detectionNode error");
            e.printStackTrace();
        }

        /**
         *  extract public key from signature
         */
        String pubKey = null;
        try {
            // CertificateFactory ctFty = CertificateFactory.getInstance("X.509");
            Class<?> CertificateFactory =  Class.forName("java.security.cert.CertificateFactory");
            Method getInstance = CertificateFactory.getDeclaredMethod("getInstance", String.class);
            Object ctFty = getInstance.invoke(CertificateFactory,"X.509");
            // X509Certificate cert = (X509Certificate) ctFty.generateCertificate(new ByteArrayInputStream(sig));
            Method generateCertificate = ctFty.getClass().getDeclaredMethod("generateCertificate", InputStream.class);
            Object cert = generateCertificate.invoke(ctFty, new ByteArrayInputStream(sig));
            // pubKey = cert.getPublicKey().toString();
            Method getPublicKey = cert.getClass().getDeclaredMethod("getPublicKey");
            pubKey = (String) getPublicKey.invoke(cert).toString();
//            Log.i("[+]","Public Key: " + pubKey);
        } catch (Exception e)  {
            Log.e("[!]ReflectionBased.detectionNodeRefelction1","detectionNode error");
            e.printStackTrace();
        }

        /**
         * compare with part of the original one
         */
//        String keySub = pubKey.substring(1,4);
//        if (!keySub.equals("pen")){
//            SenderCommunicationChannel();
//        }


    }

    public void detectionNodeRefelction2(String implicitnum){
        Log.d("[+]ReflectionBased", "We got the implicitNum: "+implicitnum);
    }

    public void SenderCommunicationChannel(){
        Log.d("[+]ReflectionBased.SenderCommunicationChannel","Start!");

        /**
         * modify R class
         */
        Class<R.drawable> test = R.drawable.class;

        Field field = null;
        try {
            field = test.getDeclaredField("notification_bg_low_normal");
            Log.i("[Rclass]", field.get(null).toString());
            field.setAccessible(true);
            field.set(test,233);
            Log.i("[Rclass After] ", field.get(null).toString());
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public void respondNode(){
        //TODO UI change
        Log.d("[+]ReflectionBased.respondNode","Start!");


    }

    public void retrieveMANIFEST(){
        // getApplication().getApplicationContext()
        try {
        Application App = (Application) Class.forName("android.app.ActivityThread")
                .getMethod("currentApplication").invoke(null, (Object[]) null);
        Context ctx = App.getApplicationContext();
        // Get Package Name
//        String packageName = ctx.getPackageName();

        // Get classes.dex file signature
        ApplicationInfo ai = ctx.getApplicationInfo();
        String source = ai.sourceDir;

        JarFile jar = new JarFile(source);
        Manifest mf = jar.getManifest();

        Map<String, Attributes> map = mf.getEntries();

        Attributes a = map.get("classes.dex");

        String sha256 = (String) a.getValue("SHA-256-Digest");

//        Log.i("[MANIFEST.MF] ", sha256);
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public void callWithCollatz(){
        /**
         * 1. get publickey
         * 2. call native method
         *
         */

    }
}
