//
//  TableViewFooter.m
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import "TableViewFooter.h"

@implementation TableViewFooter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"logo-lunatech.png"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-30)];
        [button addTarget:self action:@selector(openWebLocation) forControlEvents:UIControlEventTouchUpInside];
        button.contentMode = UIViewContentModeCenter;
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [self addSubview:button];
        
        UILabel * by = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20)];
        by.textAlignment = UITextAlignmentCenter;
        by.text = @"This app is brought to you by:";
        by.backgroundColor = [UIColor clearColor];
        by.textColor = kTableViewCellTextColor;
        by.font = kTableViewCellFontArvoExtraSmall;
        by.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:by];


    }
    return self;
}

- (void) openWebLocation {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://lunatech.com"]];
}

@end
