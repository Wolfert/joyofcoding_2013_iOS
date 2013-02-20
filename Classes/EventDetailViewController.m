//
//  EventDetailViewController.m
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController
@synthesize content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgnoise.png"]];
    self.title = _event.title;
    
    
    NSError  * error;
    NSURL    * contentURL  = [NSURL URLWithString:_event.contentURL];
    NSString * contentPage = [NSString stringWithContentsOfURL:contentURL
                                                      encoding:NSASCIIStringEncoding
                                                         error:&error];
    
    
    // Append CSS & fonts from JOC website
    contentPage = [contentPage stringByAppendingString:@"<style type=\"text/css\"></style>\n<link href=\'http://fonts.googleapis.com/css?family=Monda|Arvo\' rel=\'stylesheet\' type=\'text/css\'>\n<link href=\"css/bootstrap.min.css\" rel=\"stylesheet\" type=\"text/css\">\n<link href=\"css/bootstrap-responsive.min.css\" rel=\"stylesheet\" type=\"text/css\">\n<link href=\"css/font-awesome.min.css\" rel=\"stylesheet\">\n<link href=\"css/jquery.fancybox.css?v=2.1.3\" rel=\"stylesheet\" type=\"text/css\">\n<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\">\n\n"];

    [content setBackgroundColor:[UIColor clearColor]];
    [content setOpaque:NO];
    [content loadHTMLString:contentPage baseURL:[NSURL URLWithString:@"http://joyofcoding.org/"]];
    [content setDelegate:self];
    [_activityIndicator startAnimating];
    [self.view addSubview:content];

    [self removeShadowFromWebView];
}


- (void)removeShadowFromWebView {
    for (UIView* shadowView in [content.scrollView subviews])
    {
        if ([shadowView isKindOfClass:[UIImageView class]]) {
            [shadowView setHidden:YES];
        }
    }
}


-(void) viewDidUnload {
    [self setContent:nil];
    [super viewDidUnload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicator removeFromSuperview];
}

#pragma mark - webView delegate

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)type {
    if ( type == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
