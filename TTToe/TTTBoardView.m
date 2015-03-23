//
//  TTTBoardView.m
//  TTToe
//
//  Created by Jonathan Salvador on 3/22/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "TTTBoardView.h"

@implementation TTTBoardView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        self.boardLocation = [[TTTBoardLocation alloc] init];
        
        self.squareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        self.squareLabel.text = @"F";
        
        [self.squareLabel setTextColor:[UIColor blackColor]];
        [self.squareLabel setBackgroundColor:[UIColor clearColor]];
        [self.squareLabel setFont:[UIFont systemFontOfSize:36.0f]];
        [self.squareLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.squareLabel];
        
    }
    return self;
}

@end
