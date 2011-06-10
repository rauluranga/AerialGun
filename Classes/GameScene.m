//
//  GameScene.m
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "GameScene.h"


@interface GameLayer (private)
-(void) step:(ccTime *)dt;
-(void) resetGame;
-(void) explodeBomb;
-(void) allowBoms;
@end

//
//
//
//
//
//
//
//


@implementation GameScene

-(void) dealloc 
{
	[super dealloc];
}

-(id)initWithDifficulty:(int)mode
{
	if ((self = [super init])) {
		GameLayer *gameLayer = [[[GameLayer alloc] initWithDifficulty:mode] autorelease];
		[self addChild:gameLayer z:0 tag:kGameLayer];
		[self addChild:[HUDLayer node] z:1 tag:kHudLayer];
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
@synthesize difficulty;
@synthesize canLaunchBomb;


#pragma mark -
#pragma mark Memory management

-(void) dealloc 
{
	NSLog(@"GameLayer dealloc called");
	[super dealloc];
}

#pragma mark -
#pragma mark Public Methods

-(id)initWithDifficulty:(int)mode
{
	if ((self = [super init])) {
		
		self.isTouchEnabled = true;
		self.isAccelerometerEnabled = true;
		self.difficulty = mode;
		self.canLaunchBomb = YES;
		self.bombs = 3;
		
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
		
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
		enemyInterval = 20/self.difficulty;;
		self.lives = STARTING_LIVES;
		
		NSLog(@"init");
		[self schedule:@selector(step:)];
	}
	return self;
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

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch *touch in touches)
	{
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL:location];
		[self setPlayerFiring:YES];
	}
	UITouch *t = [touches anyObject]; 
	//if([touch tapCount] == 2) { 
	if ([t tapCount] == 2 && canLaunchBomb && bombs > 0) {
		[self explodeBomb];
	}
	
	NSLog(@"touches tapCount: %d",[t tapCount]);
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch *touch in touches)
	{
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL:location];
		[self setPlayerFiring:NO];
	}
}

/*
 *	The myRect method returns a CGRect object representing the boundaries of the object.
 *	In this case, we are making a CGRect of the exact size of the sprite,
 *	but you could make it bigger or smaller if you needed to.
 */
-(CGRect)myRect:(CCSprite *)sp
{
	CGRect c = CGRectMake(sp.position.x-(sp.textureRect.size.width/2) * sp.scaleX ,
						  sp.position.y-(sp.textureRect.size.height/2)* sp.scaleY,
						  sp.textureRect.size.width * sp.scaleX,
						  sp.textureRect.size.height * sp.scaleY);
	return c;
}

-(void)loseLife
{
	self.lives--;
	
	
	HUDLayer *hl = (HUDLayer *) [self.parent getChildByTag:kHudLayer];
	
	CCSprite *live = [hl.lives objectAtIndex:self.lives];
	[live setVisible:NO];
	
	if (self.lives == 0) {
		NSLog(@"GAME OVER");
		[self resetGame];
	}
}

-(void)pauseGame
{
	ccColor4B c = {100,100,0,100};
	PauseLayer * p = [[[PauseLayer alloc] initWithColor:c] autorelease];
	[self.parent addChild:p z:10];
	[self onExit];
}


-(void)resume
{
	if (![AerialGunAppDelegate get].paused) {
		return;
	}
	[AerialGunAppDelegate get].paused = NO;
	[self onEnter];
}

-(void)onEnter
{
	NSLog(@"GameLayer onEnter");
	if (![AerialGunAppDelegate get].paused) {
		[super onEnter];
	}
}

-(void)onExit
{
	NSLog(@"GameLayer onExit");
	if (![AerialGunAppDelegate get].paused) {
		[AerialGunAppDelegate get].paused = YES;
		[super onExit];
	}
}


@end


#pragma mark -
#pragma mark Private implementation

@implementation GameLayer (private)
//
-(void) step:(ccTime *)dt
{	
	[hero update];
	
	for (Enemy *e in enemies) {
		if (e.launched) {
			[e update];
		}
	}
	
	for (Bullet *b in bullets) {
		if (b.fired) {
			[b update];
		}else {
			if (self.playerFiring && hero.lasTimeFired > hero.fireInterval) {
				[b fire:1 position:hero.mySprite.position fspeed:hero.firingSpeed];
				hero.lasTimeFired = 0;
			}
		}
		
	}
	
	if (self.lastTimeEnemyLaunched > self.enemyInterval) {
		Enemy *n = (Enemy *) [enemies objectAtIndex:arc4random()% [enemies count]];
		if (!n.launched) {
			[n launch];
			NSLog(@"Enemy launch!");
			self.lastTimeEnemyLaunched = 0;
		}
	}
	
	lastTimeEnemyLaunched += 0.1;
}

-(void)resetGame
{
	HUDLayer *hl = (HUDLayer *) [self.parent getChildByTag:kHudLayer];
	
	for (CCSprite *c in hl.lives) {
		[c setVisible:YES];
	}
	
	self.level = 1;
	[hl.level setString:@"Level 1"];
	
	self.score = 0;
	[hl.score setString:@"Score 0"];
	
	self.bombs = 3;
	[hl.bombs setString:@"X3"];
	
	lives = STARTING_LIVES;
}

-(void) explodeBomb
{
	self.canLaunchBomb = NO;
	self.bombs--;
	
	HUDLayer *hl = (HUDLayer *) [self.parent getChildByTag:kHudLayer];
	[hl.bombs setString:[NSString stringWithFormat:@"X%d",self.bombs]];
	
	CCParticleExplosion *bomb = [CCParticleExplosion node];
	[self addChild:bomb z:4];
	
	bomb.texture = [[CCTextureCache sharedTextureCache] addImage:@"explosionParticle.png"];
	bomb.autoRemoveOnFinish = YES;
	bomb.speed = 200;
	[bomb setPosition:ccp(160,240)];
	
	for (Enemy * n in enemies) {
		if (n.launched) {
			[n destroy];
		}
	}
	
	[self schedule:@selector(allowBoms) interval:2];
}

-(void) allowBoms
{
	[self unschedule:@selector(allowBoms)];
	self.canLaunchBomb = YES;
}


@end



























