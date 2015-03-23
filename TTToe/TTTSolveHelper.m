//
//  TTTSolveHelper.m
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "TTTSolveHelper.h"

@implementation TTTSolveHelper

+ (BOOL)move:(TTTBoardLocation *)location forPlayer:(TTTBoardChoice)givenPlayer wouldOpenEnemyForkOnBoardLocations:(NSArray *)boardLocations{
    
    NSArray *testLocations = [NSKeyedUnarchiver unarchiveObjectWithData:
                              [NSKeyedArchiver archivedDataWithRootObject:boardLocations]];
    [testLocations[location.x][location.y] setChoice:givenPlayer];
    
    return ([TTTSolveHelper forkingMoveForPlayer:(!givenPlayer) onBoardLocations:testLocations] != nil);
}

+ (TTTBoardLocation *)forkingMoveForPlayer:(TTTBoardChoice)givenPlayer onBoardLocations:(NSArray *)boardLocations {
    
    for(NSArray *arr in boardLocations) {
        for (TTTBoardLocation *loc in arr) {
            if (loc.choice == kTTTBoardChoiceEmpty) {
                
                NSArray *testLocations = [NSKeyedUnarchiver unarchiveObjectWithData:
                                          [NSKeyedArchiver archivedDataWithRootObject:boardLocations]];
                [testLocations[loc.x][loc.y] setChoice:givenPlayer];
                
                if([TTTSolveHelper possibleWinningPathsForPlayer:givenPlayer onBoardLocations:testLocations] > 1) {
                    return loc;
                }
                
            }
        }
    }
    
    return nil;
}

+ (NSArray *)sideSpots:(NSArray *)boardLocations {
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr addObject:boardLocations[0][1]];
    [arr addObject:boardLocations[1][2]];
    [arr addObject:boardLocations[2][1]];
    [arr addObject:boardLocations[1][0]];
    
    return arr;
}

+ (NSArray *)opposingCorners:(NSArray *)boardLocations {
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr addObject:@[boardLocations[0][0], boardLocations[2][2]]];
    [arr addObject:@[boardLocations[0][2], boardLocations[2][0]]];
    
    return arr;
}

+ (NSArray *)emptySpotsinBoardLocations:(NSArray *)boardLocations {
    NSMutableArray *empties = [NSMutableArray array];
    
    for (NSArray *loc in boardLocations) {
        [empties addObjectsFromArray:[TTTSolveHelper emptySpotsinLocations:loc]];
    }
    
    return empties;
}


+ (NSArray *)emptySpotsinLocations:(NSArray *)givenLocations {
    NSMutableArray *empties = [NSMutableArray array];
    
    for (TTTBoardLocation *loc in givenLocations) {
        if (loc.choice == kTTTBoardChoiceEmpty) {
            [empties addObject:loc];
        }
    }
    
    return empties;
}

+ (int)choicesOf:(TTTBoardChoice)givenChoice inLocations:(NSArray *)givenLocations {
    
    int choiceCounter = 0;
    
    for (TTTBoardLocation *loc in givenLocations) {
        if (loc.choice == givenChoice) {
            choiceCounter++;
        }
    }
    
    return choiceCounter;
}

+ (int)possibleWinningPathsForPlayer:(TTTBoardChoice)givenPlayer onBoardLocations:(NSArray *)boardLocations{
    
    int sum = 0;
    
    for (NSArray *path in [TTTSolveHelper winningPaths:boardLocations]) {
        BOOL twoFilled = ([TTTSolveHelper choicesOf:givenPlayer inLocations:path] == 2);
        BOOL oneEmpty  = ([TTTSolveHelper choicesOf:kTTTBoardChoiceEmpty inLocations:path] == 1);
        if (twoFilled && oneEmpty) {
            sum++;
        }
    }
    
    return sum;
}

+ (NSArray *)winningPaths:(NSArray *)boardLocations {
    NSMutableArray *winningPaths = [NSMutableArray array];
    
    //straight lines
    for (int i=0; i<3; i++) {
        
        NSMutableArray *colPath = [NSMutableArray array];
        NSMutableArray *rowPath = [NSMutableArray array];
        
        for (int j=0; j<3; j++) {
            [colPath addObject:boardLocations[i][j]];
            [rowPath addObject:boardLocations[j][i]];
        }
        
        [winningPaths addObject:colPath];
        [winningPaths addObject:rowPath];
    }
    
    //diagonals
    [winningPaths addObject:@[boardLocations[0][0],boardLocations[1][1],boardLocations[2][2]]];
    [winningPaths addObject:@[boardLocations[0][2],boardLocations[1][1],boardLocations[2][0]]];
    
    return winningPaths;
}

@end
