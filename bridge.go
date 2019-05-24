// +build darwin

package gounosx

/*
#cgo darwin CFLAGS: -mmacosx-version-min=10.10 -D__MAC_OS_X_VERSION_MAX_ALLOWED=101400 -Wunguarded-availability-new
#cgo darwin LDFLAGS: -framework UserNotifications -framework Foundation

#include "bridge.h"

int requestAuthorization(int[], int);
int getNotificationSettings(int*, int[], int*, char*);
void registerNotificationCategories(Category[], int);
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

	return int(C.requestAuthorization(&cOpts[0], C.int(len(options)))) == 1, nil
}

// getNotificationSettings ...
func getNotificationSettings() (bool, []AuthorizationOption, error) {

	var options []AuthorizationOption

	var (
		cGranted *C.int
		cOpts    []C.int
		cOptsLen *C.int
		cErr     *C.char
	)

	if int(C.getNotificationSettings(cGranted, &cOpts[0], cOptsLen, cErr)) != 1 {
		return false, options, errors.New(C.GoString(cErr))
	}

	for i := 0; i < int(*cOptsLen); i++ {
		options = append(options, AuthorizationOption(int(cOpts[i])))
	}

	return int(*cGranted) == 1, options, nil

}

// registerNotificationCategories ...
func registerNotificationCategories(cc ...Category) {

	cCats := make([]C.Category, len(cc))

	for _, c := range cc {
		cCat := C.Category{
			id:                            C.CString(c.ID),
			hiddenPreviewsBodyPlaceholder: C.CString(c.HiddenPreviewsBodyPlaceholder),
		}

		for i := range c.Options {
			cCat.options |= C.int(c.Options[i])
		}

		if len(c.Actions) > 0 {
			cActs := (*[1 << 28]C.Action)(C.malloc(C.size_t(C.sizeof_Action * len(c.Actions))))
			cCat.actionsN = C.size_t(len(c.Actions))

			for i := range c.Actions {
				act := C.Action{
					id:    C.CString(c.Actions[i].ID),
					title: C.CString(c.Actions[i].Title),
				}
				cActs[i] = act
			}

			cCat.actions = &cActs[0]
		}

		cCats = append(cCats, cCat)
	}

	C.registerNotificationCategories(&cCats[0], C.int(len(cc)))

}

func toCInts(nn ...uint8) ([]C.int, C.int) {

	ns := make([]C.int, len(nn))
	for i := range nn {
		ns[i] = C.int(nn[i])
	}

	return ns, C.int(len(nn))
}
