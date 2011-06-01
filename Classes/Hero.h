//
//  Hero.h
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class GameLayer;

@interface Hero : CCNode {
	CCSprite *mySprite;
	GameLayer *theGame;
	float lasTimeFired;
	float fireInterval;
	float firingSpeed;
	float movementSpeed;
}

@property (nonatomic,retain) CCSprite *mySprite;
@property (nonatomic,retain) GameLayer *theGame;
@property (nonatomic,readwrite) float lasTimeFired;
@property (nonatomic,readwrite) float fireInterval;
@property (nonatomic,readwrite) float firingSpeed;
@property (nonatomic,readwrite) float movementSpeed;

-(id) initWithGame:(GameLayer *)game;

@end
