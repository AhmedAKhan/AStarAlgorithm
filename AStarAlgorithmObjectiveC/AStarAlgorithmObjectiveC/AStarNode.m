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
    NSInteger gScore;
}

@end

@implementation AStarNode

-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par{
    if(self = [super init]){
        tilePosition = pos;
        parent = par;
        if(parent == NULL) gScore = 1;
        else gScore = [parent getGScore] + 1;
    }
    return self;
}


-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par andIncreaseGBy:(NSInteger)gIncrementer{
    if(self = [super init]){
        tilePosition = pos;
        parent = par;
        if(parent == NULL) gScore = gIncrementer;
        else gScore = [parent getGScore] + gIncrementer;
    }
    return self;
}

-(void)setParent:(AStarNode *)newParent{ parent = newParent; }
-(void)setGScore:(NSInteger)newGScore { gScore = newGScore; }
-(CGPoint)getPosition{ return tilePosition; }
-(NSInteger)getGScore{ return gScore; }

-(NSString *)description{
    return [NSString stringWithFormat:@"(score:%li andPos:(%f,%f))", (long)gScore, tilePosition.x, tilePosition.y];
}

@end
