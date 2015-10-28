
//  MYLinkInteractionCommands.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYLinkInteractionCommands.h"
#import "MYAddressBookHelpers.h"
#import "UIViewController+MYHelpers.h"
#import "UIBarButtonItem+MYBlocksSupport.h"
#import <SafariServices/SafariServices.h>
#import <MessageUI/MessageUI.h>
#import <EventKitUI/EventKitUI.h>
#import <objc/runtime.h>

@interface MYDismissingDelegate : NSObject <MFMailComposeViewControllerDelegate, EKEventEditViewDelegate>
@end

@implementation MYDismissingDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end


@implementation MYLinkInteractionCommands

#pragma mark - Commands

+ (void)openURL:(NSURL *)URL {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];
    if ([urlComponents.scheme isEqualToString:@"mailto"]) {
        [self mailMessageWithEmail:urlComponents.path];
    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
}

+ (void)addURLToReadingList:(NSURL *)URL {
    if ([SSReadingList supportsURL:URL]) {
        SSReadingList *readingList = [SSReadingList defaultReadingList];
        NSError *error;
        [readingList addReadingListItemWithURL:URL title:nil previewText:nil
                                         error:&error];
        if (error) {
            NSLog(@"Failed to add URL to Reading List: %@", error);
        }
    }
}

+ (void)copyURL:(NSURL *)URL {
    [UIPasteboard generalPasteboard].URL = URL;
}

+ (void)openInMapsWithAddressComponents:(NSDictionary *)addressComponents {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:@"http://maps.apple.com/"];
    urlComponents.query = [NSString stringWithFormat:@"q=%@",
                           [addressComponents.allValues componentsJoinedByString:@" "]];
    [[UIApplication sharedApplication] openURL:urlComponents.URL];    
}

+ (void)addContactWithAddressComponents:(NSDictionary *)addressComponents {
    UIViewController *contactsController = [MYAddressBookHelpers contactsViewControllerWithAddressComponents:addressComponents];
    [self presentViewController:contactsController];
}

+ (void)addContactWithEmail:(NSString *)email {
    UIViewController *contactsController = [MYAddressBookHelpers contactsViewControllerWithEmail:email];
    [self presentViewController:contactsController];
}

+ (void)mailMessageWithEmail:(NSString *)email {
    UIViewController *presenter = [UIViewController my_topViewController];
    if (!presenter) {
        NSLog(@"Failed to find a presenter view controller");
        return;
    }
    MFMailComposeViewController *mailController = [MFMailComposeViewController new];
    MYDismissingDelegate *delegate = [MYDismissingDelegate new];
    mailController.mailComposeDelegate = delegate;
    objc_setAssociatedObject(mailController, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [mailController setToRecipients:@[email]];
    
    [presenter presentViewController:mailController animated:YES completion:nil];
}

+ (void)callWithPhoneNumber:(NSString *)phoneNumber {
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"tel";
    components.host = phoneNumber;
    [[UIApplication sharedApplication] openURL:[components URL]];
}

+ (void)faceTimeAudioWithNumber:(NSString *)phoneNumber {
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"facetime-audio";
    components.host = phoneNumber;
    [[UIApplication sharedApplication] openURL:[components URL]];
}

+ (void)textMessageWithPhoneNumber:(NSString *)phoneNumber {
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"sms";
    components.host = phoneNumber;
    [[UIApplication sharedApplication] openURL:[components URL]];
}

+ (void)addContactWithPhoneNumber:(NSString *)phoneNumber {
    UIViewController *contactsController = [MYAddressBookHelpers contactsViewControllerWithPhoneNumber:phoneNumber];
    [self presentViewController:contactsController];
}

+ (void)createEventWithDate:(NSDate *)date {
    EKEventStore *eventStore = [EKEventStore new];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            EKEventEditViewController *eventController = [EKEventEditViewController new];
            
            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
            event.startDate = date;
            event.endDate = date;
            event.allDay = YES;
            eventController.event = event;
            
            MYDismissingDelegate *delegate = [MYDismissingDelegate new];
            eventController.editViewDelegate = delegate;
            objc_setAssociatedObject(eventController, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            UIViewController *presenter = [UIViewController my_topViewController];
            if (!presenter) {
                NSLog(@"Failed to find a presenter view controller");
                return;
            }
            [presenter presentViewController:eventController animated:YES completion:nil];
        }
    }];
}

+ (void)showDateInCalendar:(NSDate *)date {
    NSInteger interval = [date timeIntervalSinceReferenceDate];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"calshow:%ld", interval]];
    [[UIApplication sharedApplication] openURL:URL];
}

+ (void)copyText:(NSString *)text {
    [UIPasteboard generalPasteboard].string = text;
}

#pragma mark - Helpers

+ (void)presentViewController:(UIViewController *)viewController {
    UIViewController *presenter = [UIViewController my_topViewController];
    if (!presenter) {
        NSLog(@"Failed to find a presenter view controller");
        return;
    }
    
    UIBarButtonItem *cancelItem = [UIBarButtonItem my_barButtonForSystemItem:UIBarButtonSystemItemCancel
                                                                      action:^(id sender) {
                                                                          [viewController dismissViewControllerAnimated:YES completion:nil];
                                                                      }];
    viewController.navigationItem.rightBarButtonItem = cancelItem;
    
    [presenter presentViewController:[[UINavigationController alloc] initWithRootViewController:viewController]
                            animated:YES completion:NULL];
}

@end
