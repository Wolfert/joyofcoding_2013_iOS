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
        UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-lunatech.png"]];
        logo.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-30);
        logo.contentMode = UIViewContentModeCenter;
        logo.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:logo];
        
        UILabel * by = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20)];
        by.textAlignment = UITextAlignmentCenter;
        by.text = @"Brought to you by:";
        by.backgroundColor = [UIColor clearColor];
        by.textColor = kTableViewCellTextColor;
        by.font = kTableViewCellFontArvoExtraSmall;
        by.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:by];


    }
    return self;
}

@end
