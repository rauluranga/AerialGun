//
//  OptionsScene.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/7/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "OptionsScene.h"
#import "MainMenuScene.h"

@interface OptionsLayer (private)

-(void) changeDiffyculty:(CCMenuItemToggle *)sender;
-(void) changeMusic:(CCMenuItemToggle *)sender;
-(void) changeSound:(CCMenuItemToggle *)sender;
-(void) goBack:(id)sender;

@end

@implementation OptionsScene

-(void) dealloc
{
	[super dealloc];
}

-(id)init
{	
	if ((self = [super init])) {
		[self addChild:[OptionsLayer node]];
	}
	return self;
}

@end


@implementation OptionsLayer

-(void) dealloc
{
	[super dealloc];
}

-(id)init
{	
	if ((self = [super init])) {
		self.isTouchEnabled = true;
		
		CCSprite *background = [CCSprite spriteWithFile:@"options_background.png"];
		[background setPosition:ccp(160,240)];
		[self addChild:background];
		
		CCLabelBMFont *difficultyLabel = [CCLabelBMFont labelWithString:@"DIFFICULTY" fntFile:@"hud_font.fnt"];
		[difficultyLabel setColor:ccRED];
		[difficultyLabel setPosition:ccp(80,350)];
		[self addChild:difficultyLabel];
		
		CCLabelBMFont *musicLabel = [CCLabelBMFont labelWithString:@"MUSIC" fntFile:@"hud_font.fnt"];
		[musicLabel setColor:ccRED];
		[musicLabel setPosition:ccp(80,250)];
		[self addChild:musicLabel];

		
		CCLabelBMFont *soundLabel = [CCLabelBMFont labelWithString:@"SOUND" fntFile:@"hud_font.fnt"];
		[soundLabel setColor:ccRED];
		[soundLabel setPosition:ccp(80,150)];
		[self addChild:soundLabel];
		
		
		CCMenuItemImage *easyBtn =  [CCMenuItemImage 
									 itemFromNormalImage:@"easy.png" 
									 selectedImage:@"easy_dwn.png" 
									 ];
		
		CCMenuItemImage *normalBtn =  [CCMenuItemImage 
									   itemFromNormalImage:@"normal.png" 
									   selectedImage:@"normal_dwn.png" 
									   ];
		
		CCMenuItemToggle *difficulty = [CCMenuItemToggle 
											itemWithTarget:self
											selector:@selector(changeDiffyculty:)
											items:easyBtn,normalBtn,nil];
		
		
		//
		//
		//
		//
		
		CCMenuItemImage *unchecked1 =  [CCMenuItemImage 
										itemFromNormalImage:@"options_check_d.png" 
										selectedImage:@"options_check.png" 
										];
		
		CCMenuItemImage *checked1 =  [CCMenuItemImage 
										itemFromNormalImage:@"options_check.png" 
										selectedImage:@"options_check_d.png" 
										];
		
		CCMenuItemToggle *music = [CCMenuItemToggle 
										itemWithTarget:self
										selector:@selector(changeMusic:)
										items:checked1,unchecked1,nil];
		
		//
		//
		//
		//
		
		CCMenuItemImage *unchecked2 =  [CCMenuItemImage 
										itemFromNormalImage:@"options_check_d.png" 
										selectedImage:@"options_check.png" 
										];
		
		CCMenuItemImage *checked2 =  [CCMenuItemImage 
									  itemFromNormalImage:@"options_check.png" 
									  selectedImage:@"options_check_d.png" 
									  ];
		
		CCMenuItemToggle *sound = [CCMenuItemToggle 
								   itemWithTarget:self
								   selector:@selector(changeSound:)
								   items:checked2,unchecked2,nil];
		
		//
		//
		//
		//
		
		CCMenuItemImage *goBack =  [CCMenuItemImage 
									 itemFromNormalImage:@"options_goback.png" 
									 selectedImage:@"options_goback.png" 
									 disabledImage:@"options_goback.png"
									 target:self
									 selector:@selector(goBack:)];
		
		//
		//
		//
		//
		
		[difficulty setPosition:ccp(220,350)];
		[music setPosition:ccp(220,260)];
		[sound setPosition:ccp(220,160)];
		[goBack setPosition:ccp(160,30)];
		
		CCMenu *menu = [CCMenu menuWithItems:difficulty,music,sound,goBack,nil];
		[self addChild:menu];
		[menu setPosition:ccp(0,0)];
		
		
	}
	return self;
}

@end



#pragma mark -
#pragma mark Private implementation

@implementation OptionsLayer (private)

-(void) changeDiffyculty:(CCMenuItemToggle *)sender
{
	NSLog(@"%d",sender.selectedIndex);
}

-(void) changeMusic:(CCMenuItemToggle *)sender
{
	
}

-(void) changeSound:(CCMenuItemToggle *)sender
{
	
}

-(void) goBack:(id)sender
{
	MainMenuScene *ms = [MainMenuScene node];
	[[CCDirector sharedDirector] replaceScene:ms];
}


@end

