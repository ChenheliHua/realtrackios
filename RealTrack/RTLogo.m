//
//  RTLogo.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/16/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTLogo.h"

@implementation RTLogo

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

-(void)loadLogo
{
    self.logo=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,160,160)];
    [self addSubview:self.logo];
    
    self.logo.image = [UIImage imageNamed:@"logobig.png"];
}

@end
