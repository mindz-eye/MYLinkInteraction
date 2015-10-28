//
//  MYLinkInteractionHandler.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYLinkInteractionAction;
@class MYPopoverPresentationContext;
@protocol MYLinkInteractionHandlerDelegate;

typedef NS_ENUM(NSInteger, MYLinkInteractionType) {
    MYLinkInteractionTypePress,
    MYLinkInteractionTypeLongPress
};

@interface MYLinkInteractionHandler : NSObject

@property (weak, nonatomic, nullable) id<MYLinkInteractionHandlerDelegate> delegate;

- (void)handleLinkInteractionType:(MYLinkInteractionType)type
                         linkText:(NSString *)linkText
               textCheckingResult:(NSTextCheckingResult *)result
                   popoverContext:(nullable MYPopoverPresentationContext *)popoverContext;

@end


@protocol MYLinkInteractionHandlerDelegate <NSObject>

@optional

- (NSArray<MYLinkInteractionAction *> *)linkInteractionHandler:(MYLinkInteractionHandler *)handler
                                     actionsFroProposedActions:(NSArray<MYLinkInteractionAction *> *)actions;

@end


@interface MYPopoverPresentationContext : NSObject

@property (strong, nonatomic) UIView *sourceView;
@property (assign, nonatomic) CGRect sourceRect;

@end

NS_ASSUME_NONNULL_END
