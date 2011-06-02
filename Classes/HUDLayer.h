//
//  HUDLayer.h
//  AerialGun
//
//  Created by Raúl Uranga on 6/2/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface HUDLayer : CCLayer {
	CCLabelBMFont *level;
	CCLabelBMFont *score;
	CCLabelBMFont *bombs;
	NSMutableArray *lives;
}

@property (nonatomic, retain) CCLabelBMFont *level;
@property (nonatomic, retain) CCLabelBMFont *score;
@property (nonatomic, retain) CCLabelBMFont *bombs;
@property (nonatomic, retain) NSMutableArray *lives;

@end
