//
//  AStarAlgorithm.m
//  AStarAlgorithmObjectiveC
//
//  Created by Ahmed Arif Khan on 2/18/15.
//  Copyright (c) 2015 Ahmed Khan. All rights reserved.
//

#import "AStarAlgorithm.h"
#import "AStarNode.h"

@interface AStarAlgorithm (){
    NSMutableArray * openList;
    NSMutableArray * closedList;
    CGPoint destinationPosition;
}

@end

@implementation AStarAlgorithm


-(id)initWithPlayer:(CGPoint)playerPos andDestination:(CGPoint)desPos{
    if(self = [super init]){
        //constructor code
        destinationPosition = desPos;
        //[openList addObject:[[AStarNode alloc] initWithPos:CGPointMake(0,0) andDestination:CGP]]
        [openList addObject:[[AStarNode alloc] initWithPos:playerPos andParent:NULL]];
        [self findSolution];
    }
    return self;
}

-(void)findSolution{
    
}

-(NSInteger)findFScoreOf:(AStarNode *)node{
    return [node getGScore] + [self findHScoreOf:node];
}

-(NSInteger)findHScoreOf:(AStarNode *)node{
    CGPoint nodePosition = [node getPosition];
    return abs(destinationPosition.x - nodePosition.x) + abs(destinationPosition.y - nodePosition.y);
}

-(CGPoint)getNextPositionForPlayer{
    AStarNode * node = [closedList objectAtIndex:closedList.count-1];
    return [node getPosition];
}

@end


/*
    1. add all the points that the player can take into the open list
    2. take the one with the smallest cost F score and add it to the closed list
    3. find all the possible places the player can go. for each place do the following
        - if it is in the the closed list ignore it
        - if it is not in the open list then add it and compute its score
        - if if it is already in the open list then if its F score is smaller in the current path then update its score
*/