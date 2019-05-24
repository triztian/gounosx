
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

#import "bridge.h"

BOOL requestAuthorization(int options[], size_t optionsN) {

	BOOL *result = NULL;
	*result = NO;

	if (@available(macOS 10.14, *)) {
		UNAuthorizationOptions unOpts = UNAuthorizationOptionNone;

		for (size_t i = 0; i < optionsN; i++) {
			unOpts |= (UNAuthorizationOptions) options[i];
		}

		// TODO: Remove this line once it's tested
		unOpts = (UNAuthorizationOptionAlert | UNAuthorizationOptionSound);

		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

		[center 
				requestAuthorizationWithOptions: unOpts
				completionHandler:^(BOOL granted, NSError * _Nullable error) {
				// Enable or disable features based on authorization.
				*result = granted;
		}];
	}
	return *result;
}

BOOL getNotificationSettings(int *granted, int options[], int *optionsCount, char *error) {
	if (@available(macOS 10.14, *)) {
		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	}
	return YES;
}

BOOL registerNotificationCategories(Category categories[], int categoriesN) {
	if (@available(macOS 10.14, *)) {
		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

		for (size_t c = 0; c < categoriesN; c++) {

			UNNotificationCategory *category = [UNNotificationCategory 
				categoryWithIdentifier: @"UNIQUE_ID"
				actions: [NSMutableArray arrayWithCapacity: categories[c].actionsN]
				intentIdentifiers: [NSMutableArray arrayWithCapacity:0]
				options: categories[c].options
			];

			for (size_t a = 0; a < categories[c].actionsN; a++ ) {
				// UNNotificationAction *action = [[UNNotificationAction alloc]];
			}
		}
	}

	return NO;
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