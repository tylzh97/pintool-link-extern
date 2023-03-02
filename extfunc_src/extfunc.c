#include "rhruntime.h"
#include <time.h>
#include <string.h>


char global[0xfffffff] = "Hello World!";

char* rhtest() {
    char *ret;
    time_t now = time(NULL);
    struct tm *tm_now = localtime(&now);
    char datetime_str[20];
    strftime(datetime_str, sizeof(datetime_str), "%Y-%m-%d %H:%M:%S", tm_now);
    ret = (char*)malloc(0xffff);
    snprintf(ret, 0xffff, "[RH Runtime]: %s -- %s", datetime_str, global);
    return ret;
}
