//
//  TTTBoard.h
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kTTTBoardChoiceO,
    kTTTBoardChoiceX,
    kTTTBoardChoiceEmpty
} TTTBoardChoice;

/**
 *  Represents a location on the board
 */
@interface TTTBoardLocation : NSObject <NSCoding>
@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) TTTBoardChoice choice;

-(void)markWithChoice:(TTTBoardChoice)givenChoice;

/**
 *  String representation, unsuitable for description
 *
 *  @return string
 */
-(NSString *)stringRepresentation;
@end

/**
 *  Represents the game board
 */
@interface TTTBoard : NSObject
@property (nonatomic,weak) id solverDelegate;

+(TTTBoard *)gameBoard;
-(BOOL)markLocationX:(int)x andY:(int)y withChoice:(TTTBoardChoice)givenChoice;

/**
 *  The game winner expressed as TTTBoardChoice
 *  Returns -1 if there is no winner
 *
 *  @return the game winner
 */
-(int)gameWinner;
-(BOOL)gameOver;
-(void)clearBoard;
-(TTTBoardLocation *)moveAsPlayer:(TTTBoardChoice)givenPlayer;

/**
 *  String representation, unsuitable for description
 *
 *  @return string
 */
-(NSString *)stringRepresentation;
@end