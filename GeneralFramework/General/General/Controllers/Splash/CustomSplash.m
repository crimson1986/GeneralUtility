//
//  RMSplash.m
//  RegistrationModule
//
//  Created by Brijesh 04 on 27/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomSplash.h"

static unsigned int kProgressViewWidth = 40;
static unsigned int kProgressViewHeight = 40;
static unsigned int kProgressViewPaddingFromBottom = 70;
@interface CustomSplash ()
{
    NSTimer *_timer;
    float _tProcess;
    
}
@property (nonatomic,strong) UIActivityIndicatorView *progressView;
@property (nonatomic,strong) NSString *imageName;
- (void)startProgess;
- (void)stopProgress;
@end

@implementation CustomSplash
@synthesize imgSplash,
progressView = _progressView;
@synthesize delegate;
@synthesize imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageName:(NSString *)_imageName {
    self = [CustomSplash instanceOfNibNamed:@"CustomSplash"];
    if (self) {
        _tProcess = 0;
        self.imageName = _imageName;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imgSplash.image = [UIImage imageNamed:[self.imageName stringWithDevicePostFix]];
    [self.view addSubview:[self progressView]];
    [self startProgess];
}

- (void)viewDidUnload
{
    self.imageName = nil;
    [self setImgSplash:nil];
    [self setProgressView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

#pragma mark - Custom Methods

- (void)loadData {
    
}

- (void)startProgess {
    // set a timer that updates the progress
    [_progressView startAnimating];
	_timer = [NSTimer scheduledTimerWithTimeInterval: 0.03f target: self selector: @selector(updateProgress) userInfo: nil repeats: YES];
	[_timer fire];
}

- (void)stopProgress {
    [_progressView stopAnimating];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark ProgressView
- (CGRect)progressViewFrame {
    CGRect rect = CGRectZero;
    rect.origin.x = (int)(CGRectGetWidth([UIScreen mainScreen].applicationFrame) - kProgressViewWidth)/2;
    rect.origin.y = (int)(CGRectGetHeight([UIScreen mainScreen].applicationFrame) - kProgressViewHeight) - kProgressViewPaddingFromBottom;
    rect.size = CGSizeMake(kProgressViewWidth, kProgressViewHeight);
    
    return rect;
}
- (UIActivityIndicatorView *)progressView {
    if (!_progressView) {
        _progressView =  [UIActivityIndicatorView instanceOfClassNamed:@"UIActivityIndicatorView"]; 
        _progressView.frame = [self progressViewFrame];
        _progressView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _progressView;
}

- (void)updateProgress {
    _tProcess += 0.01 * 1;
    if (_tProcess > 1) {
        [self stopProgress];
        if ([self.delegate respondsToSelector:@selector(progressDidFinished)]) {
            [self.delegate progressDidFinished];
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Only rotate if all child view controllers agree on the new orientation.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
