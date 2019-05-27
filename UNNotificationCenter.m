
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

void registerNotificationCategories(Category categories[], int categoriesN) {
	if (@available(macOS 10.14, *)) {
		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

		NSMutableSet *unCategories = [NSMutableSet setWithCapacity: categoriesN];
		for (size_t c = 0; c < categoriesN; c++) {

			NSMutableArray *categoryActions = [NSMutableArray arrayWithCapacity: categories[c].actionsN];

			for (size_t a = 0; a < categories[c].actionsN; a++ ) {

				UNNotificationActionOptions	actionOptions = UNNotificationActionOptionNone;

				for (size_t o = 0; o < categories[c].actions[a].optionsN; o++) {
					actionOptions |= (UNNotificationActionOptions)categories[c].actions[a].options;
				}

				UNNotificationAction *action = [UNNotificationAction 
					actionWithIdentifier: [NSString stringWithUTF8String: categories[c].actions[a].id]
					title: [NSString stringWithUTF8String: categories[c].actions[a].title]
					options: actionOptions
				]; 

				[categoryActions addObject: action];

			}

			UNNotificationCategory *category = [UNNotificationCategory 
				categoryWithIdentifier: [NSString stringWithUTF8String: categories[c].id]
				actions: categoryActions
				intentIdentifiers: [NSMutableArray arrayWithCapacity:0]
				options: categories[c].options
			];

			[unCategories addObject: category];
		}

		[center setNotificationCategories: unCategories];
	}

}

BOOL addNotificationRequest(void) {
	if (@available(macOS 10.14, *)) {

		UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
		content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
		content.body = [NSString localizedUserNotificationStringForKey:@"Hello_message_body"
			arguments:nil];
		content.sound = [UNNotificationSound defaultSound];

		// Deliver the notification in five seconds.
		UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
			triggerWithTimeInterval:5 repeats:NO];

		UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
			content:content trigger:trigger];
		
		// Schedule the notification.
		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
		[center addNotificationRequest:request withCompletionHandler: ^(NSError *error) {

		}];

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