//
//  ViewController.m
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "ViewController.h"
#import "TTTBoard.h"
#import "TTTHardSolver.h"

@interface ViewController ()
@property (nonatomic) NSArray *squareViews;
@property (nonatomic) TTTBoardChoice userPlayingAs;
@property (nonatomic) TTTBoardChoice compyPlayingAs;
@property (nonatomic) id hardSolver;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.squareViews = @[@[self.zeroZero, self.zeroOne, self.zeroTwo],
                         @[self.oneZero, self.oneOne, self.oneTwo],
                         @[self.twoZero, self.twoOne, self.twoTwo]];
    
    //assign the square views their coordinates
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            TTTBoardLocation *newLocation = [self.squareViews[i][j] boardLocation];
            newLocation.x = i;
            newLocation.y = j;
        }
    }
    
    self.userPlayingAs  = kTTTBoardChoiceX;
    self.compyPlayingAs = kTTTBoardChoiceO;
    
    //add touch event for squares
    for (NSArray *arr in self.squareViews) {
        for (TTTBoardView *squareView in arr) {
            [squareView addTarget:self action:@selector(squareTouched:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    //setup solver
    self.hardSolver = [[TTTHardSolver alloc] init];
    ([TTTBoard gameBoard]).solverDelegate = self.hardSolver;
    
    self.messageLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Game actions

- (IBAction)resetGame:(id)sender {
    
    //clear logical board
    [[TTTBoard gameBoard] clearBoard];
    
    //clear visual board
    for (NSArray *arr in self.squareViews) {
        for (TTTBoardView *squareView in arr) {
            squareView.squareLabel.text = @"";
        }
    }
    
    self.messageLabel.text = @"";
}

- (void)squareTouched:(id)sender {
    if ([[TTTBoard gameBoard]  gameOver]){
        return;
    }
    
    TTTBoardView *squareView = (TTTBoardView *)sender;
    
    NSLog(@"Tapped: %d,%d", squareView.boardLocation.x, squareView.boardLocation.y);
    
    BOOL moveWasMade = [self makeMoveOnSquare:sender forPlayer:self.userPlayingAs];
    if (moveWasMade) {
        
        //computer move
        TTTBoardLocation *compyMove = [[TTTBoard gameBoard] moveAsPlayer:self.compyPlayingAs];
        if (compyMove) {
            [self makeMoveOnSquare:self.squareViews[compyMove.x][compyMove.y] forPlayer:self.compyPlayingAs];
        }
    }
}

- (BOOL)makeMoveOnSquare:(TTTBoardView *)givenSquare forPlayer:(TTTBoardChoice)givenPlayer {
    
    BOOL moveWasMade = [[TTTBoard gameBoard] markLocationX:givenSquare.boardLocation.x andY:givenSquare.boardLocation.y withChoice:givenPlayer];
    if (moveWasMade) {
        givenSquare.squareLabel.text = (givenPlayer == kTTTBoardChoiceO)?@"O":@"X";
    }
    
    if ([[TTTBoard gameBoard]  gameOver]){
        self.messageLabel.text = [self gameOverText];
    }
    
    return moveWasMade;
}

- (NSString *)gameOverText {
    NSMutableString *overString = [NSMutableString string];
    [overString appendString:@"Game Over - "];
    
    if ([[TTTBoard gameBoard] gameWinner] >= 0){
        [overString appendFormat:@"Winner: %@", ([[TTTBoard gameBoard] gameWinner] == kTTTBoardChoiceO)?@"O":@"X"];
    }
    else {
        [overString appendString:@"Draw"];
    }
    
    return overString;
}

@end
