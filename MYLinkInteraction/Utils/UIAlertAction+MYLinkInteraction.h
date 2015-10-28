//
//  UIAlertAction+MYLinkInteraction.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYLinkInteractionAction;

@interface UIAlertAction (MYLinkInteraction)

+ (UIAlertAction *)my_alertActionWithLinkInteractionAction:(MYLinkInteractionAction *)action;

@end

NS_ASSUME_NONNULL_END