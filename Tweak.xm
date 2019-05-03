//Created by J.K. Hayslip (iKilledAppl3) on Wed, July 18, 2018
//Malipo is a tweak that allows users to choose a charge sound with ease!

//The header file :P
#import "Malipo_header.h"

//hooks
%hook SBUIController
-(void)playConnectedToPowerSoundIfNecessary {
	if (kEnabled && self.isOnAC) {
		nil;
			SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kCustom]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);
			if (kVibrateEnabled) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				[NSThread sleepForTimeInterval:0.5];
			}
	
	}
	
	else {
		%orig;
	}
}
%end

	
	
	//Prefs
extern NSString *const HBPreferencesDidChangeNotification;

%ctor {


    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ikilledappl3.malipo"];
	
	[preferences registerBool:&kEnabled default:NO forKey:@"kEnabled"];
	[preferences registerObject:&kCustom default:nil forKey:@"kCustom"];
	[preferences registerBool:&kVibrateEnabled default:NO forKey:@"kVibrateEnabled"];
	
	
}


