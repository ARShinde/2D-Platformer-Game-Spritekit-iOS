//
//  SKNode+worldGenerator.h
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 29/01/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface worldGenerator :SKNode
+(id)generateWorld:(SKNode *)world;
-(void)populate;
-(void)generate;

@end
