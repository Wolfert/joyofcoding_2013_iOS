//
//  JOYNavBar.m
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import "JOYNavBar.h"

//Override For Custom Navigation Bar
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"titleBar.png"];
    [image drawInRect:CGRectMake(0, 0, 320, 44)];
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    [self applyDefaultStyle];
}

- (void)applyDefaultStyle {
    // add the drop shadow
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 3);
    self.layer.shadowOpacity = 0.25;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
}

@end