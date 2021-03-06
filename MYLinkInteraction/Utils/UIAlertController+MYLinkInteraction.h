//
//  UIAlertController+MYLinkInteraction.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 20/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYLinkInteractionAction;

@interface UIAlertController (MYLinkInteraction)

+ (UIAlertController *)my_alertControllerForLinkInteractionActions:(NSArray<MYLinkInteractionAction *> *)actions;

@end

NS_ASSUME_NONNULL_END
