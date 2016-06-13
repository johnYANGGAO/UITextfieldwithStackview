//
//  ViewController.m
//  teststackview
//
//  Created by john's mac　　　　 on 6/13/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)switchbutton:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UIStackView *namelayout;
@property (weak, nonatomic) IBOutlet UIStackView *layoutmastor;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;

@end

@implementation ViewController
Boolean keyboardIsShown;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)switchbutton:(UISwitch *)sender {
    UIView * firstView = self.layoutmastor.arrangedSubviews[1];
   
    if([sender isOn]){
        [UIView animateWithDuration:0.3 animations:^{
           firstView.hidden = YES;
        }];
        
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            firstView.hidden = NO;
        }];

    
    }
    
}

UITextField *activeField;
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField=textField;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
   activeField = nil;
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.myscrollview.contentInset = contentInsets;
    self.myscrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.myscrollview scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myscrollview.contentInset = contentInsets;
    self.myscrollview.scrollIndicatorInsets = contentInsets;
}

@end
