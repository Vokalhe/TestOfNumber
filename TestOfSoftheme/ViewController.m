//
//  ViewController.m
//  TestOfSoftheme
//
//  Created by Admin on 09.10.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "ViewController.h"
typedef enum {
    degreeOfNumberZero = 0,
    degreeOfNumberFirst = 1,
    degreeOfNumberSecond = 2,
    degreeOfNumberThird = 3,
    degreeOfNumberFourth = 4,
    degreeOfNumberFifth = 5,
    degreeOfNumberSixth = 6,
    degreeOfNumberSeventh = 7,
    degreeOfNumberEighth = 8,
    degreeOfNumberNinth = 9
}degreeOfNumber;

@interface ViewController () <UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *arrayValidNum;
@property (assign, nonatomic) NSInteger index;
//@property (strong, nonatomic) drawingsView *viewD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sumPickerView.delegate = self;
    [self showAlert];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChangedSegmentOfNumber:(UISegmentedControl *)sender {
    switch (self.segmentDegreeOfNumberControl.selectedSegmentIndex) {
        case (degreeOfNumberZero):
            [self calculateWithDegree:degreeOfNumberZero];
            break;
            
        case (degreeOfNumberFirst):
            [self calculateWithDegree:degreeOfNumberFirst];
            break;
            
        case (degreeOfNumberSecond):
            [self calculateWithDegree:degreeOfNumberSecond];
            break;
            
        case (degreeOfNumberThird):
            [self calculateWithDegree:degreeOfNumberThird];
            break;
            
        case (degreeOfNumberFourth):
            [self calculateWithDegree:degreeOfNumberFourth];
            break;
            
        case (degreeOfNumberFifth):
            [self calculateWithDegree:degreeOfNumberFifth];
            break;
            
        case (degreeOfNumberSixth):
            [self calculateWithDegree:degreeOfNumberSixth];
            break;
            
        case (degreeOfNumberSeventh):
            [self calculateWithDegree:degreeOfNumberSeventh];
            break;
            
        case (degreeOfNumberEighth):
            [self calculateWithDegree:degreeOfNumberEighth];
            break;
            
        case (degreeOfNumberNinth):
            [self calculateWithDegree:degreeOfNumberNinth];
            break;
    }
}
#pragma mark - Private Method
-(void) calculateWithDegree:(degreeOfNumber) degree{
    self.secondLabel.text = @"Time calculating: ...";

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [UIView animateWithDuration:4 animations:^{
            self.sumPickerView.backgroundColor = [self randomColor];
        }];
        NSDate *start = [NSDate date];
        [self.segmentDegreeOfNumberControl setEnabled:NO];
        NSString *allStr = [NSString stringWithFormat:@"Degree of Number = %d\n", degree];
        
        self.arrayValidNum = [[NSArray alloc]init];
        NSInteger maxNum = 1;
        
        for (NSInteger i = 0; i < degree; i++) {
            maxNum *= 10;
        }
        
        for (NSInteger num = 10; num < maxNum; num++) {
            self.array = [[NSArray alloc]init];
            NSLog(@"%d", num);
            
            NSString *numString = [NSString stringWithFormat:@"%d", num];
            for (NSInteger index = 0; index < numString.length; index++) {//разбирает число
                NSString *newString = [numString substringWithRange:NSMakeRange(index, 1)];
                self.array = [self.array arrayByAddingObject:newString];
            }
            
            NSInteger forChecks = 0;
            
            for (NSString *str in self.array) {//узнает его сумму
                NSInteger newNum = [str integerValue];
                NSInteger numInDegrees = 1;
                
                for (NSInteger i = 0; i < degree; i++) {
                    numInDegrees *= newNum;
                }
                forChecks += numInDegrees;
            }
            
            if (forChecks == num) {//проверка суммы и если да, то запись в массив
                self.arrayValidNum = [self.arrayValidNum arrayByAddingObject:[NSNumber numberWithInteger:forChecks]];
            }
        }
        self.sum = 0;
        if ([self.arrayValidNum count] == 0) {
            allStr = [allStr stringByAppendingString:@"It does not suitable value"];
            self.sum = 0;
        }
        for (NSNumber *num in self.arrayValidNum) {//вывод
            NSString *str = [NSString stringWithFormat:@"Number №%u - %@\n", [self.arrayValidNum indexOfObject:num]+1, num];
            allStr = [allStr stringByAppendingString:str];
            self.sum += [num integerValue];
        }
        NSString *sumString = [NSString stringWithFormat:@"%d", self.sum];
        self.index = sumString.length - 1;
        NSLog(@"%d", self.sum);
        [self.segmentDegreeOfNumberControl setEnabled:YES];
        [self.componentsOfNumberTextView setText:allStr];
        NSDate *end = [NSDate date];
        NSTimeInterval time = [end timeIntervalSinceDate:start];
        self.secondLabel.text = [NSString stringWithFormat:@"Time calculating: %.2f sec.", time];
        self.sumPickerView.dataSource = self;
    });
}

-(void) showAlert{
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!!!" message:@"Select the degree of number.\n For comfortable work application works in:\n Landscape(Left/right) and Device iPhone."
                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Default", nil] ;
    [alert show];
}

-(UIColor*) randomColor{
    CGFloat red = arc4random() % 256;
    CGFloat green = arc4random() % 256;
    CGFloat blue = arc4random() % 256;
    
    UIColor *color = [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
    return color;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSString *string = [NSString stringWithFormat:@"%lu", self.sum];
    return string.length;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 1;
}
#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
        NSInteger index = component;
        NSString *sumString = [NSString stringWithFormat:@"%ld", self.sum];
        NSString *newString = [sumString substringWithRange:NSMakeRange(index, 1)];
        index++;
        return newString;
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    if (buttonIndex == 1) {
        self.segmentDegreeOfNumberControl.selectedSegmentIndex = degreeOfNumberFifth;
        dispatch_async(backgroundQueue, ^{
            [self calculateWithDegree:degreeOfNumberFifth];
        });
    }
}
@end
