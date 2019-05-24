package gounosx

import (
	"testing"
)

func Test_RequestAuthorization(t *testing.T) {

	notifier := new(Notifier)

	granted, err := notifier.RequestAuthorization(AuthorizationOptionAlert)
	if err != nil {
		t.Fatal(err)
	}

	if !granted {
		t.Fatal("Authorization no granted")
	}

}

func Test_RequestAuthorization(t *testing.T) {

	notifier := new(Notifier)

	granted, err := notifier.RequestAuthorization(AuthorizationOptionAlert)
	if err != nil {
		t.Fatal(err)
	}

	if !granted {
		t.Fatal("Authorization no granted")
	}

}
