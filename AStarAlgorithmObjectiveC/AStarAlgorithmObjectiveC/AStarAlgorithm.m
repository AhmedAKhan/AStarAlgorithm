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
    
    NSArray * positions;
}

@end

@implementation AStarAlgorithm

-(id)initWithPlayer:(CGPoint)playerPos andDestination:(CGPoint)desPos andBoard:(NSArray *)board{
    if(self = [super init]){
        openList = [NSMutableArray array];
        closedList = [NSMutableArray array];
        
        //tiles = board;
        positions = board;
        destinationPosition = desPos;
        [openList addObject:[[AStarNode alloc] initWithPos:playerPos andParent:NULL]];
        NSLog(@"%@", [openList componentsJoinedByString:@", "]);
        [self fillOpenListFrom:[openList objectAtIndex:0]];
        [self findSolution];
    }
    return self;
}

-(void)findSolution{
    //check fill open list from
    
    
}

-(void)fillOpenListFrom:(AStarNode *)n{
    CGPoint pos = [n getPosition];
    
    //add all the adjacent tiles to the open list
    CGPoint upPosition = CGPointMake(pos.x, pos.y+1);
    CGPoint downPosition = CGPointMake(pos.x, pos.y-1);
    CGPoint rightPosition = CGPointMake(pos.x+1, pos.y);
    CGPoint leftPosition = CGPointMake(pos.x-1, pos.y);
    CGPoint possiblePaths[4] = {upPosition, rightPosition, downPosition, leftPosition};
    for(int counter = 0; counter < 4; counter++){
        //make sure all the positions are possible
        NSLog(@"counter: %i", counter);
        NSLog(@"possiblePaths[counter]: (%f,%f)", possiblePaths[counter].x, possiblePaths[counter].y);
        //NSLog(@"[[positions objectAtIndex:possiblePaths[counter].y] objectAtIndex:possiblePaths[counter].x]: %@", [[positions objectAtIndex:possiblePaths[counter].y] objectAtIndex:possiblePaths[counter].x]);
//        NSLog(@"[[[positions objectAtIndex:possiblePaths[counter].y] objectAtIndex:possiblePaths[counter].x] integerValue]: %li", (long)[[[positions objectAtIndex:possiblePaths[counter].y] objectAtIndex:possiblePaths[counter].x] integerValue]);
        if([[[positions objectAtIndex:(possiblePaths[counter].y+4)] objectAtIndex:(possiblePaths[counter].x+4)] integerValue] == 0){
        //        if([[[positions objectAtIndex:(possiblePaths[counter].y objectAtIndex:possiblePaths[counter].x] integerValue]) == 0){
            //this position is not possible
            //possiblePaths[counter] = pos;
            continue;
        }
        
        //the position is possible
        AStarNode * tile = [[AStarNode alloc] initWithPos:possiblePaths[counter] andParent:n];//made the tile
        [openList addObject:tile]; //added the tile into the open list
    }
    
    //reorder the open list so that the tiles at the bottom have the lowest score
    NSArray * newSortedList = [openList sortedArrayUsingComparator:
                            ^NSComparisonResult(id obj1, id obj2) {
                                if ([self findFScoreOf:obj1] < [self findFScoreOf:obj2]) {
                                    return NSOrderedAscending;
                                } else if ([self findFScoreOf:obj1] > [self findFScoreOf:obj2]) {
                                    return NSOrderedDescending;
                                } else {
                                    return NSOrderedSame;
                                }
                            }];
    
    for(int i = 0; i < newSortedList.count; i++){
        NSLog(@"sortedList: %li", (long)[self findFScoreOf:[newSortedList objectAtIndex:i]]);
    }
    //then call the addNode to the tiles that were just added
}

-(void)addNode:(AStarNode *)node toParentIfNecessary:(AStarNode *)parentNode{
    if([closedList containsObject:node]) return; // if it already exists in the closed list then ignore the node
    //if it is already exists in the open list update its info if it needs to be updated
    if([openList containsObject:node]){
        if([node getGScore] > [parentNode getGScore] + [[[positions objectAtIndex:[node getPosition].y] objectAtIndex:[node getPosition].x] integerValue]){
            [node setParent:node];
            [node setGScore:([parentNode getGScore]+[[[positions objectAtIndex:[node getPosition].y] objectAtIndex:[node getPosition].x] integerValue])];
        }
        return;
    }
    //the position is not in the open list or the closed list
    //we must add it into the closed list and remove it from the open list
    [openList removeObject:node];//removed from the open list
    [closedList addObject:node]; // added in the closed list
}

-(AStarNode *)doesOpenListContainPosition:(CGPoint)position{
    for (AStarNode * n in openList) { if(CGPointEqualToPoint([n getPosition], position)) return n; }
    return nil;
}
-(AStarNode *)doesClosedListContainPosition:(CGPoint)position{
    for (AStarNode * n in closedList) { if(CGPointEqualToPoint([n getPosition], position)) return n; }
    return nil;
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