//
//  Bullet.h
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class GameLayer;

@interface Bullet : CCNode {
	CCSprite *mySprite;
	GameLayer *theGame;
	bool fired;
	int whoFired;
	int firingSpeed;
}

@property (nonatomic,retain) CCSprite *mySprite;
@property (nonatomic,retain) GameLayer *theGame;
@property (nonatomic,readwrite) bool fired;
@property (nonatomic,readwrite) int whoFired;
@property (nonatomic,readwrite) int firingSpeed;

-(id) initWithGame:(GameLayer *)game;
-(void) update;
-(void)fire:(int)who position:(CGPoint)position fspeed:(int)fspeed;

@end
