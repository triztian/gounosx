package gounosx

// AuthorizationOption ...
type AuthorizationOption uint8

const (
	_ AuthorizationOption = iota
)

// Notifier ...
type Notifier struct {
}

// RequestPermission ...
func (n *Notifier) RequestPermission(option ...AuthorizationOption) (bool, error) {
	C.requestAuthorization();
}

// AuthorizationStatus ...
func (n *Notifier) AuthorizationStatus() (bool, []AuthorizationOption) {
	panic("not implemented")
}

// NotificationAction ...
type NotificationAction struct {
	ID      string
	Title   string
	Options []uint8
}

// NotificationCategory ...
type NotificationCategory struct {
	ID                            string
	Actions                       []NotificationAction
	HiddenPreviewsBodyPlaceholder string
	Options                       []uint8
}

// NotificationContent ...
type NotificationContent struct {
	Title      string
	Body       string
	UserInfo   map[string]string
	CategoryID string
}
