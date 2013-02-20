//
//  ProgramCell.h
//  Joy of Coding
//
//  Created by wolfert on 2/9/13.
//
//

#import <UIKit/UIKit.h>
#import "MultiLineAutoSize.h"

@interface ProgramCell : UITableViewCell {
    UILabel * titleLabel;
    UILabel * timeLabel;
    UILabel * speakersLabel;
    BOOL _isSmallCell;
    CGRect _orginalFrame;
}

@property(nonatomic, retain) NSString * time;
@property(nonatomic, retain) NSString * title;
@property(nonatomic, retain) NSString * speakerText;
@property(nonatomic) int color;
@property(nonatomic) int height;

@end
