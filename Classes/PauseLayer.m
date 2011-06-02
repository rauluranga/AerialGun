//
//  PauseLayer.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/2/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "PauseLayer.h"


@implementation PauseLayer

-(void) dealloc
{
	[super dealloc];
}

-(id) initWithColor:(ccColor4B)color
{
	if ((self = [super initWithColor:color])) {
		self.isTouchEnabled = YES;
		CCSprite *paused = [CCSprite spriteWithFile:@"paused.png"];
		[paused setPosition:ccp(160,240)];
		[self addChild:paused];
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch *touch in touches)
	{
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL:location];
		
		GameLayer *gl = (GameLayer *)[self.parent getChildByTag:kGameLayer];
		[gl resume];
		
		[self.parent removeChild:self cleanup:YES];
	}
}
	
@end
