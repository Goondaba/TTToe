//
//  ViewController.h
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTBoardView.h"

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;

//squares
@property (nonatomic, weak) IBOutlet TTTBoardView *zeroZero;
@property (nonatomic, weak) IBOutlet TTTBoardView *oneZero;
@property (nonatomic, weak) IBOutlet TTTBoardView *twoZero;

@property (nonatomic, weak) IBOutlet TTTBoardView *zeroOne;
@property (nonatomic, weak) IBOutlet TTTBoardView *oneOne;
@property (nonatomic, weak) IBOutlet TTTBoardView *twoOne;

@property (nonatomic, weak) IBOutlet TTTBoardView *zeroTwo;
@property (nonatomic, weak) IBOutlet TTTBoardView *oneTwo;
@property (nonatomic, weak) IBOutlet TTTBoardView *twoTwo;

@end

