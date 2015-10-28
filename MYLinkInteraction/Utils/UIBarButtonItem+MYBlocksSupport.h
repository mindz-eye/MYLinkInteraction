//
//  UIBarButtonItem+MYBlocksSupport.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MYBlocksSupport)

+ (instancetype)my_barButtonForSystemItem:(UIBarButtonSystemItem)systemItem action:(void (^)(id sender))action;

@end

NS_ASSUME_NONNULL_END
