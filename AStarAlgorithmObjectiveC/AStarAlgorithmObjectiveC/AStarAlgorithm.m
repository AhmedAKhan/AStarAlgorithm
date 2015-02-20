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
    AStarNode * playerNode;
    NSArray * positions;
}

@end

@implementation AStarAlgorithm

-(id)initWithPlayer:(CGPoint)playerPos andDestination:(CGPoint)desPos andBoard:(NSArray *)board{
    if(self = [super init]){
        openList = [NSMutableArray array];
        closedList = [NSMutableArray array];
        
        positions = board;
        destinationPosition = desPos;
        playerNode = [[AStarNode alloc] initWithPos:playerPos andParent:NULL toDestination:destinationPosition];
        [closedList addObject:playerNode];
        
        [self findSolution];
    }
    return self;
}

+(NSArray *)getPathFrom:(CGPoint)pos to:(CGPoint)destination andBoard:(NSArray *)board{
    AStarAlgorithm * alg = [[AStarAlgorithm alloc] initWithPlayer:pos andDestination:destination andBoard:board];
    //it found the solution, not lets put all the answers in an array of points
    NSMutableArray * points = [NSMutableArray array];
    while (true){
        CGPoint nextPosition = [alg getNextPositionForPlayer];
        if(nextPosition.x == -1 && nextPosition.y == -1) break;
        [points addObject:[NSValue valueWithCGPoint:nextPosition]];
    }
    
    return [NSArray arrayWithArray:points];
}

-(void)findSolution{
    //check fill open list from
    AStarNode * currentNode = playerNode;
    while (true) {
//        NSLog(@"openList: %@", [openList componentsJoinedByString:@", "]);
//        NSLog(@"closed List: %@\n\n", [closedList componentsJoinedByString:@", "]);
        //find all adjacent tiles add it to the open list, all the adjacent files to the closest thing that was added
        [self addAdjacentTilesToOpenListWherePossibleFrom:currentNode];
        
        //sort open list with F scores
        NSArray * newSortedList = [openList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            if([obj1 getFScore] < [obj2 getFScore]) return NSOrderedAscending;
            if([obj1 getFScore] > [obj2 getFScore]) return NSOrderedDescending;
            return NSOrderedSame; }];
        openList = [NSMutableArray arrayWithArray:newSortedList];
        
        //take the one with the lowest F and add it too the closed list
        //[self addNode:currentNode toParentIfNecessary:currentNode];
        currentNode =[openList objectAtIndex:0];//got the top element of the open list
        [closedList addObject:currentNode];//now add it to the closed list
        [openList removeObject:currentNode];//and remove it from the open list
        if(CGPointEqualToPoint([currentNode getPosition], destinationPosition)){

            break;
        }
    }
    
  //  NSLog(@"found a solution which is currentNode: %@", [currentNode printPath]);
    closedList = [NSMutableArray array];
    openList = [NSMutableArray array];
    while (currentNode != nil) {
        [closedList addObject:currentNode];
        currentNode = [currentNode getParent];
    }
    [closedList removeLastObject];
}

-(void)addAdjacentTilesToOpenListWherePossibleFrom:(AStarNode *)n{
    CGPoint pos = [n getPosition];
    
    //add all the adjacent tiles to the open list
    CGPoint upPosition = CGPointMake(pos.x, pos.y+1);
    CGPoint downPosition = CGPointMake(pos.x, pos.y-1);
    CGPoint rightPosition = CGPointMake(pos.x+1, pos.y);
    CGPoint leftPosition = CGPointMake(pos.x-1, pos.y);
    CGPoint possiblePaths[4] = {upPosition, rightPosition, downPosition, leftPosition};
    //converts everything to a tile and adds it into the possible positions
    for(int counter = 0; counter < 4; counter++){
        //make sure all the positions are possible
        if(possiblePaths[counter].y >= positions.count || possiblePaths[counter].y < 0) continue;
        if(possiblePaths[counter].x >= [[positions objectAtIndex:possiblePaths[counter].y] count] || possiblePaths[counter].x < 0) continue;
        if(possiblePaths[counter].x == 4){
            NSLog(@"point: (%f,%f)  positionsValue: %li", possiblePaths[counter].x, possiblePaths[counter].y, (long)[[[positions objectAtIndex:(possiblePaths[counter].y)] objectAtIndex:(possiblePaths[counter].x)] integerValue]);
        }
        if([[[positions objectAtIndex:(possiblePaths[counter].y)] objectAtIndex:(possiblePaths[counter].x)] integerValue] == 0) continue;
        
        
        //the position is possible
        //AStarNode * tile = [[AStarNode alloc] initWithPos:possiblePaths[counter] andParent:n];//made the tile
        AStarNode * tile = [[AStarNode alloc] initWithPos:possiblePaths[counter] andParent:n toDestination:destinationPosition];
        [self addNode:tile toParentIfNecessary:n];
     //   NSLog(@"tiles: %@ score: %li", [tile description], (long)[self findFScoreOf:tile]);
        //[openList addObject:tile]; //added the tile into the open list
    }
   // NSLog(@"before sorted %@", [openList componentsJoinedByString:@", "]);
}


-(void)addNode:(AStarNode *)node toParentIfNecessary:(AStarNode *)parentNode{
//    if([closedList containsObject:node]) return; // if it already exists in the closed list then ignore the node
    for(AStarNode * currentNode in closedList){
        if(CGPointEqualToPoint([currentNode getPosition], [node getPosition])){ return; }
    }
    //if it is already exists in the open list update its info if it needs to be updated
    if([openList containsObject:node]){
        if([node getGScore] > [parentNode getGScore] + [[[positions objectAtIndex:[node getPosition].y] objectAtIndex:[node getPosition].x] integerValue]){
            [node setParent:node];
            [node setGScore:([parentNode getGScore]+[[[positions objectAtIndex:[node getPosition].y] objectAtIndex:[node getPosition].x] integerValue])];
        }
        return;
    }
    [openList addObject:node];
    //the position is not in the open list or the closed list
    //we must add it into the closed list and remove it from the open list
    //[openList removeObject:node];//removed from the open list
    //[closedList addObject:node]; // added in the closed list
}
-(AStarNode *)doesOpenListContainPosition:(CGPoint)position{
    for (AStarNode * n in openList) { if(CGPointEqualToPoint([n getPosition], position)) return n; }
    return nil;
}
-(AStarNode *)doesClosedListContainPosition:(CGPoint)position{
    for (AStarNode * n in closedList) { if(CGPointEqualToPoint([n getPosition], position)) return n; }
    return nil;
}

-(NSInteger)findFScoreOf:(AStarNode *)node{ return [node getGScore] + [self findHScoreOf:node]; }
-(NSInteger)findHScoreOf:(AStarNode *)node{
    CGPoint nodePosition = [node getPosition];
    return abs(destinationPosition.x - nodePosition.x) + abs(destinationPosition.y - nodePosition.y);
}


-(CGPoint)getNextPositionForPlayer{
    if([closedList count] == 0) return CGPointMake(-1,-1);
    AStarNode * node = [closedList lastObject];
    [closedList removeObject:node];
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