#line 1 "Tweak.x"

#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UNPushNotificationRequestBuilder; 
static UNPushNotificationRequestBuilder* (*_logos_orig$_ungrouped$UNPushNotificationRequestBuilder$initWithIdentifier$payload$bundleIdentifier$)(_LOGOS_SELF_TYPE_INIT UNPushNotificationRequestBuilder*, SEL, id, id, id) _LOGOS_RETURN_RETAINED; static UNPushNotificationRequestBuilder* _logos_method$_ungrouped$UNPushNotificationRequestBuilder$initWithIdentifier$payload$bundleIdentifier$(_LOGOS_SELF_TYPE_INIT UNPushNotificationRequestBuilder*, SEL, id, id, id) _LOGOS_RETURN_RETAINED; 

#line 1 "Tweak.x"

static UNPushNotificationRequestBuilder* _logos_method$_ungrouped$UNPushNotificationRequestBuilder$initWithIdentifier$payload$bundleIdentifier$(_LOGOS_SELF_TYPE_INIT UNPushNotificationRequestBuilder* __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3) _LOGOS_RETURN_RETAINED {
  	if([arg3 isEqualToString:@"com.toyopagroup.picaboo"]){


		__block NSString *streakMetadata = [arg2 objectForKey:@"snapstreak_metadata"];
		NSLog(@"streakMetadata = %@", streakMetadata);
		NSError *error;
		if (streakMetadata !=nil) {
      NSMutableDictionary *payload = [[NSMutableDictionary alloc] initWithDictionary:arg2];
      NSMutableDictionary *aps = [[NSMutableDictionary alloc] initWithDictionary:[arg2 objectForKey:@"aps"]];
      NSMutableDictionary *alert = [[NSMutableDictionary alloc] initWithDictionary:[[arg2 objectForKey:@"aps"] objectForKey:@"alert"]];


			NSMutableDictionary *streakMetadataDict = [NSJSONSerialization JSONObjectWithData:[streakMetadata dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
			int streakLength = [[streakMetadataDict objectForKey:@"snapstreak_count"] intValue];

			NSTimeInterval seconds = [[streakMetadataDict objectForKey:@"snapstreak_expiry_time"] doubleValue] / 1000;
			NSDate *snapchatExpiryDate = [NSDate dateWithTimeIntervalSince1970:seconds];
			NSTimeInterval timeInterval = [snapchatExpiryDate timeIntervalSinceDate:[NSDate date]];

      int days = timeInterval / (60 * 60 * 24);
      timeInterval -= days * (60 * 60 * 24);
      int hours = timeInterval / (60 * 60);
      timeInterval -= hours * (60 * 60);
      int minutes = timeInterval / 60;

      __block NSString *bodyString;
      if(streakLength > 0){
        bodyString = [NSString stringWithFormat:@"%d day long streak will expire in %dd %dh %dm", streakLength, days, hours, minutes];
      }
      else {
        bodyString = @"";
      }

      alert[@"subtitle"] = [alert objectForKey:@"body"];
      aps[@"alert"] = alert;
      payload[@"aps"] = aps;
      payload[@"local_message"] = bodyString;
      arg2 = payload;
		}

	}
	return _logos_orig$_ungrouped$UNPushNotificationRequestBuilder$initWithIdentifier$payload$bundleIdentifier$(self, _cmd, arg1, arg2, arg3);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UNPushNotificationRequestBuilder = objc_getClass("UNPushNotificationRequestBuilder"); MSHookMessageEx(_logos_class$_ungrouped$UNPushNotificationRequestBuilder, @selector(initWithIdentifier:payload:bundleIdentifier:), (IMP)&_logos_method$_ungrouped$UNPushNotificationRequestBuilder$initWithIdentifier$payload$bundleIdentifier$, (IMP*)&_logos_orig$_ungrouped$UNPushNotificationRequestBuilder$initWithIdentifier$payload$bundleIdentifier$);} }
#line 48 "Tweak.x"
