//
//  AStarNode.h
//  AStarAlgorithmObjectiveC
//
//  Created by Ahmed Arif Khan on 2/18/15.
//  Copyright (c) 2015 Ahmed Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AStarNode : NSObject

-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par toDestination:(CGPoint)des;
-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par andIncreaseGBy:(NSInteger)gIncrementer;
-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par;
//-(id)initWithPos:(CGPoint)pos andParent:(AStarNode *)par andfScore:(NSInteger)newfScore;
-(CGPoint)getPosition;
-(NSInteger)getFScore;
-(NSInteger)getGScore;
-(void)setParent:(AStarNode *)newParent;
-(void)setFScore:(NSInteger)newFScore;
-(void)setGScore:(NSInteger)newGScore;
-(NSString *)printPath;
-(AStarNode *)getParent;
@end
