//
//  ViewController.m
//  Scroll View Test
//
//  Created by BS-23 on 8/9/17.
//  Copyright © 2017 BS-23. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic, assign) CGFloat viewMoveUpOffsetForKeyboard; //for keeping track of the keyboard's view push height
@property(nonatomic, assign) IBOutlet UITextField *txtReason;
@property(nonatomic, assign) IBOutlet UITextField *txtMiddle;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    

    
    //self.scrollView.contentSize =CGSizeMake(375, 900);

}
- (void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       CGRect contentRect = CGRectZero;
                       for (UIView *view in self.scrollView.subviews)
                           contentRect = CGRectUnion(contentRect, view.frame);
                       
                       //contentRect.size.height = contentRect.size.height;
                       self.scrollView.contentSize = contentRect.size;
                   });
}

#pragma mark - UITextFieldDelegate

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height +10;
    self.scrollView.contentInset = contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
