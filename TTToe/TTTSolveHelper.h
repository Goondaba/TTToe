//
//  TTTSolveHelper.h
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTBoard.h"

@interface TTTSolveHelper : NSObject

/**
 *  Determines whether a given move for a player would open a forking opportunity for the enemy player
 *
 *  @param location       location to test
 *  @param givenPlayer    player to play as
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return whether an enemy fork would be created from this move
 */
+ (BOOL)move:(TTTBoardLocation *)location forPlayer:(TTTBoardChoice)givenPlayer wouldOpenEnemyForkOnBoardLocations:(NSArray *)boardLocations;

/**
 *  Determines whether the given player has a forking move available
 *
 *  @param givenPlayer    player to search for
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return forking move for player
 */
+ (TTTBoardLocation *)forkingMoveForPlayer:(TTTBoardChoice)givenPlayer onBoardLocations:(NSArray *)boardLocations;

/**
 *  Locations of side spots
 *
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return side spots
 */
+ (NSArray *)sideSpots:(NSArray *)boardLocations;

/**
 *  Locations of opposing corners
 *
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return opposing corners
 */
+ (NSArray *)opposingCorners:(NSArray *)boardLocations;

/**
 *  Finds empty board locations
 *
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return empty spots
 */
+ (NSArray *)emptySpotsinBoardLocations:(NSArray *)boardLocations;

/**
 *  Finds empty board locations
 *
 *  @param givenLocations one-dimensional array of board locations
 *
 *  @return empty spots
 */
+ (NSArray *)emptySpotsinLocations:(NSArray *)givenLocations;

/**
 *  Counts the number of occurences of a given choice in a set of locations
 *
 *  @param givenChoice    the choice to count occurences of
 *  @param givenLocations two-dimensional array of board locations
 *
 *  @return number of occurreces of given choice
 */
+ (int)choicesOf:(TTTBoardChoice)givenChoice inLocations:(NSArray *)givenLocations;

/**
 *  Counts the number of possible winning paths for a player
 *
 *  @param givenPlayer    player to play as
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return number of possible winning paths for the given player
 */
+ (int)possibleWinningPathsForPlayer:(TTTBoardChoice)givenPlayer onBoardLocations:(NSArray *)boardLocations;

/**
 *  Paths to win
 *
 *  @param boardLocations two-dimensional array of board locations
 *
 *  @return array of paths, each of which is an array
 */
+ (NSArray *)winningPaths:(NSArray *)boardLocations;

@end