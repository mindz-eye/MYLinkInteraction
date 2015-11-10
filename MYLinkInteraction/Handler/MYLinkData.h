//
//  MYLinkData.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 10/11/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYLinkData : NSObject

@property (copy, readonly, nonatomic) NSString *linkText;
@property (strong, readonly, nonatomic) NSTextCheckingResult *checkingResult;

- (instancetype)initWithLinkText:(NSString *)linkText textCheckingResult:(NSTextCheckingResult *)result;

@end

NS_ASSUME_NONNULL_END
