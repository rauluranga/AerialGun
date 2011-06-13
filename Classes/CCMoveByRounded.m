//
//  CCMoveByRounded.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/13/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "CCMoveByRounded.h"


@implementation CCMoveByRounded

-(void) update: (ccTime) t
{	
	[target_ setPosition: ccp( round(startPosition.x + delta.x * t ), round(startPosition.y + delta.y * t ) )];
}

@end
