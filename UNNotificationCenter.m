#import <UserNotifications/UserNotifications.h>

@interface OSXUserNotifications : NSObject

+ (void) requestAuth;

@end

@implementation OSXUserNotifications

+ (void) requestAuth {
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

	[center requestAuthorizationWithOptions:
			(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
			completionHandler:^(BOOL granted, NSError * _Nullable error) {
		// Enable or disable features based on authorization.
	}];
}

@end