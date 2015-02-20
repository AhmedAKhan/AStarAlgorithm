//
//  GameScene.m
//  AStarAlgorithmObjectiveC
//
//  Created by Ahmed Arif Khan on 2/18/15.
//  Copyright (c) 2015 Ahmed Khan. All rights reserved.
//

#import "GameScene.h"
#import "AStarAlgorithm.h"

@interface GameScene (){
    SKShapeNode * player;
    SKShapeNode * destination;
    CGSize sceneSize;
    
    NSArray * positions;
    AStarAlgorithm * solution;
}
@end

@implementation GameScene

//contants
static NSInteger const sizeOfBoard = 9;

-(id)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        /*
        NSInteger pos[9][9] = {   {1, 1, 1, 1, 1, 1, 1, 1, 0},
            {1, 1, 1, 1, 1, 1, 1, 1, 1},
            {1, 1, 1, 1, 0, 1, 1, 1, 1},
            {1, 1, 1, 1, 0, 1, 1, 1, 1},
            {1, 1, 1, 1, 0, 1, 1, 1, 1},
            {1, 1, 1, 1, 0, 1, 1, 1, 1},
            {1, 1, 1, 1, 0, 1, 1, 1, 1},
            {1, 1, 1, 1, 1, 1, 1, 1, 1},
            {1, 1, 1, 1, 1, 1, 1, 1, 1}};
    
        for(int i = 0; i < 9; i++){
            for(int c = 0; c < 9; c++){
                positions[i][c] = pos[i][c];
            }
        }*/
        positions = [NSArray arrayWithObjects:
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @0, @0, @0, @0, @0, @0, @0, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @1, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @1, @1, @1, @1, @1], nil];
        
        sceneSize = size;
        self.backgroundColor = [SKColor whiteColor];
        [self createTheBoardWithSize:size];
        
        CGPoint playerPosition = CGPointMake(2, 3);
        player = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(20, 20)];
        player.fillColor = [SKColor redColor];
        player.position = [self converTileToPointToScenePoint:playerPosition];
        [self addChild:player];
        
        CGPoint destinationPosition = CGPointMake(5, 3);
        destination = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(20, 20)];
        destination.fillColor = [SKColor blueColor];
        destination.position = [self converTileToPointToScenePoint:destinationPosition];
        [self addChild:destination];
        
        solution = [[AStarAlgorithm alloc] initWithPlayer:playerPosition andDestination:destinationPosition andBoard:positions];
//        NSArray * result = [AStarAlgorithm getPathFrom:playerPosition to:destinationPosition andBoard:positions];

//        NSLog(@"printing result");
//        NSString * resultAsString = @"";
//        for (NSValue * val in result) {
//            CGPoint pos = [val CGPointValue];
//            resultAsString = [NSString stringWithFormat:@"%@,(%f,%f)",resultAsString, pos.x, pos.y];
        //}
        //NSLog(@"%@", resultAsString);
        //NSLog(@"done printing result");
    }
    return self;
}
-(NSInteger)getCostOfTileX:(NSInteger)xPos andTileY:(NSInteger)yPos{ return [[[positions objectAtIndex:yPos] objectAtIndex:xPos] integerValue]; }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self playerMoveOnce];
}

-(void)playerMoveOnce{
    CGPoint newTilePoint = [solution getNextPositionForPlayer];
    player.position = (newTilePoint.x == -1 && newTilePoint.y == -1)? player.position:[self converTileToPointToScenePoint:newTilePoint];
    
}

-(CGPoint)converTileToPointToScenePoint:(CGPoint)point{
    point = CGPointMake(point.x - 4, point.y - 4);
    int const spaceBetweenTiles = 1;
    CGSize tileSize = CGSizeMake(32, 36);
    return CGPointMake(sceneSize.width/2+point.x*tileSize.width+point.x*spaceBetweenTiles, sceneSize.height/2+point.y*tileSize.height+point.y*spaceBetweenTiles);
}

-(void)createTheBoardWithSize:(CGSize)size {
    /*
     boart tiles numbers
     0 = empty
     1 = the player
     2 = enemy type 1
     3 = enemy type 2
     3 = enemy type 3
     ... and so on
     */
    
    for (int horCounter = 0; horCounter < sizeOfBoard; horCounter++){
        for(int verCounter = 0; verCounter < sizeOfBoard; verCounter++){
            //create the board
            if([[[positions objectAtIndex:verCounter] objectAtIndex:horCounter] integerValue]!= 1) continue;
            SKSpriteNode * tile = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"Tile_15"]];
            tile.position = [self converTileToPointToScenePoint:CGPointMake(horCounter, verCounter)];
            [self addChild:tile];
        }//end for verCounter
    }//end for horCounter
}//end func

-(void)update:(CFTimeInterval)currentTime {
    
}

@end
