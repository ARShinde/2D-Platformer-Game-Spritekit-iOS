//
//  NSObject+gameData.m
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 04/02/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import "gameData.h"

@interface gameData ()
@property NSString *filepath;
@end

@implementation gameData

+(id)data{
    gameData *data=[[gameData alloc] init];
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName=@"archive.data";
    data.filepath=[path stringByAppendingString:fileName];
    
    return data;
    
}

-(void)save //write data to file
{
    NSNumber *highscoreObj=[NSNumber numberWithInteger:self.highscore];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:highscoreObj];//encoding stuff into data
    [data writeToFile:self.filepath atomically:YES];
    
}

-(void)load //load highscore from file
{
    NSData *data=[NSData dataWithContentsOfFile:self.filepath];
    NSNumber *highscoreObj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.highscore=highscoreObj.intValue;
}

@end
