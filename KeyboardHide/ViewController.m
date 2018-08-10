//
//  ViewController.m
//  KeyboardHide
//
//  Created by steve on 2018-08-10.
//  Copyright © 2018 steve. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()<UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet MyView *myView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (nonatomic) CGFloat oldConstant;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  CGRect rect = CGRectMake(20, 20, 200, 200);
  MyView *mv = [[MyView alloc] initWithFrame:rect];
  [self.view addSubview:mv];
  mv.backgroundColor = [UIColor orangeColor];
  [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
  self.oldConstant = self.bottomConstraint.constant;
}

- (void)keyboardWillShow:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  NSValue *value = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
  CGRect rect = value.CGRectValue;
  NSLog(@"%@", NSStringFromCGRect(rect));
  CGFloat height = rect.size.height;
  // Setting the bounds height way of moving the textField
//  CGRect newBounds = CGRectMake(0, height, self.view.bounds.size.width, self.view.bounds.size.height);
//  self.view.bounds = newBounds;
  
  // Setting the constraint oldConstant
  self.bottomConstraint.constant = self.oldConstant + height;
}

- (void)dealloc {
  [NSNotificationCenter.defaultCenter removeObserver:self];
}

// implement the return key delete

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  // Bounds way of setting textField back once the keyboard goes away
//  CGRect newBounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//  self.view.bounds = newBounds;
  
  self.bottomConstraint.constant = self.oldConstant;
  return YES;
}




@end
