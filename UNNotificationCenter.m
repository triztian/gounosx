
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

BOOL requestAuthorization(int options[]) {

	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

	BOOL *result = NO;
	[center requestAuthorizationWithOptions:
			(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
			completionHandler:^(BOOL granted, NSError * _Nullable error) {
			// Enable or disable features based on authorization.
			*result = granted;
	}];

	return *result;

}

BOOL getNotificationSettings(int *granted, int options[], int *optionsCount, char *error) {
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	return YES;
}

// ---------

/**
	Proxy object
*/
// @interface OSXUserNotifications : NSObject

// + (BOOL) requestAuthorizationWithOptions: (int[]);

// + (NotificationSettings) getNotificationSettings;

// @end

// @implementation OSXUserNotifications

// + (BOOL) requestAuthorizationWithOptions: (int[]) options {

// 	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

// 	BOOL *granted;
// 	@synchronized(granted) {
// 		[center requestAuthorizationWithOptions:
// 				(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
// 				completionHandler:^(BOOL granted, NSError * _Nullable error) {
// 				// Enable or disable features based on authorization.
// 		}];
// 	}

// 	return *granted;
// }

// + (NotificationSettings) getNotificationSettings() {
// 	return NotificationSettings{};
// }

// @end