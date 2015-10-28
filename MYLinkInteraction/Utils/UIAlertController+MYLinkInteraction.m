//
//  UIAlertController+LinkInteraction.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 20/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "UIAlertController+MYLinkInteraction.h"
#import "UIAlertAction+MYLinkInteraction.h"

@implementation UIAlertController (MYLinkInteraction)

+ (UIAlertController *)my_alertControllerWithAlertActions:(nonnull NSArray<UIAlertAction *> *)actions {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction *action in actions) {
        [alert addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    return alert;
}

+ (UIAlertController *)my_alertControllerForLinkInteractionActions:(NSArray<MYLinkInteractionAction *> *)actions {
    NSMutableArray<UIAlertAction *> *alertActions = [NSMutableArray array];
    
    for (MYLinkInteractionAction *action in actions) {
        [alertActions addObject:[UIAlertAction my_alertActionWithLinkInteractionAction:action]];
    }
    return [self my_alertControllerWithAlertActions:alertActions];
}

@end
