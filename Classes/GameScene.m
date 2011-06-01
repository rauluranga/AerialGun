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
		
		enemies = [[NSMutableArray alloc] initWithCapacity:10];
		
		for (int i=0; i<10; i++) {
			Enemy *e = [[Enemy alloc] initWithGame:self];
			[enemies addObject:e];
			[e release];
		}
		
		lastTimeEnemyLaunched = 0;
		enemyInterval = 20;
		self.lives = STARTING_LIVES;
		[self schedule:@selector(step:)];
	}
	return self;
}

-(void)step:(ccTime *)dt
{
	for (Enemy *e in enemies) {
		if (e.launched) {
			[e update];
		}
	}
	
	if (self.lastTimeEnemyLaunched > self.enemyInterval) {
		Enemy *n = (Enemy *) [enemies objectAtIndex:arc4random()% [enemies count]];
		if (!n.launched) {
			[n launch];
			self.lastTimeEnemyLaunched = 0;
		}
	}
	
	lastTimeEnemyLaunched += 0.1;
}

@end
