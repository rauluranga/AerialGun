//
//  Bullet.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "Bullet.h"

@interface Bullet (private)

-(BOOL)checkCollisions:(CGRect)r;
-(void) reset;

@end

#pragma mark -
#pragma mark Public implementation

@implementation Bullet

@synthesize mySprite;
@synthesize theGame;
@synthesize fired;
@synthesize whoFired;
@synthesize firingSpeed;

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
		
		mySprite = [CCSprite spriteWithFile:@"bullet1.png"];
		[mySprite setPosition:ccp(-100,-100)];
		//[mySprite setVisible:NO];
		[theGame addChild:mySprite z:1];
		
	}
	return self;
}

-(void) update
{
	
	switch (self.whoFired) {
			
		case 1:
			
			[self.mySprite setPosition:ccp(self.mySprite.position.x,self.mySprite.position.y + self.firingSpeed)];
			
			for (Enemy * s in theGame.enemies) {
				if (ccpDistance(self.mySprite.position, s.mySprite.position) < 30) {
					if ([self checkCollisions:[theGame myRect:s.mySprite]]) {
						[s damage];
					}
				}
			}
			
			break;
			
		case 2:
			
			[self.mySprite setPosition:ccp(self.mySprite.position.x,self.mySprite.position.y + self.firingSpeed)];
			
			if (ccpDistance(self.mySprite.position, theGame.hero.mySprite.position) < 30) {
				[theGame.hero destroy];
			}
			
			break;
	}
		
	if (self.mySprite.position.y > 500 || self.mySprite.position.y < -20) {
		[self reset];
	}
}


-(void)fire:(int)who position:(CGPoint)position fspeed:(int)fspeed
{
	self.firingSpeed = fspeed;
	self.whoFired = who;
	self.fired = YES;
	[self.mySprite setPosition:position];
}	

@end


#pragma mark -
#pragma mark Private implementation

@implementation Bullet (private)

-(BOOL)checkCollisions:(CGRect)r
{
	BOOL x = NO;
	if (CGRectIntersectsRect([theGame myRect:self.mySprite], r)) {
		x = YES;
		[self reset];
	}
	
	return x;
}

-(void) reset
{
	self.fired = NO;
	[self.mySprite setPosition:ccp(-100,-100)];
	
}

@end

