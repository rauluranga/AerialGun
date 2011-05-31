//
//  MainMenuScene.m
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "MainMenuScene.h"


@implementation MainMenuScene

-(void) dealloc 
{
	[super dealloc];
}

-(id) init 
{
	if ((self = [super init])) {
		[self addChild:[MainMenuLayer node]];
	}
	return self;
}


@end


@implementation MainMenuLayer

-(void) dealloc 
{
	[super dealloc];
}

-(id) init 
{
	if ((self = [super init])) {
		//[self addChild:[MainMenuLayer node]];
	}
	return self;
}


@end
