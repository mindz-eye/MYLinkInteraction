//
//  MYLinkInteractionAction.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 06/10/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYLinkInteractionAction.h"

@implementation MYLinkInteractionAction

- (instancetype)initWithTitle:(NSString *)title handler:(void(^)())handler {
    self = [super init];
    if (self) {
        _title = title;
        _actionHandler = handler;
    }
    return self;
}

+ (MYLinkInteractionAction *)actionWithTitle:(NSString *)title handler:(void(^)())handler {
    return [[MYLinkInteractionAction alloc] initWithTitle:title handler:handler];
}

@end
