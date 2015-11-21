//
//  SKSpriteNode+Hero.m
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 28/01/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import "Hero.h"

@interface Hero ()
@property BOOL isJumping;

@property NSArray *heroWalk;
@end

@implementation Hero
NSMutableArray *walkframe;
SKTextureAtlas *walkcycle;
int numImg,count=0;
float  walkSpeed=999;
static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t obstaracleCateogry = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t seaCategory = 0x1 << 3;


+(id)MLhero
{
    
    Hero *hero=[Hero spriteNodeWithImageNamed:@"1.png"];
    //hero.size=CGSizeMake(150, 150);
    hero.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(hero.size.height, hero.size.height)];
    

    //collision detection code
    hero.physicsBody.categoryBitMask=heroCategory;
    hero.physicsBody.contactTestBitMask=obstaracleCateogry | groundCategory | seaCategory;
//    hero.physicsBody.allowsRotation = NO;
    
    hero.name=@"hero";

    return hero;
}

-(void)walk
{

  //  SKAction *walk=[SKAction moveByX:10 y:0 duration:0];
   // [self runAction:walk];

}

-(void)jump
{
    if(!self.isJumping){
        [self.physicsBody applyImpulse:CGVectorMake(5,24)];
        [self runAction:[SKAction playSoundFileNamed:@"jump.mp3" waitForCompletion:YES]];
        
        
        
        walkframe=[NSMutableArray array];
        walkcycle=[SKTextureAtlas atlasNamed:@"jumpCycle"];
        numImg = walkcycle.textureNames.count;
        
        for(int i=1;i<numImg;i++)
        {
            NSString *textureName=[NSString stringWithFormat:@"jump%d",i];
            SKTexture *temp=[walkcycle  textureNamed:textureName];
            [walkframe addObject:temp];
        }
        self.heroWalk=walkframe;
        [self runAction:[SKAction repeatAction:[SKAction animateWithTextures:_heroWalk timePerFrame:0.1f resize:YES restore:YES] count:1]];

        self.isJumping=YES;
    }
}
-(void)land
{
    self.isJumping=NO;
}
-(void)stop
{
    [self removeAllActions];
}

-(void)start //move hero forwored until he move forword
{

    
    walkframe=[NSMutableArray array];
    walkcycle=[SKTextureAtlas atlasNamed:@"walkCycle"];
    numImg= walkcycle.textureNames.count;
    
    for(int i=1;i<numImg;i++)
    {
        NSString *textureName=[NSString stringWithFormat:@"walk%d",i];
        SKTexture *temp=[walkcycle  textureNamed:textureName];
        [walkframe addObject:temp];
    }
    self.heroWalk=walkframe;
    
    SKAction *incrementRight=[SKAction moveByX:1 y:0 duration:0.006];
    SKAction *moveRight=[SKAction repeatActionForever:incrementRight];

    [self runAction:moveRight];
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_heroWalk timePerFrame:0.2f resize:YES restore:YES]]];
}
@end
