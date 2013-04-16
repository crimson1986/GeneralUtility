//
// REComposeViewController.h
// REComposeViewController
//
// Copyright (c) 2012 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "REComposeSheetView.h"
#import "REComposeBackgroundView.h"
#import "SMFacebook.h"
#import "SMTwitter.h"
enum REComposeResult {
    REComposeResultCancelled,
    REComposeResultPosted
};
typedef enum REComposeResult REComposeResult;

enum REComposeType {
    REComposeTypeNone,
    REComposeTypeFacebook,
    REComposeTypeTwitter,
    REComposeTypePinterest,
    REComposeTypeGPlus
};
typedef enum REComposeType REComposeType;

@class REComposeViewController;

typedef void (^REComposeViewControllerCompletionHandler)(REComposeViewController *composeViewController, REComposeResult result);

@protocol REComposeViewControllerDelegate;

@interface REComposeViewController : UIViewController <REComposeSheetViewDelegate> {
    REComposeSheetView *_sheetView;
    REComposeBackgroundView *_backgroundView;
    UIView *_backView;
    UIView *_containerView;
    UIImageView *_paperclipView;
    BOOL _hasAttachment;
    UIImage *_attachmentImage;
    NSURL *_url;
    UILabel *_lblCount;//tweet char count
}

@property (nonatomic) REComposeType REComposeType;

- (id)initWithType:(REComposeType)type;

- (UINavigationItem *)navigationItem;
- (UINavigationBar *)navigationBar;
- (NSString *)text;
- (void)setText:(NSString *)text;

- (BOOL)hasAttachment;
- (void)setHasAttachment:(BOOL)hasAttachment;

- (UIImage *)attachmentImage;
- (void)setAttachmentImage:(UIImage *)attachmentImage;

- (NSURL *)url;
- (void)setUrl:(NSURL *)url;

//- (BOOL)setInitialText:(NSString *)text;

@property (copy, nonatomic) REComposeViewControllerCompletionHandler completionHandler;
@property (nonatomic) id <REComposeViewControllerDelegate> delegate;
@property (assign, readwrite, nonatomic) NSInteger cornerRadius;
@property (nonatomic, strong) SMFacebook *facebook;
@property (nonatomic, strong) SMTwitter *twitter;
@end

@protocol REComposeViewControllerDelegate <NSObject>

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result;

@end
