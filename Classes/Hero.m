//
//  Hero.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/1/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "Hero.h"


@implementation Hero

@synthesize mySprite;
@synthesize theGame;
@synthesize lasTimeFired;
@synthesize fireInterval;
@synthesize firingSpeed;
@synthesize movementSpeed;

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
		
		[theGame addChild:mySprite];
		
		self.lasTimeFired = 0;
		self.fireInterval = 3;
		self.firingSpeed = 10;
		self.movementSpeed = 5;
	}
	
	return self;
}

@end
