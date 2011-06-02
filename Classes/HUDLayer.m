//
//  HUDLayer.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/2/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "HUDLayer.h"


@implementation HUDLayer

@synthesize level;
@synthesize score;
@synthesize bombs;
@synthesize lives;

-(void) dealloc 
{
	[super dealloc];
	[lives release];
}


-(id) init
{
	if ((self = [super init])) {
		
		CCSprite *background = [CCSprite spriteWithFile:@"hud_background.png"];
		[background setPosition:ccp(160,455)];
		[self addChild:background];
		
		lives = [[NSMutableArray arrayWithCapacity:3] retain];
		for (int i = 0; i<3; i++) {
			CCSprite *life = [CCSprite spriteWithFile:@"hud_life.png"];
			[life setPosition:ccp(18 + 28 * i, 465)];
			[self addChild:life];
			[lives addObject:life];
		}
		
		CCSprite *bomb = [CCSprite spriteWithFile:@"hud_bomb.png"];
		[bomb setPosition:ccp(18, 445)];
		[self addChild:bomb];
		
		//GameLayer *gl = (GameLayer *)[self.parent getChildByTag:kGameLayer];
		
		level = [CCLabelBMFont labelWithString:@"Level 1" fntFile:@"hud_font.fnt"];
		[level setAnchorPoint:ccp(1,0.5)];
		[level setPosition:ccp(310,465)];
		[level setColor:ccBLACK];
		[self addChild:level];
		
		
		score = [CCLabelBMFont labelWithString:@"Score 0" fntFile:@"hud_font.fnt"];
		[score setAnchorPoint:ccp(1,0.5)];
		[score setPosition:ccp(310,445)];
		[score setColor:ccBLACK];
		[self addChild:score];
		
		
		
		bombs = [CCLabelBMFont labelWithString:@"X3" fntFile:@"hud_font.fnt"];
		[bombs setAnchorPoint:ccp(1,0.5)];
		[bombs setPosition:ccp(47,440)];
		[bombs setColor:ccBLACK];
		[self addChild:bombs];
		
	}
	
	return self;
}

@end
