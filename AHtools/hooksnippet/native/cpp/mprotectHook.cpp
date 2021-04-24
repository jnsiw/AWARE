#include <jni.h>
#include <android/log.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <stdio.h>
#include "whale.h"
#include <stdlib.h>
#include <string>

#define LOG_TAG "[Hook code]"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

// bool mark = false;

void mapsOutput(){
	char	*s;
    unsigned long	 start;
    unsigned long	 end;

    FILE *fp;
    fp = fopen("/proc/self/maps", "r");
    if(fp!=NULL)
    {
        char line [ 2048 ];
        while ( fgets (line, sizeof line, fp ) != NULL ) /* read a line */
        {
           LOGD("[+] %s", line);
            //libdvm.so
            if (strstr(line, "libnative-lib.so") != NULL
                        or strstr(line, "/system/lib/libart.so") != NULL)
            {

                    s = strchr(line, '-');
                    if (s == NULL)
                        LOGD(" Error: string NULL");
                    *s++ = '\0';

                    start = strtoul(line, NULL, 16);
                    end = strtoul(s, NULL, 16);
                   // LOGI("Normal mprotect(start=%lx, len=%x, prot=%d)", start, end-start, PROT_READ|PROT_WRITE|PROT_EXEC);
                    // mprotect((void *) PAGE_START(CLEAR_BIT0(start)), end-start, PROT_READ|PROT_WRITE|PROT_EXEC);

                }
            }
        }
        fclose (fp);
}

bool inHeap(size_t addr){
    	char	*s;
    unsigned long	 start;
    unsigned long	 end;

    // LOGD("[o] inHeap?");
    FILE *fp;
    fp = fopen("/proc/self/maps", "r");
    if(fp!=NULL)
    {
        char line [ 2048 ];
        while ( fgets (line, sizeof line, fp ) != NULL ) /* read a line */
        {
            //libdvm.so
            if (strstr(line, "libc_malloc") != NULL
                        or strstr(line, "heap") != NULL)
            {
                    s = strchr(line, '-');
                    if (s == NULL)
                        LOGD(" Error: string NULL");
                    *s++ = '\0';
                    start = strtoul(line, NULL, 16);
                    end = strtoul(s, NULL, 16);
                    // LOGD("start=0x%llx,end=0x%llx",start,end);
                    if (start <= addr && addr <= end){
                        fclose(fp);
                        return true;
                    }
                }
            }
        }
        fclose (fp);
        return false;

}


int *(*Origin_mprotect)(void *, size_t , int );

int *Hooked_mprotect(void *addr, size_t len, int prot){
    char pro[4] = "---";
    pro[0] = (pro[0]&prot)?'r':'-';
    pro[1] = (pro[1]&prot)?'w':'-';
    pro[2] = (pro[2]&prot)?'x':'-';
    LOGD("Hooked mprotect(start=0x%llx, len=0x%llx, prot=%s)", (size_t)addr, len, pro);

    if (inHeap((size_t)addr) && pro[2]=='x'){
        LOGD("[o] Addr %llx is in HEAP", (size_t)addr);
        // mark = true;
    }
    int *(*O)(void *, size_t, int) = Origin_mprotect;
    return O(addr, len, prot);
}

// void *(*Origin_memcpy)(void *, const void *, size_t);

// void *Hooked_memcpy(void *restrict dst, const void *restrict src, size_t n){
//     LOGD("Hooked memcpy(source=0x%llx, destination=0x%llx, size=%s)", (size_t)dst, src, n);
// }

extern "C" JNIEXPORT void JNICALL
Java_com_hook_mark_LibraryLoader_Hooking(JNIEnv *env,
        jobject src/* this */) {
    mapsOutput();

    void* test = (void *)malloc(0x1000);// call -> plt bind
    mprotect(test, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC);
    free(test);

   	WInlineHookFunction((void *) mprotect, reinterpret_cast<void *>(Hooked_mprotect),
                       reinterpret_cast<void **>(&Origin_mprotect));
    LOGD("[!] HOOK COMPLETE");
}

// TODO Use JNI_ONLOAD to load function codes (but could be more codes)
