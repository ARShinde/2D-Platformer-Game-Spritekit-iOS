//
//  SKLabelNode+point.m
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 02/02/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import "points.h"

@implementation points

+(id)pointslabelWithFontnames:(NSString *)fontname
{
    points *ptlbl=[points labelNodeWithFontNamed:fontname];
    ptlbl.text=@"0";
//    ptlbl.position=[CGPointMake(self.sc, <#CGFloat y#>)]
    [ptlbl setFontSize:20];
    ptlbl.zPosition=999999;
//    ptlbl.fontColor=[UIColor blackColor];
    ptlbl.number=0;
    return ptlbl;
}


-(void)incrementScore
{
    self.number++;
    self.text=[NSString stringWithFormat:@"%i ",self.number];
}

-(void) setpoints:(int) points
{
    self.number=points;
    self.text=[NSString stringWithFormat:@"%i",self.number];
}

-(void) reset
{
    self.number=0;
 self.text=@"0";
}


@end

