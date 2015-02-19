//
//  GameScene.h
//  AStarAlgorithmObjectiveC
//

//  Copyright (c) 2015 Ahmed Khan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

-(NSInteger)getCostOfTileX:(NSInteger)xPos andTileY:(NSInteger)yPos;

@end
