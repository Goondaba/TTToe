//
//  TTTHardSolver.m
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "TTTHardSolver.h"
#import "TTTSolveHelper.h"

@implementation TTTHardSolver

- (TTTBoardLocation *)moveOnBoard:(NSArray *)givenBoardlocations asPlayer:(TTTBoardChoice)givenPlayer{
    
    NSArray *winningPaths = [TTTSolveHelper winningPaths:givenBoardlocations];
    TTTBoardChoice enemyPlayer = !givenPlayer;
    
    //win
    for (NSArray *path in winningPaths) {
        if (([TTTSolveHelper choicesOf:givenPlayer inLocations:path] == 2) && ([TTTSolveHelper choicesOf:kTTTBoardChoiceEmpty inLocations:path] == 1)) {
            //choose winning spot
            return [[TTTSolveHelper emptySpotsinLocations:path] firstObject];
        }
    }
    
    //block
    for (NSArray *path in winningPaths) {
        if (([TTTSolveHelper choicesOf:enemyPlayer inLocations:path] == 2) && ([TTTSolveHelper choicesOf:kTTTBoardChoiceEmpty inLocations:path] == 1)) {
            //choose blocking spot
            return [[TTTSolveHelper emptySpotsinLocations:path] firstObject];
        }
    }
    
    //fork
    TTTBoardLocation *playerFork = [TTTSolveHelper forkingMoveForPlayer:givenPlayer onBoardLocations:givenBoardlocations];
    if (playerFork) {
        return playerFork;
    }
    
    //block fork
    TTTBoardLocation *enemyFork = [TTTSolveHelper forkingMoveForPlayer:enemyPlayer onBoardLocations:givenBoardlocations];
    if (enemyFork) {
        if (![TTTSolveHelper move:enemyFork forPlayer:givenPlayer wouldOpenEnemyForkOnBoardLocations:givenBoardlocations])
            return enemyFork;
    }
    
    //center
    TTTBoardLocation *center = givenBoardlocations[1][1];
    if ([center choice] == kTTTBoardChoiceEmpty) {
        return center;
    }
    
    NSArray *opposingCorners = [TTTSolveHelper opposingCorners:givenBoardlocations];
    
    //opposing corner
    for (NSArray *opposingPair in opposingCorners) {
        if (([[opposingPair firstObject] choice] == enemyPlayer) && ([[opposingPair lastObject] choice] == kTTTBoardChoiceEmpty))
            return [opposingPair lastObject];
        else if (([[opposingPair lastObject] choice] == enemyPlayer) && ([[opposingPair firstObject] choice] == kTTTBoardChoiceEmpty))
            return [opposingPair firstObject];
    }
    
    //corner
    for (NSArray *opposingPair in opposingCorners) {
        for (TTTBoardLocation *loc in opposingPair) {
            if (([loc choice] == kTTTBoardChoiceEmpty))
                if (![TTTSolveHelper move:loc forPlayer:givenPlayer wouldOpenEnemyForkOnBoardLocations:givenBoardlocations])
                    return loc;
        }
    }
    
    
    //side
    for (TTTBoardLocation *loc in [TTTSolveHelper sideSpots:givenBoardlocations]) {
        if (([loc choice] == kTTTBoardChoiceEmpty))
            return loc;
    }
    
    
    //fallback - pick first empty spot
    return [[TTTSolveHelper emptySpotsinBoardLocations:givenBoardlocations] firstObject];
    
    return nil;
}

@end