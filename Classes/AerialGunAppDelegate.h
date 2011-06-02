//
//  AerialGunAppDelegate.h
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright GrupoW 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AerialGunAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
	bool paused;
}

@property (nonatomic, retain) UIWindow *window;

@property(nonatomic, readwrite) bool paused;

+(AerialGunAppDelegate *)get;

@end
