# MYLinkInteraction

**A drop-in replacement for UITextView link interaction actions**
   

![Screenshot0][img0] &nbsp;&nbsp; ![Screenshot1][img1] &nbsp;&nbsp;

![Screenshot2][img2] &nbsp;&nbsp; ![Screenshot3][img3]


## Description

UITextView has the ability to interact with various types of links in text. In addition to opening a responsible app for handling a custom URL, it provides a set of actions for standard link types including web URLs, phone numbers, addresses and dates.

Unfortunately, there is no way to customize it’s behavior other than disable it completely via [-textView:shouldInteractWithURL:inRange:](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITextViewDelegate_Protocol/#//apple_ref/occ/intfm/UITextViewDelegate/textView:shouldInteractWithURL:inRange:)

And since all the trickery is done inside a private framework without any public API exposed to programmer, there’s no way to use these outside of UITextView as well.

MYLinkInteraction provides a full set of actions available in UITextView, but doesn’t tie itself to any particular UI. It can be used with UILabel, [TTTAttributedLabel](https://github.com/TTTAttributedLabel/TTTAttributedLabel) or even with UITextView itself.

## Requirements

* iOS 8.0+
* ARC

## Installation

From [CocoaPods](http://cocoapods.org):

````ruby
pod 'MYLinkInteraction'
````

## Usage

Import all the things:

````objective-c
#import <MYLinkInteraction/MYLinkInteraction.h>
````

Assuming you already have a code which parses a link and gets NSTextCheckingResult. The usage is really simple then.

In case with [TTTAttributedLabel](https://github.com/TTTAttributedLabel/TTTAttributedLabel):

````objective-c
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result {
    MYLinkInteractionHandler *handler = [MYLinkInteractionHandler new];
    MYLinkData *linkData = [[MYLinkData alloc] initWithLinkText:label.text textCheckingResult:result];
    [handler handlePressWithLinkData:linkData popoverContext:nil];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    MYLinkInteractionHandler *handler = [MYLinkInteractionHandler new];
    MYLinkData *linkData = [[MYLinkData alloc] initWithLinkText:label.text textCheckingResult:result];
    [handler handleLongPressWithLinkData:linkData popoverContext:nil];
}
````

See example app for details.

## License

`MYLinkInteraction` is released under an [MIT License][mitLink]. See LICENSE file for details.


[mitLink]:http://opensource.org/licenses/MIT
[img0]:https://raw.github.com/mindz-eye/MYLinkInteraction/master/Screenshots/screenshot0.png
[img1]:https://raw.github.com/mindz-eye/MYLinkInteraction/master/Screenshots/screenshot1.png
[img2]:https://raw.github.com/mindz-eye/MYLinkInteraction/master/Screenshots/screenshot2.png
[img3]:https://raw.github.com/mindz-eye/MYLinkInteraction/master/Screenshots/screenshot3.png


