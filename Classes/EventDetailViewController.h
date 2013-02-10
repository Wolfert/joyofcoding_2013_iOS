//
//  EventDetailViewController.h
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailViewController : UIViewController <UIWebViewDelegate>{

}

@property(nonatomic, retain) Event * event;
@property(nonatomic, retain) IBOutlet UIWebView * content;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView * activityIndicator;
@end
