#include <android/log.h>

void hello(){
    const char tag[] = "[SDC code]";
    const char a[] = "Hello World!";
    __android_log_print(ANDROID_LOG_DEBUG, tag, a);
}
