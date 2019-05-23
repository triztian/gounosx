
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

/**
	Proxy object
*/
@interface OSXUserNotifications : NSObject

+ (BOOL) requestAuthorizationWithOptions: (int[]) options;

@end

@implementation OSXUserNotifications

+ (BOOL) requestAuthorizationWithOptions: (int[]) options {

	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

	[center requestAuthorizationWithOptions:
			(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
			completionHandler:^(BOOL granted, NSError * _Nullable error) {
			// Enable or disable features based on authorization.
	}];

	return true;
}

@end