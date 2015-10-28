//
//  UIBarButtonItem+MYBlocksSupport.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "UIBarButtonItem+MYBlocksSupport.h"
#import <objc/runtime.h>

static const char kBlockActionKey;

@implementation UIBarButtonItem (MYBlocksSupport)

+ (instancetype)my_barButtonForSystemItem:(UIBarButtonSystemItem)systemItem action:(void (^)(id sender))action {
    UIBarButtonItem *button = [[self alloc] initWithBarButtonSystemItem:systemItem target:nil action:@selector(my_handleAction:)];
    button.target = button;
    objc_setAssociatedObject(button, &kBlockActionKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return button;
}

- (void)my_handleAction:(UIBarButtonItem *)sender {
    void (^action)(id) = objc_getAssociatedObject(self, &kBlockActionKey);
    if (action) {
        action(self);
    }
}

@end
