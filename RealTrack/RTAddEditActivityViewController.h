//
//  RTAddEditActivityViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/24/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTButton.h"

@interface RTAddEditActivityViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *projectName;
@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (strong, nonatomic) IBOutlet RTButton *addEditActivity;

@end
