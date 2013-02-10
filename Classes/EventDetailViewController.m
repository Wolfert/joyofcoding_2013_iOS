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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgnoise.png"]];
    self.title = _event.title;
    
    
    NSString *googleString = _event.contentURL;
    NSURL *googleURL = [NSURL URLWithString:googleString];
    NSError *error;
    NSString *googlePage = [NSString stringWithContentsOfURL:googleURL
                                                    encoding:NSASCIIStringEncoding
                                                       error:&error];
    
    
    googlePage = [googlePage stringByAppendingString:@"    <style type=\"text/css\"></style>\n    <link href=\'http://fonts.googleapis.com/css?family=Monda|Arvo\' rel=\'stylesheet\' type=\'text/css\'>\n    <link href=\"css/bootstrap.min.css\" rel=\"stylesheet\" type=\"text/css\">\n    <link href=\"css/bootstrap-responsive.min.css\" rel=\"stylesheet\" type=\"text/css\">\n    <link href=\"css/font-awesome.min.css\" rel=\"stylesheet\">\n    <link href=\"css/jquery.fancybox.css?v=2.1.3\" rel=\"stylesheet\" type=\"text/css\">\n    <link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\">\n\n    <script src=\"js/jquery-1.8.3.min.js\"></script>\n    <script src=\"js/jquery.expander.min.js\"></script>\n    <script src=\"js/jquery.fancybox.pack.js?v=2.1.3\"></script>\n    <script src=\"js/script.js\"></script>"];

    [content setBackgroundColor:[UIColor clearColor]];
    [content setOpaque:NO];
    
    [content loadHTMLString:googlePage baseURL:[NSURL URLWithString:@"http://joyofcoding.org/"]];
    [content setDelegate:self];
    [[content scrollView] setBounces:NO];
    [_activityIndicator startAnimating];
    [self.view addSubview:content];

    
    
	// Do any additional setup after loading the view.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicator removeFromSuperview];

}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
