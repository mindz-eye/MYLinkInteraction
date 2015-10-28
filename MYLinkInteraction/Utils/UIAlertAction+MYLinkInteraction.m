//
//  UIAlertAction+MYLinkInteraction.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "UIAlertAction+MYLinkInteraction.h"
#import "MYLinkInteractionAction.h"

@implementation UIAlertAction (MYLinkInteraction)

+ (UIAlertAction *)my_alertActionWithLinkInteractionAction:(MYLinkInteractionAction *)action {
    return [UIAlertAction actionWithTitle:action.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull alertAction) {
        if (action.actionHandler) {
            action.actionHandler();
        }
    }];
}

@end
