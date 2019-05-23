package gounosx

/*
#cgo CFLAGS: -mmacosx-version-min=10.10 -D__MAC_OS_X_VERSION_MAX_ALLOWED=101400
#cgo LDFLAGS: -framework UserNotifications -framework Foundation

#include <objc/runtime.h>

int requestAuthorization(int options[]) {
	void* cls = objc_getClass("OSXUserNotifications");

	return 0;
}
*/
import "C"

// requestAuthorization ...
func requestAuthorization(options ...AuthorizationOption) (bool, error) { 

	cOpts := make([]C.int, len(options))
	for i := range options {
		cOpts[i] = C.int(options[i])
	}

	granted := C.requestAuthorization(&cOpts[0])

	return int(granted) == 1, nil
}