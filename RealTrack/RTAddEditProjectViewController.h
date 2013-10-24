//
//  RTAddEditProjectViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/24/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTButton.h"
#import "Projects.h"

@interface RTAddEditProjectViewController : UIViewController

@property (strong, nonatomic) IBOutlet RTButton *button;
@property (strong, nonatomic) IBOutlet UITextField *projectName;


-(BOOL)textFieldShouldReturn:(UITextField*)textField;

- (IBAction)addEditProject:(RTButton *)sender;

@end
