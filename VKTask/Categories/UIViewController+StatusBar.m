//
//  UIViewController+StatusBar.m
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "UIViewController+StatusBar.h"
#import <objc/runtime.h>


static void statusBar_swizzleInstanceMethod(Class c, SEL original, SEL replacement) {
    
    Method a = class_getInstanceMethod(c, original);
    Method b = class_getInstanceMethod(c, replacement);
    if (class_addMethod(c, original, method_getImplementation(b), method_getTypeEncoding(b))) {
        
        class_replaceMethod(c, replacement, method_getImplementation(a), method_getTypeEncoding(a));
        
    } else {
        method_exchangeImplementations(a, b);
    }
}

@implementation UIViewController (StatusBar)


#pragma mark - Swizzle

+ (void)load {
    statusBar_swizzleInstanceMethod(self, @selector(prefersStatusBarHidden), @selector(prefersStatusBarHidden_swizzle));
}

- (BOOL)prefersStatusBarHidden_swizzle {
    [self prefersStatusBarHidden_swizzle];
    return [self hideStatusBar];
}

- (BOOL)hideStatusBar {
    return NO;
}

@end
