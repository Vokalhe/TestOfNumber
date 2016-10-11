//
//  ViewController.h
//  TestOfSoftheme
//
//  Created by Admin on 09.10.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentDegreeOfNumberControl;
@property (weak, nonatomic) IBOutlet UITextView *componentsOfNumberTextView;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *sumPickerView;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) NSInteger sum;


- (IBAction)valueChangedSegmentOfNumber:(UISegmentedControl *)sender;


@end

