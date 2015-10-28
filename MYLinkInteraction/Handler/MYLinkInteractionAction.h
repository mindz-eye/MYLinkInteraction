//
//  MYLinkInteractionAction.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 06/10/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYLinkInteractionAction : NSObject

@property (copy, readonly, nonatomic) NSString *title;
@property (copy, readonly, nonatomic) void(^actionHandler)();

+ (MYLinkInteractionAction *)actionWithTitle:(NSString *)title handler:(void(^)())handler;

@end

NS_ASSUME_NONNULL_END