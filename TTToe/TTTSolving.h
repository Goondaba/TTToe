//
//  TTTSolving.h
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTBoard.h"

/**
 *  Protocol for Solvers
 */
@protocol TTTSolving <NSObject>

/**
 *  Provides a move to be made for a player
 *
 *  @param givenBoardlocations two-dimensional array of board locations
 *  @param givenPlayer         player to play as
 *
 *  @return the square to play
 */
- (TTTBoardLocation *)moveOnBoard:(NSArray *)givenBoardlocations asPlayer:(TTTBoardChoice)givenPlayer;
@end
