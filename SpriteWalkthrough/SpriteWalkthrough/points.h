//
//  SKLabelNode+point.h
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 02/02/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface points:SKLabelNode
@property int number;
+(id)pointslabelWithFontnames:(NSString *)fontname;
-(void)incrementScore;
-(void) setpoints:(int) points;
-(void) reset;
@end
