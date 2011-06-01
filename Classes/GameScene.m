//
//  GameScene.m
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(void) dealloc 
{
	[super dealloc];
}

-(id) init 
{
	if ((self = [super init])) {
		[self addChild:[GameLayer node]];
	}
	return self;
}


@end


@implementation GameLayer

@synthesize hero;
@synthesize playerFiring;
@synthesize lastTimeEnemyLaunched;
@synthesize enemyInterval;
@synthesize bullets;
@synthesize enemies;
@synthesize score;
@synthesize lives;
@synthesize bombs;
@synthesize level;


-(void) dealloc 
{
	[super dealloc];
}

-(id) init 
{
	if ((self = [super init])) {
		//[self addChild:[MainMenuLayer node]];
		hero = [[Hero alloc] initWithGame:self];
	}
	return self;
}


@end
