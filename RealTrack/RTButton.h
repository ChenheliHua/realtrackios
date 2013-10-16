//
//  RTButton.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/16/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTButton : UIButton

// Set the corder radius
-(void)setCornerRadius:(int) radius;

// Set the button text
-(void)setButtonTitle:(NSString*) newText;

@end
