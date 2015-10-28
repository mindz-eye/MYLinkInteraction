//
//  MYDefaultActionsFactory.m
//  MYLinkInteraction
//
//  Released under an MIT license: http://opensource.org/licenses/MIT
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYDefaultActionsFactory.h"
#import "MYLinkInteractionAction.h"
#import "MYLinkInteractionCommands.h"
#import <SafariServices/SafariServices.h>

@implementation MYDefaultActionsFactory

+ (MYLinkInteractionAction *)openURLActionWithURL:(NSURL *)URL {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Open Link", nil) handler:^{
        [MYLinkInteractionCommands openURL:URL];
    }];
}

+ (MYLinkInteractionAction *)addToReadingListActionWithURL:(NSURL *)URL {
    if ([SSReadingList supportsURL:URL]) {
        return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Add to Reading List", nil) handler:^{
            [MYLinkInteractionCommands addURLToReadingList:URL];
        }];
    }
    return nil;
}

+ (MYLinkInteractionAction *)copyActionWithURL:(NSURL *)URL {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Copy", nil) handler:^{
        [MYLinkInteractionCommands copyURL:URL];
    }];
}

+ (MYLinkInteractionAction *)openInMapsActionWithAddressComponents:(NSDictionary *)addressComponents {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Open in Maps", nil) handler:^{
        [MYLinkInteractionCommands openInMapsWithAddressComponents:addressComponents];
    }];
}

+ (MYLinkInteractionAction *)addContactActionWithAddressComponents:(NSDictionary *)addressComponents {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Add to Contacts", nil) handler:^{
        [MYLinkInteractionCommands addContactWithAddressComponents:addressComponents];
    }];
}

+ (MYLinkInteractionAction *)mailMessageActionWithEmail:(NSString *)email {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"New Message", nil) handler:^{
        [MYLinkInteractionCommands mailMessageWithEmail:email];
    }];
}

+ (MYLinkInteractionAction *)addContactActionWithEmail:(NSString *)email {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Add to Contacts", nil) handler:^{
        [MYLinkInteractionCommands addContactWithEmail:email];
    }];
}

+ (MYLinkInteractionAction *)copyActionWithText:(NSString *)text {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Copy", nil) handler:^{
        [MYLinkInteractionCommands copyText:text];
    }];
}

+ (nullable MYLinkInteractionAction *)callActionWithPhoneNumber:(NSString *)phoneNumber {
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]) {
        return [MYLinkInteractionAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Call %@", nil), phoneNumber] handler:^{
            [MYLinkInteractionCommands callWithPhoneNumber:phoneNumber];
        }];
    }
    return nil;
}

+ (MYLinkInteractionAction *)faceTimeAudioActionWithPhoneNumber:(NSString *)phoneNumber {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"FaceTime Audio", nil) handler:^{
        [MYLinkInteractionCommands faceTimeAudioWithNumber:phoneNumber];
    }];
}

+ (MYLinkInteractionAction *)textMessageActionWithPhoneNumber:(NSString *)phoneNumber {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Send Message", nil) handler:^{
        [MYLinkInteractionCommands textMessageWithPhoneNumber:phoneNumber];
    }];
}

+ (MYLinkInteractionAction *)addContactActionWithPhoneNumber:(NSString *)phoneNumber {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Add to Contacts", nil) handler:^{
        [MYLinkInteractionCommands addContactWithPhoneNumber:phoneNumber];
    }];
}

+ (MYLinkInteractionAction *)createEventActionWithDate:(NSDate *)date {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Create Event", nil) handler:^{
        [MYLinkInteractionCommands createEventWithDate:date];
    }];
}

+ (MYLinkInteractionAction *)showDateActionWithDate:(NSDate *)date {
    return [MYLinkInteractionAction actionWithTitle:NSLocalizedString(@"Show in Calendar", nil) handler:^{
        [MYLinkInteractionCommands showDateInCalendar:date];
    }];
}

@end
