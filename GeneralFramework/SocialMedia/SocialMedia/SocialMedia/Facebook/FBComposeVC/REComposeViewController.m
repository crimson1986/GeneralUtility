//
// REComposeViewController.m
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

#import "REComposeViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kTwitterTextLimit @"140"

@interface REComposeViewController ()<UITextViewDelegate>
//@property (nonatomic, strong) BSKeyboardControls *keyBoardControl;
@end

@implementation REComposeViewController

- (id)initWithType:(REComposeType)type {
    self = [super init];
    if (self) {
        self.REComposeType = type;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cornerRadius = 10;
        _sheetView = [[REComposeSheetView alloc] initWithFrame:CGRectMake(0, 0, self.currentWidth - 8, 202)];
    }
    return self;
}

- (int)currentWidth
{
    UIScreen *screen = [UIScreen mainScreen];
    return (!UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) ? screen.bounds.size.width : screen.bounds.size.height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _backgroundView = [[REComposeBackgroundView alloc] initWithFrame:self.view.bounds];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backgroundView.centerOffset = CGSizeMake(0, - self.view.frame.size.height / 2);
    _backgroundView.alpha = 0;
    
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 202)];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(4, 0, self.currentWidth - 8, 202)];
    _backView.layer.cornerRadius = _cornerRadius;
    _backView.layer.shadowOpacity = 0.7;
    _backView.layer.shadowColor = [UIColor blackColor].CGColor;
    _backView.layer.shadowOffset = CGSizeMake(3, 5);
    
    _sheetView.frame = _backView.bounds;
    _sheetView.layer.cornerRadius = _cornerRadius;
    _sheetView.clipsToBounds = YES;
    _sheetView.delegate = self;
    
    [self.view addSubview:_backgroundView];
    [_containerView addSubview:_backView];
    [self.view addSubview:_containerView];
    [_backView addSubview:_sheetView];
    
    _paperclipView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 77, 60, 79, 34)];
    _paperclipView.image = [UIImage imageNamed:@"REComposeViewController.bundle/PaperClip"];
    [_containerView addSubview:_paperclipView];
    [_paperclipView setHidden:YES];
    
    if (!_attachmentImage)
        _attachmentImage = [UIImage imageNamed:@"REComposeViewController.bundle/URLAttachment"];
    
    _sheetView.attachmentImageView.image = _attachmentImage;

    _sheetView.textView.delegate = self;
    
    
    
    if (self.REComposeType == REComposeTypeTwitter) {
        //lbl count char for twiter
        _lblCount = [[UILabel alloc] initWithFrame:CGRectZero];
        _lblCount.backgroundColor = [UIColor clearColor];
        _lblCount.textAlignment = NSTextAlignmentRight;
        _lblCount.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        _lblCount.shadowColor = [UIColor grayColor];
        _lblCount.shadowOffset = CGSizeMake(1, 1);
        CGRect rect = _lblCount.frame;
        rect.origin.x = 10;
        rect.origin.y = CGRectGetHeight(_containerView.frame)-25;
        rect.size = CGSizeMake(CGRectGetWidth(_containerView.frame)-20, 25);
        _lblCount.frame = rect;
        _lblCount.text = kTwitterTextLimit;
        [_containerView addSubview:_lblCount];
    }
//    self.keyBoardControl = [AppUtility setupKeyboardControls:[NSArray arrayWithObjects:_sheetView.textView, nil] forDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_sheetView.textView becomeFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^{
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            [self layoutWithOrientation:self.interfaceOrientation width:self.view.frame.size.height height:self.view.frame.size.width];
        } else {
            [self layoutWithOrientation:self.interfaceOrientation width:self.view.frame.size.width height:self.view.frame.size.height];
        }
    }];
    
    [UIView animateWithDuration:0.4
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _backgroundView.alpha = 1;
                     } completion:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)viewDidUnload {
    self.facebook = nil;
    self.completionHandler = nil;
    [super viewDidUnload];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)layoutWithOrientation:(UIInterfaceOrientation)interfaceOrientation width:(NSInteger)width height:(NSInteger)height
{
    NSInteger offset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 60 : 4;
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        CGRect frame = _containerView.frame;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            offset *= 2;
        }
        
        NSInteger verticalOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 316 : 216;
        
        NSInteger containerWidth = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? _containerView.frame.size.height : _containerView.frame.size.width;
        frame.origin.y = (width - verticalOffset - containerWidth) / 2;
        if (frame.origin.y < 0) frame.origin.y = 0;
        _containerView.frame = frame;
        
        _containerView.clipsToBounds = YES;
        _backView.frame = CGRectMake(offset, 0, height - offset*2, UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 202 : 140);
        _sheetView.frame = _backView.bounds;
        
        CGRect paperclipFrame = _paperclipView.frame;
        paperclipFrame.origin.x = height - 73 - offset;
        _paperclipView.frame = paperclipFrame;
    } else {
        CGRect frame = _containerView.frame;
        frame.origin.y = (height - 216 - _containerView.frame.size.height) / 2;
        if (frame.origin.y < 0) frame.origin.y = 0;
        _containerView.frame = frame;
        _backView.frame = CGRectMake(offset, 0, width - offset*2, 202);
        _sheetView.frame = _backView.bounds;
        
        CGRect paperclipFrame = _paperclipView.frame;
        paperclipFrame.origin.x = width - 73 - offset;
        _paperclipView.frame = paperclipFrame;
    }
    
    _paperclipView.hidden = !_hasAttachment;
    _sheetView.attachmentView.hidden = !_hasAttachment;
    
    [_sheetView.navigationBar sizeToFit];
    
    CGRect attachmentViewFrame = _sheetView.attachmentView.frame;
    attachmentViewFrame.origin.x = _sheetView.frame.size.width - 84;
    attachmentViewFrame.origin.y = _sheetView.navigationBar.frame.size.height + 10;
    _sheetView.attachmentView.frame = attachmentViewFrame;
    
    CGRect textViewFrame = _sheetView.textView.frame;
    textViewFrame.size.width = !_hasAttachment ? _sheetView.frame.size.width : _sheetView.frame.size.width - 84;
    _sheetView.textView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, _hasAttachment ? -85 : 0);
    textViewFrame.size.height = _sheetView.frame.size.height - _sheetView.navigationBar.frame.size.height - 3;
    _sheetView.textView.frame = textViewFrame;
    
    CGRect textViewContainerFrame = _sheetView.textViewContainer.frame;
    textViewContainerFrame.origin.y = _sheetView.navigationBar.frame.size.height;
    textViewContainerFrame.size.height = _sheetView.frame.size.height - _sheetView.navigationBar.frame.size.height;
    _sheetView.textViewContainer.frame = textViewContainerFrame;
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [_sheetView.textView resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = _containerView.frame;
        frame.origin.y = self.view.frame.size.height;
        _containerView.frame = frame;
    }];
    
    [UIView animateWithDuration:0.4
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _backgroundView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [super dismissViewControllerAnimated:NO completion:nil];
                     }];
}

/*
 *set initial text if it ecxeed to 140 char then it wrap char
 */
- (void)twitterTextLenghtCalculation {
    if (self.text != nil) {
        NSString *format    = @"%@";
        if (self.url != nil)
            format          = [format stringByAppendingFormat:@" %@", [self.url absoluteString]];
        //    if (self.tweetCC != nil)
        //        format          = [format stringByAppendingFormat:@" %@", self.tweetCC];
        // TEXT
        NSUInteger idx      = self.text.length;
        
        while([self.text hasPrefix:@" "])
            _sheetView.textView.text = [self.text substringFromIndex:1];
        while([self.text hasSuffix:@" "])
        {
            idx       = idx-1;
            _sheetView.textView.text = [self.text substringToIndex:idx];
        }
        // create message
        NSString *message   = [NSString stringWithFormat:format, [NSString stringWithFormat:@"%@", [self.text substringToIndex:idx]]];
        
        
        // if the message is bigger than 140 characters, then cut the message
        while (![self setInitialText:message])
        {
            idx -= 5;
            if (idx > 5)
            {
                message = [NSString stringWithFormat:format, [NSString stringWithFormat:@"%@…", [self.text substringToIndex:idx]]];
            }
            else
            {
                [self setInitialText:[self.url absoluteString]];
                break;
            }
        }
    }
    
}
#pragma mark -
#pragma mark Accessors

- (UINavigationItem *)navigationItem
{
    return _sheetView.navigationItem;
}

- (UINavigationBar *)navigationBar
{
    return _sheetView.navigationBar;
}

- (UIImage *)attachmentImage
{
    return _attachmentImage;
}

- (void)setAttachmentImage:(UIImage *)attachmentImage
{
    _attachmentImage = attachmentImage;
    _sheetView.attachmentImageView.image = _attachmentImage;
}

- (BOOL)hasAttachment
{
    return _hasAttachment;
}

- (void)setHasAttachment:(BOOL)hasAttachment
{
    _hasAttachment = hasAttachment;
}

- (NSString *)text
{
    return _sheetView.textView.text;
}

- (void)setText:(NSString *)text
{
    if (self.REComposeType == REComposeTypeTwitter) {
        [self twitterTextLenghtCalculation];
    }
    else 
    _sheetView.textView.text = text;
}

- (NSURL *)url {
    return _url;
}

- (void)setUrl:(NSURL *)url {
    _url = url;
}

- (BOOL)setInitialText:(NSString *)text {
   
    NSString *rtString = [self calculateText:text];
    if (rtString < 0) {
        return NO;
    }
    _sheetView.textView.text = text;
    return YES;
}
#pragma mark -
#pragma mark Facebook

- (SMFacebook *)facebook {
    if (!_facebook) {
        _facebook = [[SMFacebook alloc] init];
    }
    return _facebook;
}
/*
 post message, photo,urls to facebook
 */
- (void)postToFacebook
{
    __block REComposeViewController *vc = self;
    [self.facebook openSessionIfNeededWithHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        NSMutableDictionary *d = nil;
        if ( vc.url && vc.attachmentImage ) {
            d = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@\n%@",vc.text,vc.url]
                                                   forKey:@"message"];
        } else {
            d = [NSMutableDictionary dictionaryWithObject:self.text
                                                   forKey:@"message"];
        }
        
        NSString *graphPath = @"me/feed";
        
        
        
        if (vc.url) {
            [d setObject:vc.url forKey:@"link"];
        }
        
        if (vc.attachmentImage) {
            [d setObject:UIImagePNGRepresentation(vc.attachmentImage ) forKey:@"source"];
            graphPath = @"me/photos";
        }
        
        /*if ([self.customParameters count] > 0) {
         [d addEntriesFromDictionary:self.customParameters];
         }*/
        
        // create the connection object
//        [self.keyBoardControl.activeTextField resignFirstResponder];
        [_sheetView.textView resignFirstResponder];
        [self.facebook postOnFacebookForSession:self.facebook.session
                                      graphPath:graphPath
                                     parameters:d
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  if (error)
                                  {
                                      id<REComposeViewControllerDelegate> localDelegate = _delegate;
                                      if (localDelegate && [localDelegate respondsToSelector:@selector(composeViewController:didFinishWithResult:)]) {
                                          [localDelegate composeViewController:vc didFinishWithResult:REComposeResultCancelled];
                                      }
                                      if (_completionHandler)
                                          _completionHandler(vc, REComposeResultCancelled);
                                  }
                                  else
                                  {
                                      id<REComposeViewControllerDelegate> localDelegate = _delegate;
                                      if (localDelegate && [localDelegate respondsToSelector:@selector(composeViewController:didFinishWithResult:)]) {
                                          [localDelegate composeViewController:vc didFinishWithResult:REComposeResultPosted];
                                      }
                                      if (_completionHandler)
                                          _completionHandler(vc, REComposeResultPosted);
                                  }
                              }];
        
    }];
    
}


#pragma mark -
#pragma mark Twitter
/*
 * initialized twitter
 */
- (SMTwitter *)twitter {
    if (!_twitter) {
        _twitter = [[SMTwitter alloc] initTwitter];
    }
    return _twitter;
}
/*
 * Post tweet and images
 */
- (void)postToTwitter {
    if ([self.twitter isAuthorized]) {
        [_sheetView.textView resignFirstResponder];
        
        
        //check only for text if no image attached
        if (![RMValidtor isEmptyText:self.text] && !self.hasAttachment) {
            [[BCAppShared sharedInstance] showIndicatorWithText:localizedString(@"Please wait...") inWindow:self.view.window];
            [self.twitter postTweet:self.text result:^(NSError *result) {
                [[BCAppShared sharedInstance] hideIndicator];
                if (result) {
                    if (_completionHandler)
                        _completionHandler(self, REComposeResultCancelled);
                }
                else {
                    if (_completionHandler)
                        _completionHandler(self, REComposeResultPosted);
                }
            }];
        }
       
        //if both image and text are attached
        if (self.hasAttachment && ![RMValidtor isEmptyText:self.text]) {
            [[BCAppShared sharedInstance] showIndicatorWithText:localizedString(@"Please wait...") inWindow:self.view.window];
            [self.twitter postTweet:self.text
                      withImageData:UIImageJPEGRepresentation(self.attachmentImage, 0.8)
                             result:^(NSError *result) {
                                 
                                 [[BCAppShared sharedInstance] hideIndicator];
                                 if (result) {
                                     if (_completionHandler)
                                         _completionHandler(self, REComposeResultCancelled);
                                 }
                                 else {
                                     if (_completionHandler)
                                         _completionHandler(self, REComposeResultPosted);
                                 }
            }];
        }

    }
    else {
        [self.twitter openFromController:self withResult:^(bool result) {
            if (result) {
                [self performSelector:@selector(postToTwitter) withObject:nil afterDelay:1];// recusive call
            }
            else {
                //TODO: alert for Error 
            }
        }];
    }
}
#pragma mark -
#pragma mark REComposeSheetViewDelegate

- (void)cancelButtonPressed
{
    id<REComposeViewControllerDelegate> localDelegate = _delegate;
    if (localDelegate && [localDelegate respondsToSelector:@selector(composeViewController:didFinishWithResult:)]) {
        [localDelegate composeViewController:self didFinishWithResult:REComposeResultCancelled];
    }
    if (_completionHandler)
        _completionHandler(self, REComposeResultCancelled);
}

- (void)postButtonPressed
{
    switch (self.REComposeType) {
        case REComposeTypeFacebook:
            [self postToFacebook];        
            break;
        case REComposeTypeTwitter:
            [self postToTwitter];
            break;
        default:
            break;
    }
    
    /*id<REComposeViewControllerDelegate> localDelegate = _delegate;
     if (localDelegate && [localDelegate respondsToSelector:@selector(composeViewController:didFinishWithResult:)]) {
     [localDelegate composeViewController:self didFinishWithResult:REComposeResultPosted];
     }
     if (_completionHandler)
     _completionHandler(self, REComposeResultPosted);
     */
}

#pragma mark -
#pragma mark Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

- (void)viewOrientationDidChanged:(NSNotification *)notification
{
    [self layoutWithOrientation:self.interfaceOrientation width:self.view.frame.size.width height:self.view.frame.size.height];
}

- (NSString *)calculateText:(NSString *)text {
    
    NSString *count = [NSString stringWithFormat:@"%d",([kTwitterTextLimit intValue] - text.length)];
    return count;
}
#pragma mark -
#pragma mark Key board controls
/*- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
}
- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [textField becomeFirstResponder];
    
}*/

- (void)textViewDidBeginEditing:(UITextView *)textView {
    /*if ([self.keyBoardControl.textFields containsObject:textView])
        self.keyBoardControl.activeTextField = textView;*/
    _lblCount.text = [self calculateText:textView.text];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    _lblCount.text = [self calculateText:textView.text];
    
    return YES;
}
@end
