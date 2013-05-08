


#ifdef DEBUG
#    define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif

#define SELECTED_VIEW_CONTROLLER_TAG 98456345
#define NOTIFICATION_IMAGE_VIEW_TAG 98456346

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

typedef enum {
    MTOrientationPortraite,
    MTOrientationLandScape
} MTOrientation;

static const CGFloat BOLD_CELL_TITLE_FONT_SIZE = 14.0;
static const CGFloat NORMAL_CELL_TITLE_FONT_SIZE = 12.0;
static const CGFloat MIDDLE_CELL_TITLE_FONT_SIZE = 13.0;
/*
 */
typedef enum {
    
    RMTextFieldTagEmail = 100,
    RMTextFieldTagPassword,
    RMTextFieldTagFirstname,
    RMTextFieldTagLastname,
    RMTextFieldTagZipCode,
    RMTextFieldTagHint
    
}RMTextFieldTag;

typedef enum {
    
    RMSuperViewLogin = 10,
    RMSuperViewRegistration
    
}RMTextFieldSuperViewTag;

typedef enum {
    
    RMButtonTypeCall = 100,
    RMButtonTypeSubmit,
    RMButtonTypeCheck,
    RMButtonTypeLike
    
}RMButtonType;
#define kClientID  @"462275706571.apps.googleusercontent.com"
#define kPagging 10
#define kNavigationBarHeight 44
#define kTableRowHeight 44
#define kPageSize 10
#define FONT_STYLE @"OpenSans"
#define FONT_STYLE_BOLD @"OpenSans-Bold"

//for photo url
#define PhotoURL @"http://projects.spinxweb.net/BookTraderServices/CoverImages/"
#define CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define CHARACTERS_NUMBERS  [CHARACTERS stringByAppendingString:@"1234567890"]
#define NUMBERS @"0123456789"

#define ProductdesColor [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0]


//screens name
#define kDashboard  @"Dashboard"
#define kProducts   @"Products"
#define kMarket     @"Market"
#define kSpecials   @"Specials"
#define kNews       @"News"
#define kNewsLetters @"News Letters"
#define kContactUs  @"Contact Us"
#define kProductDetails @"Product Details"
#define kSplash     @"Splash"

//Events
#define kMore   @"More"
#define kFindProduct @"Find Product Open"
#define kFindProductClosed @"Find Product Closed"
#define kSearch @"Search"
//#define kMarketClicked
#define kEmailClicked   @"Email send"
#define kSubmit @"Submit"
#define kVideoPlay  @"Video play"
#define kCall @"Call"

