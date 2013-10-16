//
//  RTButton.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/16/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTButton.h"

@implementation RTButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setCornerRadius:(int)radius
{
    self.layer.cornerRadius = radius;
}

-(void)setButtonTitle:(NSString *)newText
{
    [self setTitle:newText forState:UIControlStateNormal];
}

@end
