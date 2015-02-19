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
                    @[@1, @1, @1, @1, @1, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @0, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @1, @1, @1, @1, @1],
                    @[@1, @1, @1, @1, @1, @1, @1, @1, @1], nil];
        
        sceneSize = size;
        self.backgroundColor = [SKColor whiteColor];
        [self createTheBoardWithSize:size];
        
        CGPoint playerPosition = CGPointMake(-2, 0);
        player = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(20, 20)];
        player.fillColor = [SKColor redColor];
        player.position = [self converTileToPointToScenePoint:playerPosition];
        [self addChild:player];
        
        CGPoint destinationPosition = CGPointMake(1, -1);
        destination = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(20, 20)];
        destination.fillColor = [SKColor blueColor];
        destination.position = [self converTileToPointToScenePoint:destinationPosition];
        [self addChild:destination];
        
        AStarAlgorithm * solution = [[AStarAlgorithm alloc] initWithPlayer:playerPosition andDestination:destinationPosition andBoard:positions];//[[AStarAlgorithm alloc] initWithPlayer:[player position] andDestination:[player position]];
        
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
    
    
}

-(CGPoint)converTileToPointToScenePoint:(CGPoint)point{
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
            tile.position = [self converTileToPointToScenePoint:CGPointMake(4-horCounter, 4 - verCounter)];
            [self addChild:tile];
        }//end for verCounter
    }//end for horCounter
}//end func

-(void)update:(CFTimeInterval)currentTime {
    
}

@end
