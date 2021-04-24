package com.lody.whale;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.widget.TextView;

import java.math.BigInteger;
import java.util.ArrayList;


public class MainActivity extends AppCompatActivity {

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("native-lib");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        controlCenter();

        // Example of a call to a native method
        TextView tv = findViewById(R.id.sample_text);
        tv.setText(stringFromJNI());
    }

    public void controlCenter() {
//        //First try to get DeviceID
//        Context context = getApplicationContext();
//        TelephonyManager test = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
//            // TODO: Consider calling
//            //    ActivityCompat#requestPermissions
//            // here to request the missing permissions, and then overriding
//            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
//            //                                          int[] grantResults)
//            // to handle the case where the user grants the permission. See the documentation
//            // for ActivityCompat#requestPermissions for more details.
//            return;
//        }
//
////        Log.d("[Detection]", "Decive ID " + test.getDeviceId());
//        long num =  Long.parseLong(test.getDeviceId());
//        long implicitnum = 1;
//        while (num > 1){
//            if(num % 2 == 0){
//                num = num / 2;
//                implicitnum = implicitnum * 2;
//            } else {
//                num = 3 * num + 1;
//                implicitnum = implicitnum *3 + 1;
//            }
//            if (num == 1){
//                break;
//            }
//        }

//        Log.d("[Detection]", "Implicit Decive ID " + String.valueOf(implicitnum));
        // Testing for reflection protection scheme
        Log.d("[Detection]", "Begin to fetch package path");
        Log.d("[Detection]","PackageCodePath: " + getPackageCodePath());

        PMSBased tReflection = new PMSBased();
        // Using Collatz to convert the result

        // Transfer to the detection node

//        tReflection.detectionNodeRefelction2(String.valueOf(implicitnum));
//        tReflection.detectionNodeRefelction1();
        ArrayList<Long> timelist = new ArrayList<Long>();
        long startTime,endTime, timeElapsed;

        for(int i=0; i<100; i++){
            startTime = System.nanoTime();
            tReflection.detectionNodeRefelction1();
            endTime = System.nanoTime();
            timeElapsed = endTime - startTime;
            timelist.add(timeElapsed);
        }

        Log.d("[Time]","(Reflection) retrieve public key time: " + calcAverage(timelist));
        timelist.clear();

        tReflection = null;
        tReflection = new PMSBased();

        for(int i=0; i<100; i++){
            startTime = System.nanoTime();
            tReflection.detectionNodeNormal();
            endTime = System.nanoTime();
            timeElapsed = endTime - startTime;
            timelist.add(timeElapsed);
        }

        Log.d("[Time]","retrieve public key time: " + calcAverage(timelist));
        timelist.clear();

        tReflection = null;
        tReflection = new PMSBased();

        for(int i=0; i<100; i++) {
            startTime = System.nanoTime();
            tReflection.retrieveMANIFEST();
            endTime = System.nanoTime();
            timeElapsed = endTime - startTime;
            timelist.add(timeElapsed);
        }

        Log.d("[Time]", "retrieve MANIFST running time: " + calcAverage(timelist));
        timelist.clear();
        tReflection = null;
        tReflection = new PMSBased();

        for(int i=0; i<100; i++) {
            startTime = System.nanoTime();
            retrieveArtMethod();
            endTime = System.nanoTime();
            timeElapsed = endTime - startTime;
            timelist.add(timeElapsed);
        }

        Log.d("[Time]", "retrieve native running time: " + calcAverage(timelist));
        timelist.clear();
//        // Testing for SDC scheme
//        SelfDecryptBased SDCtype = new SelfDecryptBased();
//        SDCtype.SDCTrigger();
//


    }

    private double calcAverage(ArrayList<Long> marks){
        Long sum = Long.valueOf(0);
        if(!marks.isEmpty()) {
            for (Long mark : marks) {
                sum += mark;
            }
            return sum.doubleValue() / marks.size();
        }
        return sum;
    }

    /**
     * A native method that is implemented by the 'native-lib' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
    public native void retrieveArtMethod();
}
