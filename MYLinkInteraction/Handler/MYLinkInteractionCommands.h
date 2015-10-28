//
//  MYLinkInteractionCommands.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYLinkInteractionCommands : NSObject

+ (void)openURL:(NSURL *)URL;
+ (void)addURLToReadingList:(NSURL *)URL;
+ (void)copyURL:(NSURL *)URL;

+ (void)openInMapsWithAddressComponents:(NSDictionary *)addressComponents;
+ (void)addContactWithAddressComponents:(NSDictionary *)addressComponents;

+ (void)mailMessageWithEmail:(NSString *)email;
+ (void)addContactWithEmail:(NSString *)email;

+ (void)callWithPhoneNumber:(NSString *)phoneNumber;
+ (void)faceTimeAudioWithNumber:(NSString *)phoneNumber;
+ (void)textMessageWithPhoneNumber:(NSString *)phoneNumber;
+ (void)addContactWithPhoneNumber:(NSString *)phoneNumber;

+ (void)createEventWithDate:(NSDate *)date;
+ (void)showDateInCalendar:(NSDate *)date;

+ (void)copyText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END