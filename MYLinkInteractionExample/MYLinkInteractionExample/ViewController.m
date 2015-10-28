//
//  ViewController.m
//  LinkInteraction
//
//  Created by Makarov Yury on 20/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "ViewController.h"
#import <MYLinkInteraction/MYLinkInteractionHandler.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface ViewController () <TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *urlLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *phoneLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *addressLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *dateLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *mailLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabel:self.urlLabel];
    [self setupLabel:self.phoneLabel];
    [self setupLabel:self.addressLabel];
    [self setupLabel:self.dateLabel];
    [self setupLabel:self.mailLabel];
}

- (void)setupLabel:(TTTAttributedLabel *)label {
    label.delegate = self;
    label.enabledTextCheckingTypes = NSTextCheckingAllTypes;
    label.text = label.text;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByClipping;
    
    UIColor *textColor = [UIColor colorWithRed:0 green:110.0/255 blue:1.0 alpha:1.0];
    UIColor *fillColor = [UIColor colorWithRed:186.0/255 green:186.0/255 blue:186.0/255 alpha:1.0];
    
    label.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName: (id)textColor.CGColor,
                             (NSString *)kCTUnderlineStyleAttributeName: @NO};
    label.activeLinkAttributes = @{(NSString *)kTTTBackgroundFillColorAttributeName: (id)fillColor.CGColor,
                                   (NSString *)kTTTBackgroundCornerRadiusAttributeName: @(5)};
}

- (MYPopoverPresentationContext *)popoverContextForLabel:(TTTAttributedLabel *)label {
    MYPopoverPresentationContext *context = [MYPopoverPresentationContext new];
    context.sourceView = label;
    context.sourceRect = label.bounds;
    return context;
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result {
    MYLinkInteractionHandler *handler = [MYLinkInteractionHandler new];
    [handler handleLinkInteractionType:MYLinkInteractionTypePress linkText:label.text
                    textCheckingResult:result popoverContext:[self popoverContextForLabel:label]];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    MYLinkInteractionHandler *handler = [MYLinkInteractionHandler new];
    [handler handleLinkInteractionType:MYLinkInteractionTypeLongPress linkText:label.text
                    textCheckingResult:result popoverContext:[self popoverContextForLabel:label]];
}

@end
