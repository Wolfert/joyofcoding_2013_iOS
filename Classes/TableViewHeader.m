//
//  TableViewHeader.m
//  CheckIn
//
//  Created by wolfert on 11/1/12.
//
//

#import "TableViewHeader.h"

@implementation TableViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        logo.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-30);
        logo.contentMode = UIViewContentModeScaleAspectFit;
        logo.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:logo];
    }
    return self;
}

@end
