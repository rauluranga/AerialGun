//
//  SplashScene.m
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "SplashScene.h"

@interface SplashLayer (private)
-(void) fadeAndShow:(NSMutableArray *)images;
-(void) cFadeAndShow:(id)sender data:(void *)data;
@end


@implementation SplashScene

-(void) dealloc 
{
	[super dealloc];
}

-(id) init 
{
	self = [super init];
	if (self != nil) {
		[self addChild:[SplashLayer node]];
	}
	return self;
}
@end


@implementation SplashLayer

-(void) dealloc 
{
	[super dealloc];
}

-(void) remove:(CCSprite *)s
{
	[s.parent removeChild:s cleanup:YES];
}

-(id) init 
{
	
	if ((self = [super init])) {
		
		NSMutableArray *splashImages = [[NSMutableArray alloc] init];
		
		for (int i= 1; i<=3; i++) {
			CCSprite *splashImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"splash%d.png",i]];
			[splashImage setPosition:ccp(240,160)];
			[self addChild:splashImage];
			if (i != 1) {
				[splashImage setOpacity:0];
			}
			[splashImages addObject:splashImage];
		}
		
		[self fadeAndShow:splashImages];
	}
	return self;
}

-(void) fadeAndShow:(NSMutableArray *)images
{
	if ([images count] <= 1) {
		[images release];
		[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];
	} else {
		CCSprite *actual = (CCSprite *) [images objectAtIndex:0];
		[images removeObjectAtIndex:0];
		
		CCSprite *next = (CCSprite *)[images objectAtIndex:0];
		
		[actual runAction:[CCSequence actions:
								[CCDelayTime actionWithDuration:2],
								[CCFadeOut actionWithDuration:1],
								[CCCallFuncN actionWithTarget:self selector:@selector(remove:)],
								nil
						   ]];
		[next runAction:[CCSequence actions:
								[CCDelayTime actionWithDuration:2],
								[CCFadeIn actionWithDuration:1],
								[CCDelayTime actionWithDuration:1],
								[CCCallFuncND actionWithTarget:self selector:@selector(cFadeAndShow:data:) data:images],
								nil
						 ]];
	}

}

-(void) cFadeAndShow:(id)sender data:(void *)data
{
	NSMutableArray *images = (NSMutableArray *) data;
	[self fadeAndShow:images];
}

@end

