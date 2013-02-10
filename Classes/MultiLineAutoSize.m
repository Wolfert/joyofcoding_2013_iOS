//
//  MultiLineAutoSize.m
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import "MultiLineAutoSize.h"

@implementation UILabel (MultiLineAutoSize)

- (void)adjustFontSizeToFit
{
    UIFont *font = self.font;
    CGSize size = self.frame.size;
    
    for (CGFloat maxSize = self.font.pointSize; maxSize >= self.minimumFontSize; maxSize -= 1.f)
    {
        font = [font fontWithSize:maxSize];
        CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
        CGSize labelSize = [self.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        if(labelSize.height <= size.height)
        {
            self.font = font;
            [self setNeedsLayout];
            break;
        }
    }
    // set the font to the minimum size anyway
    self.font = font;
    [self setNeedsLayout];
}

@end