//
//  AStarAlgorithm.h
//  AStarAlgorithmObjectiveC
//
//  Created by Ahmed Arif Khan on 2/18/15.
//  Copyright (c) 2015 Ahmed Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AStarAlgorithm : NSObject

-(id)initWithPlayer:(CGPoint)playerPos andDestination:(CGPoint)desPos;
-(CGPoint)getNextPositionForPlayer;

@end
