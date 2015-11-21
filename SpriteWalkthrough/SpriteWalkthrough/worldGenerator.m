//
//  SKNode+worldGenerator.m
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 29/01/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import "worldGenerator.h"

@interface worldGenerator ()
@property double currentGroundX;
@property double currenetBgX;
@property double currentObstracleX;
@property SKNode *world;

@end

@implementation worldGenerator
{int randomPosition;
}
static const uint32_t obstaracleCateogry = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t seaCategory = 0x1 <<3;

+(id) generateWorld:(SKNode *) world //setting ground and obstraclex
{
    worldGenerator *gen=[worldGenerator node];
    gen.currentGroundX=0;
    gen.currentObstracleX=400;
    gen.currenetBgX=0;
    gen.world=world;
    return gen;
}


-(void)populate //draw things in the world
{
    for(int i=0;i<3;i++)
    {
        [self generate];
    }
}

-(void)generate
{
    long temp;
    temp=arc4random()%200+250;

    
    if (temp>300)
    {   //create obstracle Of the ground
        
        SKSpriteNode *bgnode=[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
        
        bgnode.position=CGPointMake(self.currenetBgX,-self.scene.frame.size.height/2+bgnode.frame.size.height/2);
        
        self.currenetBgX+=bgnode.frame.size.width;
        [self.world addChild:bgnode];
        bgnode.scene.scaleMode=SKSceneScaleModeResizeFill;
        
        SKSpriteNode *node=[SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.0f] size:CGSizeMake(self.scene.frame.size.width,self.scene.frame.size.height/10)];
        node.zPosition=-1;

        node.position=CGPointMake(self.currentGroundX,-self.scene.frame.size.height/2+node.frame.size.height/2);
        
        node.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:node.size];
        node.physicsBody.dynamic=NO;
        
        node.physicsBody.categoryBitMask=groundCategory;
        node.name=@"ground";
        [self.world addChild:node];
        
        self.currentGroundX+=node.frame.size.width;
        
        int randHeight;
        randHeight=arc4random()%100+35;
        self.currentObstracleX+=temp;
        SKSpriteNode *obstracle=[SKSpriteNode spriteNodeWithImageNamed:@"RoadBlock.png"];
        obstracle.size=CGSizeMake(40,40);

//        SKSpriteNode *obstracle=[SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:CGSizeMake(30,40)];
        obstracle.position=CGPointMake(self.currentObstracleX,-self.scene.frame.size.height/3);
        obstracle.name=@"obstracle";
//        obstracle.position=CGPointMake(self.currentObstracleX,self.scene.frame.size.height/15);

        obstracle.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:15.0f];
        obstracle.physicsBody.dynamic=NO;
        obstracle.physicsBody.categoryBitMask=obstaracleCateogry;
        obstracle.zPosition=3.0f;
        
        [self.world addChild:obstracle];
        
        if(temp<390 && temp>300)/*creating smaller well*/
        {

            
//            SKSpriteNode *node=[SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f] size:CGSizeMake(self.scene.frame.size.width,self.scene.frame.size.height/10)];
//
//            
//            
//            node.position=CGPointMake(self.currentGroundX+70,-self.scene.frame.size.height/2+node.frame.size.height/2);
//            
//            node.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:node.size];
//            node.physicsBody.dynamic=NO;
//            
//            node.physicsBody.categoryBitMask=groundCategory;
//            node.name=@"ground";
//            [self.world addChild:node];
//
            
            SKSpriteNode *spikesNode=[SKSpriteNode spriteNodeWithImageNamed:@"redheart.png"];
            spikesNode.position=CGPointMake(self.currentObstracleX+temp*temp/(temp/4),-self.scene.frame.size.height/5);
            spikesNode.size=CGSizeMake(40,40);
            
            

            spikesNode.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:spikesNode.size];
            spikesNode.physicsBody.dynamic=NO;
            
            
            spikesNode.physicsBody.categoryBitMask=seaCategory;
            spikesNode.physicsBody.collisionBitMask=seaCategory;
            spikesNode.physicsBody.contactTestBitMask=seaCategory;
            spikesNode.name=@"balloon";
            
            //[self.world addChild:spikesNode];
//
         //  self.currentGroundX+=node.frame.size.width;
        }

    }
    else
    {  //create obstracle on ground
       // SKSpriteNode *node=[SKSpriteNode spriteNodeWithImageNamed:@"grnd.jpg"];
        SKSpriteNode *node=[SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f] size:CGSizeMake(self.scene.frame.size.width,self.scene.frame.size.height/10)];
        SKSpriteNode *bgnode=[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
        
        bgnode.position=CGPointMake(self.currenetBgX,-self.scene.frame.size.height/2+bgnode.frame.size.height/2);
        
        self.currenetBgX+=bgnode.frame.size.width;
        [self.world addChild:bgnode];

        node.position=CGPointMake(self.currentGroundX,-self.scene.frame.size.height/2+node.frame.size.height/2);
        
        node.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:node.size];
        node.physicsBody.dynamic=NO;
        
        node.physicsBody.categoryBitMask=groundCategory;
        node.name=@"ground";
        [self.world addChild:node];
        
        self.currentGroundX+=node.frame.size.width;
        
        self.currentObstracleX+=250;
//        SKSpriteNode *obstracle=[SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:CGSizeMake(30,40)];
        SKSpriteNode *obstracle=[SKSpriteNode spriteNodeWithImageNamed:@"RoadBlock.png"];
        obstracle.size=CGSizeMake(40, 40);

        obstracle.position=CGPointMake(self.currentObstracleX,-self.scene.frame.size.height/3);
        obstracle.name=@"obstracle";
        obstracle.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:15.0f];
        obstracle.physicsBody.dynamic=NO;
        obstracle.physicsBody.categoryBitMask=obstaracleCateogry;
        obstracle.zPosition=3.0f;
        [self.world addChild:obstracle];
        
        
        

        
    }
    
}


-(UIColor *)getRandomColor
{
    int rand;
    UIColor *color;
    rand=arc4random()%6;
    switch (rand) {
        case 0:
            color=[UIColor redColor];
            break;
        case 1:
            color=[UIColor lightGrayColor];
            break;
        case 2:
            color=[UIColor magentaColor];
            break;
        case 3:
            color=[UIColor purpleColor];
            break;
        case 4:
            color=[UIColor darkGrayColor];
            break;
        case 5:
            color=[UIColor blueColor];
            break;
        default:
            break;
    }
    return color;
}
@end
