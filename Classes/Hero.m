//
//  Hero.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "Hero.h"
#import "RippedHolder.h"

@interface Hero (private)

-(BOOL)checkCollisions:(CGRect)r;
-(void) finishReviving;

@end




@implementation Hero

@synthesize mySprite;
@synthesize theGame;
@synthesize lasTimeFired;
@synthesize fireInterval;
@synthesize firingSpeed;
@synthesize movementSpeed;
@synthesize reviving;

-(void) dealloc 
{
	[super dealloc];
}

-(id) initWithGame:(GameLayer *)game
{
	if ((self = [super init])) {
		self.theGame = game;
		
		mySprite = [CCSprite spriteWithFile:@"hero.png"];
		[mySprite setPosition:ccp(160,50)];
		
		[theGame addChild:mySprite z:2];
		
		self.lasTimeFired = 0;
		self.fireInterval = 3;
		self.firingSpeed = 10;
		self.movementSpeed = 5;
	}
	
	return self;
}

-(void) update
{
	self.lasTimeFired += 0.1;
	
	for (Enemy *s in theGame.enemies) {
		if (ccpDistance(self.mySprite.position, s.mySprite.position) < 30) {
			if ([self checkCollisions:[theGame myRect:s.mySprite]]) {
				[s reset];
				[self destroy];
			}
		}
	}
	
	for (RippedHolder *holder in theGame.ripped) {
		if (ccpDistance(self.mySprite.position, ccp(holder.rippedRect.origin.x + holder.rippedRect.size.width/2 , holder.rippedRect.origin.y + holder.rippedRect.size.height/2)) < 30) {
			if ([self checkCollisions:holder.rippedRect]) {
				[self destroy];
			}
		}
	}
	
	[theGame.smoke setPosition:ccp(self.mySprite.position.x - 2,self.mySprite.position.y - 20)];
	
}

-(void) destroy
{
	if (!self.reviving) {
		self.reviving = YES;
		[self.mySprite setPosition:ccp(160,-200)];
		[self.mySprite runAction:[CCSequence actions:
								  [CCDelayTime actionWithDuration:1],
								  [CCEaseOut actionWithAction:[CCMoveTo actionWithDuration:1 position:ccp(160,50)] rate:5],
								  [CCCallFunc actionWithTarget:self selector:@selector(finishReviving)],
								  nil ]];
	}
	
	[theGame loseLife];
}

@end


#pragma mark -
#pragma mark Private implementation

@implementation Hero (private)

-(BOOL)checkCollisions:(CGRect)r
{
	BOOL x = NO;
	if (CGRectIntersectsRect([theGame myRect:self.mySprite], r)) {
		x = YES;
	}
	return x;
}

-(void) finishReviving
{
	self.reviving = NO;
}

@end

