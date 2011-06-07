//
//  GameScene.h
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"
#import "Enemy.h"
#import "Bullet.h"
#import "AccelerometerSimulation.h"
#import "HUDLayer.h"
#import "PauseLayer.h"
#import "AerialGunAppDelegate.h"

#define STARTING_LIVES 3
#define kGameLayer 1
#define kHudLayer 2

@class Hero;

@interface GameScene : CCScene {
	
}
-(id)initWithDifficulty:(int)mode;
@end

@interface GameLayer : CCLayer {
	
	Hero *hero;
	
	NSMutableArray *bullets;
	bool playerFiring;
	
	NSMutableArray *enemies;
	float lastTimeEnemyLaunched;
	float enemyInterval;
	
	int score;
	int lives;
	int bombs;
	int level;
	int difficulty;
	
}

@property (nonatomic, retain) Hero *hero;
@property (nonatomic, readwrite) bool playerFiring;
@property (nonatomic, readwrite) float lastTimeEnemyLaunched;
@property (nonatomic, readwrite) float enemyInterval;
@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, retain) NSMutableArray *enemies;
@property (assign, readwrite) int score;
@property (assign, readwrite) int lives;
@property (assign, readwrite) int bombs;
@property (assign, readwrite) int level;
@property (assign, readwrite) int difficulty;


-(CGRect)myRect:(CCSprite *)sp;
-(void)loseLife;
-(void)pauseGame;
-(void)resume;
-(id)initWithDifficulty:(int)mode;


@end
