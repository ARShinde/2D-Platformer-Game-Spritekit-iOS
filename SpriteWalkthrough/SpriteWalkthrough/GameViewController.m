//
//  GameViewController.m
//  SpriteWalkthrough
//
//  Created by Abhishek Shinde on 27/01/15.
//  Copyright (c) 2015 com.claricetechnologies. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"


@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    /*here we are configuring the view of spriteKit */
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
//    skView.showsDrawCount=YES;
//    skView.showsNodeCount=YES;
//    skView.showsPhysics=YES;
//    skView.showsQuadCount=YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    
    GameScene *scene = [[GameScene alloc] initWithSize:CGSizeMake(skView.frame.size.width, skView.frame.size.height)];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    scene.backgroundColor=[SKColor redColor];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
