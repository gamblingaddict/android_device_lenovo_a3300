#include <utils/Thread.h>
#include <log/log.h>

namespace android {

extern "C" status_t _ZN7android6Thread3runEPKcij (Thread* a, const char* b,
					int32_t c, size_t d);

extern "C" status_t _ZN7android6Bhread3runEPKcij (Thread* self, const char* name,
                                       int32_t priority, size_t stack) {
    if (name == nullptr) {
        __android_log_write(ANDROID_LOG_DEBUG, "utils_shim", "Thread name not provided to Thread::run");
        name = "0";
    }

    return _ZN7android6Thread3runEPKcij(self, name, priority, stack);
}

}
