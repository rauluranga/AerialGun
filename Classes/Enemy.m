//
//  Enemy.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "Enemy.h"


#pragma mark -
#pragma mark Public implementation

@implementation Enemy

@synthesize mySprite;
@synthesize theGame;
@synthesize lasTimeFired;
@synthesize fireInterval;
@synthesize firingSpeed;
@synthesize movementSpeed;
@synthesize launched;
@synthesize hp;
@synthesize maxHp;

#pragma mark -
#pragma mark Memory management

-(void) dealloc 
{
	[super dealloc];
}

#pragma mark -
#pragma mark Public Methods

-(id) initWithGame:(GameLayer *)game
{
	if ((self = [super init])) {
		
		self.theGame = game;
		self.lasTimeFired = 0;
		
		int enType = arc4random() % 4 + 1;
		
		mySprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"enemy%d.png",enType]];
		[mySprite setPosition:ccp(-500,200)];
		
		[theGame addChild:mySprite z:2];
		
		switch (enType) {
				
			case 1:
				self.movementSpeed = 5 * theGame.difficulty;
				self.fireInterval = -1;
				self.hp = self.maxHp = 1;
				break;
				
			case 2:
				self.movementSpeed = 3 * theGame.difficulty;
				self.fireInterval = 6;
				self.hp = self.maxHp = 1;
				break;
			case 3:
				self.movementSpeed = 1 * theGame.difficulty;
				self.fireInterval = 9;
				self.hp = self.maxHp = 2;
				break;
				
			case 4:
				self.movementSpeed = 1 * theGame.difficulty;
				self.fireInterval = 8;
				self.hp = self.maxHp = 2;
				break;
				
			default :
				self.movementSpeed = 5 * theGame.difficulty;
				self.fireInterval = -1;
				self.hp = self.maxHp = 1;
				break;
		}
		
		self.firingSpeed = -3 - self.movementSpeed;
		
	}
	
	return self;
}


-(void) update
{
	[self.mySprite setPosition:ccp(self.mySprite.position.x, self.mySprite.position.y - self.movementSpeed) ];
	
	for (Bullet *b in theGame.bullets) {
		if (self.fireInterval > 0 && !b.fired && self.lasTimeFired > self.fireInterval) {
			[b fire:2 position:self.mySprite.position fspeed:self.firingSpeed];
			self.lasTimeFired = 0;
		}
	}
	
	self.lasTimeFired +=0.1;
	
	
	if (self.mySprite.position.y < - 20) {
		[self reset];
	}
}

-(void) launch
{
	self.launched = YES;
	[self.mySprite setPosition:ccp(arc4random() % 260, 520) ];
}

-(void) damage
{
	ExplosionParticle *stars = [ExplosionParticle node];
	[stars setPosition:self.mySprite.position];
	[stars runAction:[CCMoveBy actionWithDuration:1 position:ccp(0,-100)]];
	
	[self.theGame addChild:stars z:5];
	
	
	self.hp--;
	[self.mySprite runAction:[CCSequence actions:
							  [CCTintTo actionWithDuration:0.5 red:255 green:0 blue:0],
							  [CCTintTo actionWithDuration:0.5 red:255 green:255 blue:255],
							  nil
							  ]];
	if (hp < 0) {
		[self destroy];
	}
}

-(void) reset
{
	self.hp = self.maxHp;
	self.launched = NO;
	[self.mySprite setPosition:ccp(-500,200)];
	
}

-(void) destroy
{
	[self reset];
	[theGame setScore:theGame.score + 100];
	
	HUDLayer *hl = (HUDLayer *) [theGame.parent getChildByTag:kHudLayer];
	[hl.score setString:[NSString stringWithFormat:@"Score %d",theGame.score]];
	
	NSLog(@"%d",theGame.score);
	
	[[AerialGunAppDelegate get].soundEngine playSound:SND_ID_EXPLOSION sourceGroupId:CGROUP_ALL pitch:1 pan:0.0f gain:1.0f loop:NO];

}

@end




