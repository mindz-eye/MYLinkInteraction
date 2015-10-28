//
//  MYAddressBookHelpers.m
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYAddressBookHelpers.h"
#import "UIViewController+MYHelpers.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, MYABPropertyID) {
    MYABPropertyEmail,
    MYABPropertyPhoneNumber
};

static ABPropertyID MYToABPropertyId(MYABPropertyID propId) {
    if (propId == MYABPropertyEmail) {
        return kABPersonEmailProperty;
    } else {
        return kABPersonPhoneProperty;
    }
}

@interface MYUnknownPersonViewControllerDelegate : NSObject <ABUnknownPersonViewControllerDelegate>
@end

@implementation MYUnknownPersonViewControllerDelegate

- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonViewController didResolveToPerson:(ABRecordRef)person {
    [unknownPersonViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end


@implementation MYAddressBookHelpers

+ (ABMutableMultiValueRef)addressWithAddressComponents:(NSDictionary *)addressComponents {
    CFMutableDictionaryRef addressData = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    
    if (addressComponents[NSTextCheckingStreetKey]) {
        CFDictionarySetValue(addressData, kABPersonAddressStreetKey, (__bridge const void *)(addressComponents[NSTextCheckingStreetKey]));
    }
    if (addressComponents[NSTextCheckingCityKey]) {
        CFDictionarySetValue(addressData, kABPersonAddressCityKey, (__bridge const void *)(addressComponents[NSTextCheckingCityKey]));
    }
    if (addressComponents[NSTextCheckingStateKey]) {
        CFDictionarySetValue(addressData, kABPersonAddressStateKey, (__bridge const void *)(addressComponents[NSTextCheckingStateKey]));
    }
    if (addressComponents[NSTextCheckingZIPKey]) {
        CFDictionarySetValue(addressData, kABPersonAddressZIPKey, (__bridge const void *)(addressComponents[NSTextCheckingZIPKey]));
    }
    if (addressComponents[NSTextCheckingCountryKey]) {
        CFDictionarySetValue(addressData, kABPersonAddressCountryKey, (__bridge const void *)(addressComponents[NSTextCheckingCountryKey]));
    }

    ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    ABMultiValueAddValueAndLabel(address, addressData, NULL, NULL);
    CFRelease(addressData);
    
    return address;
}

+ (ABRecordRef)personWithAddressComponents:(NSDictionary *)addressComponents {
    ABRecordRef person = ABPersonCreate();

    if (addressComponents[NSTextCheckingNameKey]) {
        ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFTypeRef)(addressComponents[NSTextCheckingNameKey]), NULL);
    }    
    if (addressComponents[NSTextCheckingJobTitleKey]) {
        ABRecordSetValue(person, kABPersonJobTitleProperty, (__bridge CFTypeRef)(addressComponents[NSTextCheckingJobTitleKey]), NULL);
    }
    if (addressComponents[NSTextCheckingOrganizationKey]) {
        ABRecordSetValue(person, kABPersonOrganizationProperty, (__bridge CFTypeRef)(addressComponents[NSTextCheckingOrganizationKey]), NULL);
    }
    
    ABMutableMultiValueRef address = [self addressWithAddressComponents:addressComponents];
    ABRecordSetValue(person, kABPersonAddressProperty, address, NULL);
    CFRelease(address);
    
    return person;
}

+ (ABRecordRef)personWithPropertyId:(MYABPropertyID)propertyId value:(NSString *)value {
    ABRecordRef person = ABPersonCreate();

    ABMutableMultiValueRef propertyValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(propertyValue, (__bridge CFTypeRef)(value), NULL, NULL);

    ABRecordSetValue(person, MYToABPropertyId(propertyId), propertyValue, NULL);
    CFRelease(propertyValue);
    
    return person;
}

+ (ABUnknownPersonViewController *)unknownPersonViewControllerWithPerson:(ABRecordRef)person {
    ABUnknownPersonViewController *controller = [ABUnknownPersonViewController new];
    controller.displayedPerson = person;
    controller.allowsAddingToAddressBook = YES;
    
    MYUnknownPersonViewControllerDelegate *delegate = [MYUnknownPersonViewControllerDelegate new];
    controller.unknownPersonViewDelegate = delegate;
    objc_setAssociatedObject(controller, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return controller;
}

+ (UIViewController *)contactsViewControllerWithAddressComponents:(NSDictionary *)addressComponents {
    ABRecordRef person = [self personWithAddressComponents:addressComponents];
    ABUnknownPersonViewController *controller = [self unknownPersonViewControllerWithPerson:person];
    CFRelease(person);
    return controller;
}

+ (UIViewController *)contactsViewControllerWithEmail:(NSString *)email {
    ABRecordRef person = [self personWithPropertyId:MYABPropertyEmail value:email];
    ABUnknownPersonViewController *controller = [self unknownPersonViewControllerWithPerson:person];
    CFRelease(person);
    return controller;
}

+ (UIViewController *)contactsViewControllerWithPhoneNumber:(NSString *)phoneNumber {
    ABRecordRef person = [self personWithPropertyId:MYABPropertyPhoneNumber value:phoneNumber];
    ABUnknownPersonViewController *controller = [self unknownPersonViewControllerWithPerson:person];
    CFRelease(person);
    return controller;
}

@end
