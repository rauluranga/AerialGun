//
//  AerialGunAppDelegate.h
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright GrupoW 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocosDenshion.h"

@class RootViewController;


#define SND_ID_EXPLOSION 0
#define SND_ID_BULLET 1
#define SND_ID_CLICK 2
#define CGROUP_ALL 0


@interface AerialGunAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
	bool paused;
	
	CDSoundEngine *soundEngine;
}

@property (nonatomic, retain) UIWindow *window;

@property(nonatomic, readwrite) bool paused;
@property(nonatomic, retain) CDSoundEngine *soundEngine;

+(AerialGunAppDelegate *)get;

@end
