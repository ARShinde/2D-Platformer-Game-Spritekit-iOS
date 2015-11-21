//
//  GameScene.m
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 27/01/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import "GameScene.h"
#import "Hero.h"
#import "points.h"
#import "worldGenerator.h"
#import "gameData.h"

@interface GameScene ()
    @property BOOL isgameStarted; //default it is falase / no
    @property BOOL isgameOver;
@end

@implementation GameScene
{
    Hero *hero;
    SKNode *world;
    worldGenerator *gen;
    points *pointLab;
}

static NSString *Game_Font=@"AmericanTypewriter-Bold";

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.anchorPoint=CGPointMake(0.2, 0.5);//x and y cordinate is in between to 0(min)and 1(max)
   // self.backgroundColor=[SKColor colorWithRed:0.54 green:0.7853 blue:1 alpha:1.0f];
    self.physicsWorld.contactDelegate=self;
    //contactdelegate - protocal added to game scene class- need to implement method
    self.scene.backgroundColor=[SKColor colorWithRed:146.0f green:247.0f blue:191.0f alpha:1.0f];
   
//    self.view.backgroundColor=[UIColor colorWithRed:146.0f green:247.0f blue:191.0f alpha:1.0f];
    //self.scene.backgroundColor = [SKColor blueColor];
    world=[SKNode node];    
    [self addChild:world];


    
    
    gen=[worldGenerator generateWorld:world];
    [self addChild:gen];
    [gen populate];
    
    
    hero=[Hero MLhero];
    SKAction *inf=[SKAction scaleBy:1.4 duration:0.0008];
//    [self runAction:inf];
    [hero runAction:inf];
    [world addChild:hero];
    
    [self loadHighscoreLab];
    
    
    SKLabelNode *tapToBeginLabel =[SKLabelNode labelNodeWithFontNamed:Game_Font];
    
    tapToBeginLabel.name=@"tapToBeginLabel";
    tapToBeginLabel.text=@"Tap To Start";
    [tapToBeginLabel setFontSize:24];
    tapToBeginLabel.position=CGPointMake(self.scene.frame.size.width/3-20,50);
    [self addChild:tapToBeginLabel];
    [self animateWithPulse:tapToBeginLabel];
    [self loadClouds];
 
    
}

-(void)loadHighscoreLab
{
    pointLab=[points pointslabelWithFontnames:Game_Font];
    pointLab.name=@"pointLab";
    pointLab.position=CGPointMake(-self.scene.frame.size.width/10,self.scene.frame.size.height/3);
    
    NSLog(@"%f , %f",-self.scene.frame.size.width/10,self.scene.frame.size.height/3);
    [self addChild:pointLab];
    
    gameData *data=[gameData data];
    [data load];//read data from file
    
    
    
    points *highscoreLabel=[points pointslabelWithFontnames:Game_Font];
    highscoreLabel.text=@"0";
    highscoreLabel.name=@"highScore";
    highscoreLabel.position=CGPointMake(self.scene.frame.size.width/1.4,self.scene.frame.size.height/3);
    [highscoreLabel setpoints: data.highscore];
    [self addChild:highscoreLabel];
    
    SKLabelNode *bestLabel=[SKLabelNode labelNodeWithFontNamed:Game_Font];
    bestLabel.text=@"Best";
    bestLabel.fontSize=24;
    bestLabel.position=CGPointMake(-45,0);
    [highscoreLabel addChild:bestLabel];
    
    
    SKSpriteNode *consoleAbtn=[SKSpriteNode spriteNodeWithImageNamed:@"a.png"];
    consoleAbtn.name=@"aButton";
    consoleAbtn.position=CGPointMake(100,-100);
    consoleAbtn.size=CGSizeMake(30, 30);
   // [self addChild:consoleAbtn];
    
    
}
-(void)loadClouds
{
//    SKShapeNode *cloude1=[SKShapeNode node];
//    cloude1.path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,65, 100,40)].CGPath;
//    cloude1.fillColor=[UIColor whiteColor];
//    cloude1.strokeColor=[UIColor blueColor];
//    [world addChild:cloude1];
//
//    SKShapeNode *cloude2=[SKShapeNode node];
//    cloude2.path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-250,45, 100,40)].CGPath;
//    cloude2.fillColor=[UIColor whiteColor];
//    cloude2.strokeColor=[UIColor blueColor];
//    [world addChild:cloude2];

}


-(void)didBeginContact:(SKPhysicsContact *)contact

{
    NSLog(@"Body A: %@ contacting Body B: %@",contact.bodyA.node.name, contact.bodyB.node.name);


    if([contact.bodyA.node.name  isEqualToString:@"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"])
    {
        [hero land];
    }
  else  if ([contact.bodyA.node.name isEqualToString:@"balloon"] && [contact.bodyB.node.name isEqualToString:@"hero"]) {
      //[self gameOver];
//      [contact.bodyA.node removeFromParent];

      ///[contact.bodyA.node removeFromParent];
      SKSpriteNode *firstNode = (SKSpriteNode *) contact.bodyA.node;
      [firstNode removeFromParent];
      
      //SKAction *moveF=[SKAction moveByX:40 y:100  duration:0.008];
      //[hero jump];
      //[hero runAction:moveF];

      //   [hero jump];
  }
    //else{[self gameOver];}
    else
    if ([contact.bodyB.node.name isEqualToString:@"balloon"]) {
      //  [[self childNodeWithName:@"balloon"] removeFromParent];
     //      [self removeFromParent];
    }else{[self gameOver];}
}

-(void)start //when you start game then...
{
    self.isgameStarted=YES;
    [[self childNodeWithName:@"tapToBeginLabel"] removeFromParent];
    [[self childNodeWithName:@"tapToResetLabel"] removeFromParent];
    [hero start];
}

-(void)clear // when you want to restart in the screen
{ //create all fro, the scratch...
  //easier way to
    GameScene *scene=[[GameScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:scene];
}
-(void)gameOver
{
    self.isgameOver=YES;
    [hero stop];
    SKLabelNode *gameOver=[SKLabelNode labelNodeWithFontNamed:Game_Font];
    gameOver.text=@"Game Over";
    
    gameOver.position=CGPointMake(self.scene.frame.size.width/3-20,50);
//    gameOver.position=CGPointMake(self.scene.frame.size.width/3,self.scene.frame.size.height/15);
    [self addChild:gameOver];
    //here ist
    
    [self runAction:[SKAction playSoundFileNamed:@"Applause.mp3" waitForCompletion:NO]];
    SKLabelNode *tapToResetLabel=[SKLabelNode labelNodeWithFontNamed:Game_Font];
    tapToResetLabel.text=@"tap to reset";
    tapToResetLabel.name=@"tapToResetLabel";
    tapToResetLabel.fontSize=22.0f;
//    tapToResetLabel.position=CGPointMake(150,0);
//    
    tapToResetLabel.position=CGPointMake(self.scene.frame.size.width/3-20,0);
    [self addChild:tapToResetLabel];
    [self animateWithPulse:tapToResetLabel];
    [self updateHighScore];
}
-(void)updateHighScore
{
    points *pointslabb=(points *)[self childNodeWithName:@"pointLab"];
    points *highlab=(points *)[self childNodeWithName:@"highScore"];
    
    if(pointslabb.number > highlab.number)
    {
        [highlab setpoints:pointLab.number];
        gameData *data=[gameData data];
        data.highscore=pointLab.number;
        [data save];
    }
}
-(void)didSimulatePhysics  //called every single time when block moves
{
    [self centeronNode:hero];
    [self handlePoints];//placement is important over here
    [self handleGeneration];
    [self handleCleanup];
}

-(void) handlePoints
{
  [world enumerateChildNodesWithName:@"obstracle" usingBlock:^(SKNode *node, BOOL *stop) {
      if(node.position.x < hero.position.x)
      {
           pointLab=(points *)[self childNodeWithName:@"pointLab"];
          [pointLab incrementScore];
          
      }
  }];

}

-(void) handleGeneration//call generate method every shingle time hero jump from block
{
    [world enumerateChildNodesWithName:@"obstracle" usingBlock:^(SKNode *node, BOOL *stop) {
        if(node.position.x < hero.position.x)
        {
            node.name =@"Obstracle_cancelled"; // hero is passeed the obstracle
            [gen generate]; // call on every jump
        }
    }];
    [world enumerateChildNodesWithName:@"spikes" usingBlock:^(SKNode *node, BOOL *stop) {
        if(node.position.x<hero.position.x)
        {
            node.name=@"spikesCleared";
            [gen generate];
        }
    }];
        
}
-(void) handleCleanup
{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if(node.position.x < hero.position.x -self.frame.size.width/2-node.frame.size.width/2)
        [node removeFromParent];
    }];
    
    
    [world enumerateChildNodesWithName:@"Obstracle_cancelled" usingBlock:^(SKNode *node, BOOL *stop) {
        if(node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2)
            [node removeFromParent];
    }];
}

-(void)centeronNode:(SKNode *)node
{
    CGPoint positionInScene=[self convertPoint:node.position fromNode:node.parent];
    //convert co-ordinates
    world.position=CGPointMake(world.position.x-positionInScene.x, world.position.y);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInNode:self];
//    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
//    for (SKNode *node in nodes) {
//        
//        //or check the node against your nodes
//        if ([node.name isEqualToString:@"aButton"]) {
//            [hero walk];
//            if(!self.isgameStarted)
//            {    [self start];
//            }
//            else if(self.isgameOver)
//            {[self clear];
//            }else{
//                [hero jump];
//            }
//        }
//        
//        if ([node.name isEqualToString:@"myNode2"]) {
//            //...
//        }
//    }
    if(!self.isgameStarted)
    {    [self start];
    }
    else if(self.isgameOver)
    {[self clear];
    }else{
        [hero jump];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

}


/*Animation Section*/
-(void)animateWithPulse:(SKNode *)node
{
    SKAction *disApper=[SKAction fadeAlphaTo:0.0 duration:0.6];
    SKAction *apper=[SKAction fadeAlphaTo:1.0 duration:0.6];

    SKAction *pulse=[SKAction sequence:@[disApper,apper]];
    
    [node runAction:[SKAction repeatActionForever:pulse]];
    
}



@end
