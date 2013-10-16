//
//  RTLogo.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/16/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLogo : UIView

@property(strong,nonatomic)UIImageView *logo;

// Load Peace Corps logo on launch
-(void)loadLogo;

@end
