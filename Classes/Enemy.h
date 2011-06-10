//
//  Enemy.h
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class GameLayer;


@interface Enemy : CCNode {
	
	CCSprite *mySprite;
	GameLayer *theGame;
	
	float lasTimeFired;
	float fireInterval;
	float firingSpeed;
	float movementSpeed;
	
	bool launched;
	int hp;
	int maxHp;
}

@property (nonatomic,retain) CCSprite *mySprite;
@property (nonatomic,retain) GameLayer *theGame;
@property (nonatomic,readwrite) float lasTimeFired;
@property (nonatomic,readwrite) float fireInterval;
@property (nonatomic,readwrite) float firingSpeed;
@property (nonatomic,readwrite) float movementSpeed;
@property (nonatomic,readwrite) bool launched;
@property (nonatomic,readwrite) int hp;
@property (nonatomic,readwrite) int maxHp;

-(id) initWithGame:(GameLayer *)game;
-(void) update;
-(void) launch;
-(void) damage;
-(void) reset;
-(void) destroy;
//-(CGRect)myRecta;
@end
