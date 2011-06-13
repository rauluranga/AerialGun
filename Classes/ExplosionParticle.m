//
//  ExplosionParticle.m
//  AerialGun
//
//  Created by Raúl Uranga on 6/13/11.
//  Copyright 2011 GrupoW. All rights reserved.
//

#import "ExplosionParticle.h"


@implementation ExplosionParticle

-(id) init
{
	return [self initWithTotalParticles:144];
}

-(id) initWithTotalParticles:(int)p
{
	if ((self=[super initWithTotalParticles:p])) {
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage:@"explosionParticle.png"];
		
		// duration
		self.duration = 0.3;
		
		// Set "Radius" mode (default one)
		self.emitterMode = kCCParticleModeRadius;
		
		self.startRadius =60;
		self.startRadiusVar =53;
		self.endRadius =0;
		self.rotatePerSecond=0;
		self.rotatePerSecondVar =360;
		
		
		// self position
		self.position = ccp(160,240);
		
		// angle
		self.angle = 360;
		self.angleVar = 205;
		
		// life of particles
		self.life = 0.55;
		self.lifeVar = 0.15;
		
		// spin of particles
		self.startSpin = 0;
		self.startSpinVar = 0;
		self.endSpin = 0;
		self.endSpinVar = 2000;
		
		// color of particles
		ccColor4F _startColor = {1.0f, 0.15f, 0.65f, 1.0f};
		self.startColor = _startColor;
		
		ccColor4F _startColorVar = {1,1,1,0};
		self.startColorVar = _startColorVar;
		
		ccColor4F _endColor = {0.1f, 0.1f, 0, 0};
		self.endColor = _endColor;
		
		ccColor4F _endColorVar = {0.1f, 0.1f, 0, 0};	
		self.endColorVar = _endColorVar;
		
		// size, in pixels
		self.startSize = 12.0f;
		self.startSizeVar = 05.0f;
		self.endSize = 0;
		self.endSizeVar = 39;
		
		// emits per second
		self.emissionRate = self.totalParticles/self.life;
		
		// additive
		self.blendAdditive = NO;
		
		self.autoRemoveOnFinish =YES;
	}
	return self;
}

@end
