//
//  XLPriceTextField.m
//  XLPriceTextField
//
//  Created by Loong on 14/12/25.
//  Copyright (c) 2014年 YummyAustralia. All rights reserved.
//

#import "XLPriceTextField.h"

@interface XLPriceTextField () <UITextFieldDelegate>{
    BOOL _isWrite;
    UIView *_keyboardView;
}

@end

@implementation XLPriceTextField

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _isWrite = NO;
        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(keyboardDidDisappear:)
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
        
//        [self hackViewForKeyboard];
    }
    return  self;
}

- (void)keyboardDidDisappear:(NSNotification *)notification {
    
    [self hackViewForKeyboard];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        _isWrite = NO;
    }else{
        _isWrite = YES;
    }

    if (self.text.length >= 5 && ![string isEqualToString:@""]) {
        return NO;
    }

    return YES;
}

- (void)textFieldDidChange:(NSNotification *)notification {
    
    if (self.text.length == 2 && _isWrite) {
        
        self.text = [NSString stringWithFormat:@"%@.",self.text];

    }
    
    if (self.text.length == 2 && !_isWrite) {
        self.text = [self.text substringWithRange:NSMakeRange(0, 1)];

    }
    
    NSRange textRange = [self.text rangeOfString:@"."];
    if (textRange.location !=  NSNotFound ) {
        NSMutableAttributedString *attributedName = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attributedName addAttribute:NSForegroundColorAttributeName
                               value:[UIColor grayColor]
                               range:textRange];
        self.attributedText = attributedName;
    }
    [self hackViewForKeyboard];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}

- (void)hackViewForKeyboard
{
    _keyboardView = [self findKeyboardView];
    UIButton *hackButton;
    
    if(_keyboardView &&[self isFirstResponder]) {
        
        [[_keyboardView viewWithTag:1001] removeFromSuperview];
        
        hackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        hackButton.tag = 1000;
        hackButton.frame = CGRectMake(3.0, 174.0, 75.0, 41.0);
        
        hackButton.backgroundColor = [UIColor darkGrayColor];
        [hackButton setTitle:@".?123" forState:UIControlStateNormal];
        [hackButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_keyboardView addSubview:hackButton];
        
    }
    
    if (_keyboardView &&[self isFirstResponder]) {
        
        [[_keyboardView viewWithTag:1000] removeFromSuperview];
        
        hackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        hackButton.tag = 1001;
        hackButton.frame = CGRectMake(0.0, 163.0, 106.0, 53.0);
        [hackButton setTitle:@"Return" forState:UIControlStateNormal];
        [hackButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [hackButton addTarget:self action:@selector(writeIn) forControlEvents:UIControlEventTouchUpInside];
        [_keyboardView addSubview:hackButton];
    }
    
}

- (void)writeIn{
    
}

- (UIView*)findKeyboardView
{
    NSArray* windowList                                                     = [[UIApplication sharedApplication] windows];
    for(UIWindow* theWindow in [windowList reverseObjectEnumerator])
    {
        for(UIView* theView in [theWindow subviews])
        {
            if(!strcmp(object_getClassName(theView), "UIPeripheralHostView") || !strcmp(object_getClassName(theView), "UIKeyboard"))
            {
                return theView;
            }
        }
    }
    
    return nil;
}

@end
