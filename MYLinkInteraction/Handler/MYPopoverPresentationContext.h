//
//  MYPopoverPresentationContext.h
//  MYLinkInteraction
//
//  Created by Makarov Yury on 10/11/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYPopoverPresentationContext : NSObject

@property (strong, readonly, nonatomic) UIView *sourceView;
@property (assign, readonly, nonatomic) CGRect sourceRect;

- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect;

@end
