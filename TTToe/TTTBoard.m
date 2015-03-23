//
//  TTTBoard.m
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "TTTBoard.h"
#import "TTTHardSolver.h"
#import "TTTSolveHelper.h"

@interface TTTBoard ()
@property (nonatomic) NSArray *boardLocations;
@end

@implementation TTTBoardLocation

- (id)init {
    self = [super init];
    if (self) {
        _choice = kTTTBoardChoiceEmpty;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.x = [decoder decodeIntForKey:@"x"];
    self.y = [decoder decodeIntForKey:@"y"];
    self.choice = [decoder decodeIntForKey:@"choice"];
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.x forKey:@"x"];
    [encoder encodeInt:self.y forKey:@"y"];
    [encoder encodeInt:self.choice forKey:@"choice"];
}

- (void)markWithChoice:(TTTBoardChoice)givenChoice {
    self.choice = givenChoice;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%d,%d):%@", self.x, self.y, self.stringRepresentation];
}

- (NSString *)stringRepresentation {
    if (self.choice == kTTTBoardChoiceO)
        return @"o";
    else if (self.choice == kTTTBoardChoiceX)
        return @"x";
    else
        return @" ";
}

@end

@implementation TTTBoard

+(TTTBoard *)gameBoard {
    static dispatch_once_t pred;
    static TTTBoard *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[TTTBoard alloc] init];
    });
    
    return shared;
}

-(BOOL)markLocationX:(int)x andY:(int)y withChoice:(TTTBoardChoice)givenChoice {
    
    if ([self.boardLocations[x][y] choice] != kTTTBoardChoiceEmpty) {
        NSLog(@"No move to be made; spot already taken");
        return NO;
    }
    
    if ((x < 0) || (x > 2) || (y < 0) || (y > 2)){
        NSLog(@"No move to be made; out of bounds");
        return NO;
    }
    
    if (self.gameOver) {
        NSLog(@"No move to be made; game over");
        return NO;
    }
    
    [self.boardLocations[x][y] setChoice:givenChoice];
    return YES;
}

- (int)gameWinner {
    
    //look for a winner
    for (NSMutableArray *path in [TTTSolveHelper winningPaths:self.boardLocations]) {
        
        TTTBoardLocation *first  = [path firstObject];
        TTTBoardLocation *second = [path objectAtIndex:1];
        TTTBoardLocation *third  = [path lastObject];
        
        if (first.choice != kTTTBoardChoiceEmpty) {
            if ((first.choice == second.choice) && (second.choice == third.choice)) {
                return first.choice;
            }
        }
    }
    
    return -1;
}

- (BOOL)gameOver {
    return (([self gameWinner] >= 0) || ([[TTTSolveHelper emptySpotsinBoardLocations:self.boardLocations] count] == 0));
}

- (void)clearBoard{
    for (NSArray *arr in self.boardLocations) {
        for (TTTBoardLocation *location in arr) {
            location.choice = kTTTBoardChoiceEmpty;
        }
    }
}

-(TTTBoardLocation *)moveAsPlayer:(TTTBoardChoice)givenPlayer {
    return [self.solverDelegate moveOnBoard:self.boardLocations asPlayer:givenPlayer];
}

- (NSString *)stringRepresentation {
    
    NSMutableString *boardString = [NSMutableString string];
    for (int i=2; i >= 0; i--) {
        [boardString appendFormat:@"\n%@|%@|%@\n", [self.boardLocations[0][i] stringRepresentation],
         [self.boardLocations[1][i] stringRepresentation],
         [self.boardLocations[2][i] stringRepresentation]];
        
        if (i>0)
            [boardString appendString:@"-----"];
    }
    
    return boardString;
}

- (id)init {
    self = [super init];
    if (self) {
        
        //build board locations
        NSMutableArray *tempLocationArr = [NSMutableArray array];
        
        for (int i=0; i<3; i++) {
            
            NSMutableArray *tempInnerArr = [NSMutableArray array];
            
            for (int j=0; j<3; j++) {
                TTTBoardLocation *newLocation = [[TTTBoardLocation alloc] init];
                newLocation.x = i;
                newLocation.y = j;
                
                [tempInnerArr addObject:newLocation];
            }
            
            NSArray *innerArr = [NSArray arrayWithArray:tempInnerArr];
            [tempLocationArr addObject:innerArr];
        }
        
        _boardLocations = [NSArray arrayWithArray:tempLocationArr];
        
    }
    
    return self;
}

@end