// +build darwin

package gounosx

/*
#cgo darwin CFLAGS: -mmacosx-version-min=10.10 -D__MAC_OS_X_VERSION_MAX_ALLOWED=101400
#cgo darwin CFLAGS: -Wunguarded-availability-new
#cgo darwin LDFLAGS: -framework UserNotifications -framework Foundation

int requestAuthorization(int[]);
int getNotificationSettings(int*, int[], int*, char*);
*/
import "C"
import (
	"errors"
)

// requestAuthorization ...
func requestAuthorization(options ...AuthorizationOption) (bool, error) { 

	cOpts := make([]C.int, len(options))
	for i := range options {
		cOpts[i] = C.int(options[i])
	}

	return int(C.requestAuthorization(&cOpts[0])) == 1, nil
}

// getNotificationSettings ...
func getNotificationSettings() (bool, []AuthorizationOption, error) {
	var options []AuthorizationOption

	var (
		cGranted *C.int
		cOpts []C.int
		cOptsLen *C.int
		cErr *C.char
	)

	if int(C.getNotificationSettings(cGranted, &cOpts[0], cOptsLen, cErr)) != 1 {
		return false, options, errors.New(C.GoString(cErr))
	}

	for i := 0; i < int(*cOptsLen); i++ {
		options = append(options, AuthorizationOption(int(cOpts[i])))
	}

	return int(*cGranted) == 1, options, nil
}