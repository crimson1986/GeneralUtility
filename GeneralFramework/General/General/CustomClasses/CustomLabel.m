
#import "CustomLabel.h"

@implementation CustomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    switch (self.tag)
    {
            
        case BSLabelTypeNewsLetterheading:
             self.font = [UIFont fontWithName:@"OpenSans-Bold" size:14.0];
            self.textColor = ProductdesColor;
            break;
        case BSLabelTypePopupheading:
            self.font = [UIFont fontWithName:@"OpenSans-Bold" size:14.0];
            break;
        case BSLabelTypeContactMarkUpdate:
            self.font = [UIFont fontWithName:@"OpenSans" size:13.0];
            self.textColor = [UIColor customInputTextColor];
            break;
        default:
            self.font = [UIFont fontWithName:@"OpenSans" size:14.0];
            self.textColor = ProductdesColor;
            break;
    }
    
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    NSUInteger noOfLines = self.numberOfLines;
    NSUInteger heightWithLines = self.font.leading * noOfLines;
    
    CGSize h = [AppUtility calculateHeightForText:text font:self.font size:CGSizeMake(CGRectGetWidth(self.frame), 4000)];
    CGRect rect = self.frame;
    rect.size.height = (((heightWithLines+5)< h.height)&&(noOfLines!=0))?(heightWithLines+5):h.height;//margin
    self.frame = rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
