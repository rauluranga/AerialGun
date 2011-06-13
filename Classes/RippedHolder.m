//
//  RippedHolder.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/13/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "RippedHolder.h"


@implementation RippedHolder

@synthesize rippedRect;
@synthesize originalY;

-(void)dealloc
{
	[super dealloc];
}

-(id) initWithRect:(CGRect) rect
{
	if ((self = [super init])) {
		self.rippedRect = rect;
		self.originalY = rect.origin.y;
	}
	return self;
}

@end
