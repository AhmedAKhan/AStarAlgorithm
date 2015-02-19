//
//  AStarNode.m
//  AStarAlgorithmObjectiveC
//
//  Created by Ahmed Arif Khan on 2/18/15.
//  Copyright (c) 2015 Ahmed Khan. All rights reserved.
//

#import "AStarNode.h"

@interface AStarNode (){
    CGPoint tilePosition;
    AStarNode * parent;
    NSInteger fScore;
    NSInteger gScore;
    CGPoint destination;
}

@end

@implementation AStarNode

-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par{
    if(self = [super init]){
        tilePosition = pos;
        parent = par;
        if(parent == NULL) fScore = 1;
        else fScore = [parent getGScore] + 1;
    }
    return self;
}
-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par toDestination:(CGPoint)des{
    if(self = [super init]){
        tilePosition = pos;
        parent = par;
        if(parent == NULL) fScore = 1;
        else fScore = [parent getGScore] + 1;
        destination = des;
    }
    return self;
}
-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par andIncreaseGBy:(NSInteger)gIncrementer{
    if(self = [super init]){
        tilePosition = pos;
        parent = par;
        if(parent == NULL) fScore = gIncrementer;
        else fScore = [parent getGScore] + gIncrementer;
    }
    return self;
}

-(void)setParent:(AStarNode *)newParent{    parent = newParent; }
-(void)setFScore:(NSInteger)newFScore {     fScore = newFScore; }
-(void)setGScore:(NSInteger)newGScore{      gScore = newGScore; }
-(CGPoint)getPosition{ return tilePosition; }
-(NSInteger)getFScore{ return gScore + (abs(destination.x - tilePosition.x) + abs(destination.y - tilePosition.y)); }
-(NSInteger)getGScore{ return gScore; }
-(NSString *)description{
    return [NSString stringWithFormat:@"(score:%li andPos:(%f,%f))", (long)[self getFScore], tilePosition.x, tilePosition.y];
}

@end
