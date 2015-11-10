//
//  MYLinkInteractionHandler.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 26/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "MYLinkData.h"
#import "MYPopoverPresentationContext.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYLinkInteractionAction;
@protocol MYLinkInteractionHandlerDelegate;

@interface MYLinkInteractionHandler : NSObject

@property (weak, nonatomic, nullable) id<MYLinkInteractionHandlerDelegate> delegate;

- (void)handlePressWithLinkData:(MYLinkData *)linkData popoverContext:(nullable MYPopoverPresentationContext *)popoverContext;

- (void)handleLongPressWithLinkData:(MYLinkData *)linkData popoverContext:(nullable MYPopoverPresentationContext *)popoverContext;

@end


@protocol MYLinkInteractionHandlerDelegate <NSObject>

@optional

- (NSArray<MYLinkInteractionAction *> *)linkInteractionHandler:(MYLinkInteractionHandler *)handler
                                     actionsFroProposedActions:(NSArray<MYLinkInteractionAction *> *)actions;

@end

NS_ASSUME_NONNULL_END
