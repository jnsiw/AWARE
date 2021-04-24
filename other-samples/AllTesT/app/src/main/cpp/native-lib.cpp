#include <jni.h>
#include <android/log.h>
#include <sys/mman.h>
#include <string>

extern "C" JNIEXPORT jstring JNICALL
Java_com_lody_whale_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

extern "C" JNIEXPORT void JNICALL
Java_com_lody_whale_MainActivity_retrieveArtMethod(
        JNIEnv* env,
        jobject /* this */){
    uint32_t* tmpvalue = (uint32_t*) env->GetMethodID(env->FindClass("com/lody/whale/MainActivity"), "controlCenter","()V");
    __android_log_print(ANDROID_LOG_INFO, "[ArtMethod]", "target index : 0x%d", *(tmpvalue+3));
    if(*tmpvalue!=78884){
        __android_log_print(ANDROID_LOG_ERROR,"[ArtMethod]", "detect attack");
    }

}

extern "C" JNIEXPORT void JNICALL
Java_com_lody_whale_SelfDecryptBased_SDCEXEsample(JNIEnv* env,
    jobject /* this */){
    /***
     * /hello.c:8
│           0x00000681      4889e5         mov rbp, rsp
│           0x00000684      4883ec30       sub rsp, 0x30               ; '0'
│           0x00000688      64488b042528.  mov rax, qword fs:[0x28]    ; [0x28:8]=0x1c20 ; '('
│           0x00000691      488945f8       mov qword [local_8h], rax
│           0x00000695      48b85b534443.  movabs rax, 0x646f63204344535b ; '[SDC cod'
│           0x0000069f      488945e8       mov qword [local_18h], rax
│           0x000006a3      c645f200       mov byte [local_eh], 0      ; hello.c:320
│           0x000006a7      66c745f0655d   mov word [local_10h], 0x5d65 ; 'e]'
│           0x000006ad      48b820576f72.  movabs rax, 0x21646c726f5720 ; ' World!'
│           0x000006b7      488945dd       mov qword [local_23h], rax
│           0x000006bb      48b848656c6c.  movabs rax, 0x6f57206f6c6c6548 ; 'Hello Wo'
│           0x000006c5      488945d8       mov qword [local_28h], rax
│           0x000006c9      31c9           xor ecx, ecx
│           0x000006cb      88ca           mov dl, cl
│           0x000006cd      bf03000000     mov edi, 3
│           0x000006d2      488d75e8       lea rsi, [local_18h]
│           0x000006d6      488d45d8       lea rax, [local_28h]
│           0x000006da      8855d7         mov byte [local_29h], dl
│           0x000006dd      4889c2         mov rdx, rax
│           0x000006e0      8a45d7         mov al, byte [local_29h]
                                           movabs rax, 0xffffffffffff ;
                                           call rax; old method-> │           0x000006e3      e808ffffff     call sym.imp.__android_log_print
│           0x000006e8      64488b142528.  mov rdx, qword fs:[0x28]    ; [0x28:8]=0x1c20 ; '('
│           0x000006f1      488b75f8       mov rsi, qword [local_8h]
│           0x000006f5      4839f2         cmp rdx, rsi
│           0x000006f8      8945d0         mov dword [local_30h], eax ;│       ┌─< 0x000006fb      0f8506000000   jne 0x707

│       │   0x00000701      4883c430       add rsp, 0x30               ; '0'
│       │   0x00000705      5d             pop rbp
│       │   0x00000706      c3             ret ;└       └─> 0x00000707      e8f4feffff     call sym.imp.__stack_chk_fail ; void __stack_chk_fail(void)

     */
     __android_log_print(ANDROID_LOG_DEBUG,"[SDC]","normal C");
     void *codeaddr = malloc(0x1000);

    unsigned long logaddr = (unsigned long)(__android_log_print);
    unsigned long codeaddrnum = 0x68+(unsigned long)(codeaddr);
    long offset = logaddr-codeaddrnum;//offset too big become negative :(

    unsigned char aimstring[7];
    for(int i=0; i<7; i++){
        aimstring[i] = logaddr&0xff;
        logaddr = logaddr>>8;
    }
    aimstring[3];
//    aimstring[4] = 0xe9;

//    __stack_chk_fail
//    char CODE[] = "\x55\x48\x89\xe5\x48\x83\xec\x30\x64\x48\x8b\x04\x25\x28\x00\x00\x00\x48\x89\x45\xf8\x48\xb8\x5b\x53\x44\x43\x20\x63\x6f\x64\x48\x89\x45\xe8\xc6\x45\xf2\x00\x66\xc7\x45\xf0\x65\x5d\x48\xb8\x20\x57\x6f\x72\x6c\x64\x21\x00\x48\x89\x45\xdd\x48\xb8\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x48\x89\x45\xd8\x31\xc9\x88\xca\xbf\x03\x00\x00\x00\x48\x8d\x75\xe8\x48\x8d\x45\xd8\x88\x55\xd7\x48\x89\xc2\x8a\x45\xd7\xe8\x08\xff\xff\xff\x64\x48\x8b\x14\x25\x28\x00\x00\x00\x48\x8b\x75\xf8\x48\x39\xf2\x89\x45\xd0\x0f\x85\x06\x00\x00\x00\x48\x83\xc4\x30\x5d\xc3\xe8\xf4\xfe\xff\xff";
    unsigned char CODE[] = "\x55\x48\x89\xe5\x48\x83\xec\x30\x64\x48\x8b\x04\x25\x28\x00\x00\x00\x48\x89\x45\xf8\x48\xb8\x5b\x53\x44\x43\x20\x63\x6f\x64\x48\x89\x45\xe8\xc6\x45\xf2\x00\x66\xc7\x45\xf0\x65\x5d\x48\xb8\x20\x57\x6f\x72\x6c\x64\x21\x00\x48\x89\x45\xdd\x48\xb8\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x48\x89\x45\xd8\x31\xc9\x88\xca\xbf\x03\x00\x00\x00\x48\x8d\x75\xe8\x48\x8d\x45\xd8\x88\x55\xd7\x48\x89\xc2\x8a\x45\xd7\x48\xb8\xff\xff\xff\xff\xff\xff\xff\x00\xff\xd0\x64\x48\x8b\x14\x25\x28\x00\x00\x00\x48\x8b\x75\xf8\x48\x39\xf2\x89\x45\xd0\x48\x83\xc4\x30\x5d\xc3";

    for(int i=0; i<7; i++){
        CODE[101+i] = aimstring[i];
        }
//    CODE[99]=aimstring[4];
    //movabs rax, 0xffffffffffff ;
    char tmplogaddr[] = "\x48\xb8\xff\xff\xff\xff\xff\xff\xff\x00";

    char canaryaddr[] = "\xe8\xf4\xfe\xff\xff";

    int codelen = 420;


    memcpy(codeaddr, CODE, codelen);

    mprotect(codeaddr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC);


    // offset reset

    ((void(*)(void))codeaddr)();


}

extern "C" JNIEXPORT jstring JNICALL
Java_com_lody_whale_PMSBased_Collatz(
        JNIEnv* env,
        jobject /* this */,
        jstring pubKey) {


}

//void SDCabout

//static JNINativeMethod gMethods[] = {
//        {""}
//
//};
//JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* reserved) {
//    JNIEnv* env;
//    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
//        return -1;
//    }
//
//    // Get jclass with env->FindClass.
//    // Register methods with env->RegisterNatives.
//
//    return JNI_VERSION_1_6;
//}