//
//  MYLinkData.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 10/11/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYLinkData.h"

@implementation MYLinkData

- (instancetype)initWithLinkText:(NSString *)linkText textCheckingResult:(NSTextCheckingResult *)result {
    self = [super init];
    if (self) {
        _linkText = linkText;
        _checkingResult = result;
    }
    return self;
}

@end
