//
//  ViewController.m
//  LinkInteraction
//
//  Created by Makarov Yury on 20/09/15.
//  Copyright © 2015 Makarov Yury. All rights reserved.
//

#import "ViewController.h"
#import <MYLinkInteraction/MYLinkInteraction.h>
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

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result {
    MYLinkInteractionHandler *handler = [MYLinkInteractionHandler new];
    MYLinkData *linkData = [[MYLinkData alloc] initWithLinkText:label.text textCheckingResult:result];
    [handler handlePressWithLinkData:linkData popoverContext:[self popoverContextForLabel:label textCheckingResult:result]];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    MYLinkInteractionHandler *handler = [MYLinkInteractionHandler new];
    MYLinkData *linkData = [[MYLinkData alloc] initWithLinkText:label.text textCheckingResult:result];
    [handler handleLongPressWithLinkData:linkData popoverContext:[self popoverContextForLabel:label textCheckingResult:result]];
}

#pragma mark - Popover context

- (CGRect)boundingRectForCharactersInRange:(NSRange)range ofAttributedString:(NSAttributedString *)attributedString inBounds:(CGRect)bounds {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:bounds.size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

- (MYPopoverPresentationContext *)popoverContextForLabel:(TTTAttributedLabel *)label textCheckingResult:(NSTextCheckingResult *)result {
    CGRect sourceRect = [self boundingRectForCharactersInRange:result.range ofAttributedString:label.attributedText inBounds:self.view.bounds];
    return [[MYPopoverPresentationContext alloc] initWithSourceView:label sourceRect:sourceRect];
}

@end
