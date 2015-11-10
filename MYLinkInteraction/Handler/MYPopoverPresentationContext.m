//
//  MYPopoverPresentationContext.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 10/11/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYPopoverPresentationContext.h"

@implementation MYPopoverPresentationContext

- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect {
    self = [super init];
    if (self) {
        _sourceView = sourceView;
        _sourceRect = sourceRect;
    }
    return self;
}

@end
