//
//  TTTBoardView.h
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTBoard.h"

@interface TTTBoardView : UIControl
@property (nonatomic) TTTBoardLocation *boardLocation;
@property (nonatomic) UILabel *squareLabel;
@end
