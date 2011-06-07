//
//  MainMenuScene.m
//  AerialGun
//
//  Created by Raúl Uranga on 5/31/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "MainMenuScene.h"
#import "GameScene.h"


@interface MainMenuLayer (private)

-(void) newgame;
-(void) options;
-(void) about;
-(void)showDifficultySelection;
-(void)selectMode:(CCMenuItemImage *)btn;

@end


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
		
		self.isTouchEnabled = true;
		CCSprite *background = [CCSprite spriteWithFile:@"menuBackground.png"];
		[background setPosition:ccp(160,240)];
		
		[self addChild:background];
		
		CCLabelBMFont *newgameLabel = [CCLabelBMFont labelWithString:@"NEW GAME" fntFile:@"hud_font.fnt"];
		CCLabelBMFont *optionsLabel = [CCLabelBMFont labelWithString:@"OPTIONS" fntFile:@"hud_font.fnt"];
		CCLabelBMFont *aboutLabel = [CCLabelBMFont labelWithString:@"ABOUT" fntFile:@"hud_font.fnt"];
		//[newgameLabel setAnchorPoint:ccp(1,0.5)];
		//[newgameLabel setPosition:ccp(310,465)];
		//[newgameLabel setColor:ccBLACK];
		
		[newgameLabel setColor:ccRED];
		[optionsLabel setColor:ccRED];
		[aboutLabel setColor:ccRED];
		
		CCMenuItemLabel *newgame_item = [CCMenuItemLabel itemWithLabel:newgameLabel target:self selector:@selector(newgame)];
		CCMenuItemLabel *options_item = [CCMenuItemLabel itemWithLabel:optionsLabel target:self selector:@selector(options)];
		CCMenuItemLabel *about_item = [CCMenuItemLabel itemWithLabel:aboutLabel target:self selector:@selector(about)];
		
		CCMenu *menu = [CCMenu menuWithItems:newgame_item,options_item,about_item,nil];
		[menu alignItemsVerticallyWithPadding:5];
		[menu setPosition:ccp(480,120)];
		
		[self addChild:menu];
		
		
		[newgame_item runAction:[CCSequence actions:
								 [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-240,0)] rate:2],
								 [CCRepeat actionWithAction:[CCSequence actions:
															[CCScaleTo actionWithDuration:1 scale:1.3],
															[CCScaleTo actionWithDuration:1 scale:1]
															,nil] times:9000],
								 nil]];
		
		[options_item runAction:[CCSequence actions:
								 [CCDelayTime actionWithDuration:0.5],
								 [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-240,0)] rate:2],
								 [CCRepeat actionWithAction:[CCSequence actions:
															 [CCScaleTo actionWithDuration:1 scale:1.3],
															 [CCScaleTo actionWithDuration:1 scale:1]
															 ,nil] times:9000],
								 nil]];
		
		
		[about_item runAction:[CCSequence actions:
  							     [CCDelayTime actionWithDuration:1],
								 [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-240,0)] rate:2],
								 [CCRepeat actionWithAction:[CCSequence actions:
															 [CCScaleTo actionWithDuration:1 scale:1.3],
															 [CCScaleTo actionWithDuration:1 scale:1]
															 ,nil] times:9000],
								 nil]];
		
	}
	return self;
}

@end

#pragma mark -
#pragma mark Private implementation

@implementation MainMenuLayer (private)

-(void) newgame
{
	//GameScene *gs = [GameScene node];
	//[[CCDirector sharedDirector] replaceScene:gs];
	
	[self showDifficultySelection];
}

-(void) options
{
	
}

-(void) about
{
	
}

-(void)showDifficultySelection
{
	ccColor4B c = {0,0,0,180};
	CCLayerColor *difficulty = [CCLayerColor layerWithColor:c];
	[self addChild:difficulty];
	
	CCMenuItemImage *easyBtn =  [CCMenuItemImage 
								 itemFromNormalImage:@"easy.png" 
								 selectedImage:@"easy_dwn.png" 
								 disabledImage:@"easy_dis.png"
								 target:self
								 selector:@selector(selectMode:)];
	
	CCMenuItemImage *normalBtn =  [CCMenuItemImage 
								   itemFromNormalImage:@"normal.png" 
								   selectedImage:@"normal_dwn.png" 
								   disabledImage:@"normal_dis.png"
								   target:self
								   selector:@selector(selectMode:)];
	
	CCMenuItemImage *extremeBtn =  [CCMenuItemImage 
									itemFromNormalImage:@"extreme.png" 
									selectedImage:@"extreme_dwn.png" 
									disabledImage:@"extreme_dis.png"
									target:self
									selector:@selector(selectMode:)];
	
	[extremeBtn setIsEnabled:NO];
	
	
	[easyBtn setTag:1];
	[normalBtn setTag:2];
	[extremeBtn setTag:3];
	
	CCMenu *dMenu = [CCMenu menuWithItems:easyBtn,normalBtn,extremeBtn,nil];
	[dMenu alignItemsVerticallyWithPadding:10];
	[difficulty addChild:dMenu];
}

-(void)selectMode:(CCMenuItemImage *)btn
{
	//*/
	int mode = btn.tag;
	GameScene *gs = [[[GameScene alloc] initWithDifficulty:mode] autorelease];
	[[CCDirector sharedDirector] replaceScene:gs];
	/*/
	GameScene *gs = [GameScene node];
	[[CCDirector sharedDirector] replaceScene:gs];
	//*/
}

@end


















