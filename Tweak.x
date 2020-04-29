@interface UNPushNotificationRequestBuilder
-(id)initWithIdentifier:(id)arg1 payload:(id)arg2 bundleIdentifier:(id)arg3;
@end

int formatSpeciferType;

%hook UNPushNotificationRequestBuilder
-(id)initWithIdentifier:(id)arg1 payload:(id)arg2 bundleIdentifier:(id)arg3 {
  	if([arg3 isEqualToString:@"com.toyopagroup.picaboo"]){
      NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.galacticdev.streaknotificationsprefs.plist"];
      NSLog(@"prefs = %@", prefs);

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
        if(formatSpeciferType == 0){
          bodyString = [NSString stringWithFormat:@"%d day long streak will expire in %dd %dh %dm", streakLength, days, hours, minutes];
        }
        else if(formatSpeciferType == 1){
          bodyString = [NSString stringWithFormat:@"🔥%d ⏰%dd %dh %dm", streakLength, days, hours, minutes];
        }
        else if(formatSpeciferType == 2){
          bodyString = [NSString stringWithFormat:@"⏰%dd %dh %dm", days, hours, minutes];
        }
        else if(formatSpeciferType == 3){
          bodyString = [NSString stringWithFormat:@"🔥%d", streakLength];
        }
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
	return %orig;
}

%end

static void loadPrefs(){
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.galacticdev.streaknotificationsprefs.plist"];

		if ([prefs objectForKey:@"formatSpecifer"] != nil){
      if([[prefs objectForKey:@"formatSpecifer"] intValue] == 0){
        formatSpeciferType = 0;
      }
      else if([[prefs objectForKey:@"formatSpecifer"] intValue] == 1){
        formatSpeciferType = 1;
      }
      else if([[prefs objectForKey:@"formatSpecifer"] intValue] == 2){
        formatSpeciferType = 2;
      }
      else if([[prefs objectForKey:@"formatSpecifer"] intValue] == 3){
        formatSpeciferType = 3;
      }
		} else {
			formatSpeciferType = 0;
		}


}


%ctor {
  loadPrefs();
}
