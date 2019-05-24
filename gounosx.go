// +build darwin

package gounosx

import "time"

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
type Notifier struct{}

// RequestAuthorization ...
func (*Notifier) RequestAuthorization(options ...AuthorizationOption) (bool, error) {
	return requestAuthorization(options...)
}

// AuthorizationStatus ...
func (*Notifier) AuthorizationStatus() (bool, []AuthorizationOption) {
	// TODO: Determine what to do with error
	granted, options, _ := getNotificationSettings()
	return granted, options
}

// AddCategories ...
func (*Notifier) AddCategories(cats ...Category) <-chan Response {
	return nil
}

// Notify diplays the notification to the user once the deadline has been reached.
func (*Notifier) Notify(content Content, deadline time.Time) {
	panic("not implemented")
}

type ActionOption uint8

const (
	ActionOptionNone ActionOption = iota
	ActionOptionAuthenticationRequired
	ActionOptionDestructive
	ActionOptionForeground
)

// Action ...
type Action struct {
	ID      string
	Title   string
	Options []ActionOption
}

type CategoryOption uint8

const (
	CategoryOptionNone CategoryOption = iota
	CategoryOptionCustomDismissAction
	CategoryOptionCategoryOptionAllowInCarPlay
	CategoryOptionHiddenPreviewsShowTitle
	CategoryOptionHiddenPreviewsShowSubtitle
)

// Category ...
type Category struct {
	ID                            string
	Actions                       []Action
	HiddenPreviewsBodyPlaceholder string
	Options                       []CategoryOption
}

// Content ...
type Content struct {
	Title      string
	Body       string
	UserInfo   map[string]string
	CategoryID string
}

// Response ...
type Response struct {
	ActionID string
	UserInfo map[string]string
}
