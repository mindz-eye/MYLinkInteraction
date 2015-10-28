//
//  MYLinkInteractionHandler.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYLinkInteractionHandler.h"
#import "MYLinkInteractionCommands.h"
#import "MYDefaultActionsFactory.h"
#import "MYLinkInteractionAction.h"
#import "UIAlertController+MYLinkInteraction.h"
#import "UIViewController+MYHelpers.h"

@implementation MYLinkInteractionHandler

- (void)handleLinkInteractionType:(MYLinkInteractionType)type
                         linkText:(NSString *)linkText
               textCheckingResult:(NSTextCheckingResult *)result
                   popoverContext:(nullable MYPopoverPresentationContext *)popoverContext {
    
    if (type == MYLinkInteractionTypePress) {
        [self handlePressWithTextCheckingResult:result linkText:linkText popoverContext:popoverContext];
    } else if (type == MYLinkInteractionTypeLongPress) {
        [self handleLongPressWithTextCheckingResult:result linkText:linkText popoverContext:popoverContext];
    } else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"Unsupported interaction type" userInfo:nil];
    }
}

- (void)handlePressWithTextCheckingResult:(NSTextCheckingResult *)result linkText:(NSString *)linkText
                           popoverContext:(nullable MYPopoverPresentationContext *)popoverContext {
    
    switch (result.resultType) {
        case NSTextCheckingTypeLink:
            [MYLinkInteractionCommands openURL:result.URL];
            break;
            
        case NSTextCheckingTypeAddress:
            [MYLinkInteractionCommands openInMapsWithAddressComponents:result.addressComponents];
            break;
            
        case NSTextCheckingTypePhoneNumber:
            [MYLinkInteractionCommands callWithPhoneNumber:result.phoneNumber];
            break;
            
        case NSTextCheckingTypeDate: {
            NSArray<MYLinkInteractionAction *> *actions = [self populateActionsForTextCheckingResult:result linkText:linkText];
            UIAlertController *alert = [UIAlertController my_alertControllerForLinkInteractionActions:actions];
            [self presentAlertController:alert popoverContext:popoverContext];
            break;
        }
        default:
            break;
    }
}

- (void)handleLongPressWithTextCheckingResult:(NSTextCheckingResult *)result linkText:(NSString *)linkText
                               popoverContext:(nullable MYPopoverPresentationContext *)popoverContext {
    
    NSArray<MYLinkInteractionAction *> *actions = [self populateActionsForTextCheckingResult:result linkText:linkText];
    UIAlertController *alert = [UIAlertController my_alertControllerForLinkInteractionActions:actions];
    [self presentAlertController:alert popoverContext:popoverContext];
}

- (void)presentAlertController:(UIAlertController *)alert popoverContext:(nullable MYPopoverPresentationContext *)popoverContext {
    alert.popoverPresentationController.sourceView = popoverContext.sourceView;
    alert.popoverPresentationController.sourceRect = popoverContext.sourceRect;
    
    UIViewController *presenter = [UIViewController my_topViewController];
    if (presenter) {
        [presenter presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Actions

- (NSArray<MYLinkInteractionAction *> *)actionsForURL:(NSURL *)URL {
    NSMutableArray *actions = [NSMutableArray array];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];
    if ([urlComponents.scheme isEqualToString:@"mailto"]) {
        MYLinkInteractionAction *sendMail = [MYDefaultActionsFactory mailMessageActionWithEmail:urlComponents.path];
        MYLinkInteractionAction *addContact = [MYDefaultActionsFactory addContactActionWithEmail:urlComponents.path];
        [actions addObjectsFromArray:@[sendMail, addContact]];
    } else {
        MYLinkInteractionAction *open = [MYDefaultActionsFactory openURLActionWithURL:URL];
        MYLinkInteractionAction *addToReadingList = [MYDefaultActionsFactory addToReadingListActionWithURL:URL];
        [actions addObjectsFromArray:addToReadingList ? @[open, addToReadingList] : @[open]];
    }
    MYLinkInteractionAction *copy = [MYDefaultActionsFactory copyActionWithURL:URL];
    [actions addObject:copy];
    
    return [actions copy];
}

- (NSArray<MYLinkInteractionAction *> *)actionsForAddressComponents:(NSDictionary *)addressComponents {
    MYLinkInteractionAction *open = [MYDefaultActionsFactory openInMapsActionWithAddressComponents:addressComponents];
    MYLinkInteractionAction *addContact = [MYDefaultActionsFactory addContactActionWithAddressComponents:addressComponents];
    MYLinkInteractionAction *copy = [MYDefaultActionsFactory copyActionWithText:[addressComponents.allValues componentsJoinedByString:@" "]];
    
    return @[open, addContact, copy];
}

- (NSArray<MYLinkInteractionAction *> *)actionsForPhoneNumber:(NSString *)phoneNumber {
    NSMutableArray *actions = [NSMutableArray array];
    
    MYLinkInteractionAction *call = [MYDefaultActionsFactory callActionWithPhoneNumber:phoneNumber];
    if (call) {
        [actions addObject:call];
    }
    MYLinkInteractionAction *faceTime = [MYDefaultActionsFactory faceTimeAudioActionWithPhoneNumber:phoneNumber];
    MYLinkInteractionAction *message = [MYDefaultActionsFactory textMessageActionWithPhoneNumber:phoneNumber];
    MYLinkInteractionAction *addContact = [MYDefaultActionsFactory addContactActionWithPhoneNumber:phoneNumber];
    MYLinkInteractionAction *copy = [MYDefaultActionsFactory copyActionWithText:phoneNumber];
    
    [actions addObjectsFromArray:@[faceTime, message, addContact, copy]];
    return [actions copy]; 
}

- (NSArray<MYLinkInteractionAction *> *)actionsForDate:(NSDate *)date dateString:(NSString *)dateString {
    MYLinkInteractionAction *eventAction = [MYDefaultActionsFactory createEventActionWithDate:date];
    MYLinkInteractionAction *showDateAction = [MYDefaultActionsFactory showDateActionWithDate:date];
    MYLinkInteractionAction *copyAction = [MYDefaultActionsFactory copyActionWithText:dateString];
    
    return @[eventAction, showDateAction, copyAction];
}


- (NSArray<MYLinkInteractionAction *> *)populateActionsForTextCheckingResult:(NSTextCheckingResult *)result linkText:(NSString *)linkText {
    NSArray<MYLinkInteractionAction *> *actions;
    
    switch (result.resultType) {
        case NSTextCheckingTypeLink:
            actions = [self actionsForURL:result.URL];
            break;
            
        case NSTextCheckingTypeAddress:
            actions = [self actionsForAddressComponents:result.addressComponents];
            break;
            
        case NSTextCheckingTypePhoneNumber:
            actions = [self actionsForPhoneNumber:result.phoneNumber];
            break;
            
        case NSTextCheckingTypeDate:
            actions = [self actionsForDate:result.date dateString:linkText];
            break;
            
        default:
            actions = @[];
    }
    
    if ([self.delegate respondsToSelector:@selector(linkInteractionHandler:actionsFroProposedActions:)]) {
        actions = [self.delegate linkInteractionHandler:self actionsFroProposedActions:actions];
    }
    return actions;
}

@end


@implementation MYPopoverPresentationContext
@end