package gounosx

// AuthorizationOption ...
type AuthorizationOption uint8

// Authorization options
const (
	_ AuthorizationOption = iota
	AuthorizationOptionAlert
	AuthorizationOptionBadge
	AuthorizationOptionSound
)

// Notifier ...
type Notifier struct {}

// RequestAuthorization ...
func (*Notifier) RequestAuthorization(options ...AuthorizationOption) (bool, error) {
	return requestAuthorization(options...)
}

// AuthorizationStatus ...
func (*Notifier) AuthorizationStatus() (bool, []AuthorizationOption) {
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
