//
//  MYDefaultActionsFactory.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 06/10/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MYLinkInteractionAction;

@interface MYDefaultActionsFactory : NSObject

+ (MYLinkInteractionAction *)openURLActionWithURL:(NSURL *)URL;
+ (nullable MYLinkInteractionAction *)addToReadingListActionWithURL:(NSURL *)URL;
+ (MYLinkInteractionAction *)copyActionWithURL:(NSURL *)URL;

+ (MYLinkInteractionAction *)openInMapsActionWithAddressComponents:(NSDictionary *)addressComponents;
+ (MYLinkInteractionAction *)addContactActionWithAddressComponents:(NSDictionary *)addressComponents;

+ (MYLinkInteractionAction *)mailMessageActionWithEmail:(NSString *)email;
+ (MYLinkInteractionAction *)addContactActionWithEmail:(NSString *)email;

+ (nullable MYLinkInteractionAction *)callActionWithPhoneNumber:(NSString *)phoneNumber;
+ (MYLinkInteractionAction *)faceTimeAudioActionWithPhoneNumber:(NSString *)phoneNumber;
+ (MYLinkInteractionAction *)textMessageActionWithPhoneNumber:(NSString *)phoneNumber;
+ (MYLinkInteractionAction *)addContactActionWithPhoneNumber:(NSString *)phoneNumber;

+ (MYLinkInteractionAction *)createEventActionWithDate:(NSDate *)date;
+ (MYLinkInteractionAction *)showDateActionWithDate:(NSDate *)date;

+ (MYLinkInteractionAction *)copyActionWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
