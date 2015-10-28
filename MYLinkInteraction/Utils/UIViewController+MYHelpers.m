//
//  UIViewController+MYHelpers.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "UIViewController+MYHelpers.h"

@implementation UIViewController (MYHelpers)

+ (nullable UIViewController *)my_topViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window) {
        UIViewController *vc = window.rootViewController;
        while (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
        return vc;
    }
    return nil;
}

@end
