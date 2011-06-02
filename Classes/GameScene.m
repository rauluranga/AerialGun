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

#pragma mark -
#pragma mark GameLayer Public implementation

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

#pragma mark -
#pragma mark Memory management

-(void) dealloc 
{
	[super dealloc];
}

#pragma mark -
#pragma mark Public Methods

-(id) init 
{
	if ((self = [super init])) {
		
		self.isAccelerometerEnabled = true;
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
		
		//[self addChild:[MainMenuLayer node]];
		hero = [[Hero alloc] initWithGame:self];
		
		enemies = [[NSMutableArray alloc] initWithCapacity:10];
		
		for (int i=0; i<10; i++) {
			Enemy *e = [[Enemy alloc] initWithGame:self];
			[enemies addObject:e];
			[e release];
		}
		
		bullets = [[NSMutableArray alloc] initWithCapacity:50];
		
		for (int i=0; i<50; i++) {
			Bullet *c = [[Bullet alloc] initWithGame:self];
			[bullets addObject:c];
			[c release];
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
	
	for (Bullet *b in bullets) {
		if (b.fired) {
			[b update];
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

#pragma mark -
#pragma mark accelerometer


- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
#define kFilterFactor 0.05f
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	if(hero)
	{
		float speed = -20 * -accelX;
		if(speed > hero.movementSpeed)
			speed = hero.movementSpeed;
		else if(speed < -hero.movementSpeed)
			speed = -hero.movementSpeed;
		
		if((accelX >0 || hero.mySprite.position.x >hero.mySprite.textureRect.size.width / 2) && ( accelX <0 ||hero.mySprite.position.x <320- hero.mySprite.textureRect.size.width / 2))
			[hero.mySprite setPosition:ccp(hero.mySprite.position.x +speed,hero.mySprite.position.y)];
	}
}


@end
