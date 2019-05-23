package gounosx

/*
#cgo CFLAGS: -framework UserNotifications -framework Foundation
#include <objc/runtime.h>

int requestAuthorization() {
	void* cls = objc_getClass("OSXUserNotifications");
	return 0;
}
*/
import "C"