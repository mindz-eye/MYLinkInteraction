//
//  MYAddressBookHelpers.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYAddressBookHelpers : NSObject

+ (UIViewController *)contactsViewControllerWithAddressComponents:(NSDictionary *)addressComponents;
+ (UIViewController *)contactsViewControllerWithEmail:(NSString *)email;
+ (UIViewController *)contactsViewControllerWithPhoneNumber:(NSString *)phoneNumber;

@end

NS_ASSUME_NONNULL_END
