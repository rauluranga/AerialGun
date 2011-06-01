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

@class Hero;

@interface GameScene : CCScene {
	
}

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


@end
