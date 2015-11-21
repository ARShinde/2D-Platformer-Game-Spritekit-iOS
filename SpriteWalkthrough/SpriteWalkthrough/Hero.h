//
//  SKSpriteNode+Hero.h
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 28/01/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Hero :SKSpriteNode
@property (nonatomic,retain) NSMutableArray *walkframe;
@property SKTextureAtlas *walkcycle;
+(id)MLhero;
-(void)walk;
-(void)jump;
-(void)land;
-(void)start;
-(void)stop;
@end
