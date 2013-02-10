//
//  ProgramCell.m
//  Joy of Coding
//
//  Created by wolfert on 2/9/13.
//
//

#import "ProgramCell.h"

@implementation ProgramCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float width = self.contentView.frame.size.width;
        float height = self.contentView.frame.size.height;
        float contentWidth = 200;
        float contentOffsetX = (width-contentWidth)/2;
        float contentHeight = 20;
        
        float contentOffsetY = 11;//(height-contentHeight)/2;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentOffsetX, contentOffsetY, contentWidth+50, contentHeight*2)];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
//        titleLabel.textAlignment =  UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = kTableViewCellTextColor;
        titleLabel.font = kTableViewCellFont;
        titleLabel.numberOfLines = 2;
        titleLabel.highlightedTextColor = [UIColor whiteColor];
        
//        titleLabel.minimumFontSize = 14;
//        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.lineBreakMode = UILineBreakModeClip;
        [self.contentView addSubview:titleLabel];

//        UIImageView *clock = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock.png"] highlightedImage:[UIImage imageNamed:@"clock_inv.png"]];
//        [clock setFrame:CGRectMake(5, contentOffsetY, 16, 16)];
//        clock.contentMode = UIViewContentModeScaleAspectFit;
//        clock.alpha = 0.5;
//        [self.contentView addSubview:clock];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, contentOffsetY, 50, contentHeight)];
        timeLabel.textAlignment =  UITextAlignmentRight;
        timeLabel.textColor = kTableViewCellTextColor;
        timeLabel.font = kTableViewCellFontSmall;
        timeLabel.alpha = .5;
        timeLabel.highlightedTextColor = [UIColor whiteColor];

        timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:timeLabel];
        
        speakersLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentOffsetX, contentOffsetY*2+contentHeight+10, contentWidth+50, contentHeight*2)];
        speakersLabel.textColor = kTableViewCellTextColor;
        speakersLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        speakersLabel.font = [UIFont fontWithName:@"Arvo" size:12];
        speakersLabel.alpha = 0.5;
        speakersLabel.backgroundColor = [UIColor clearColor];
        speakersLabel.numberOfLines = 2;
        speakersLabel.highlightedTextColor = [UIColor whiteColor];
        speakersLabel.lineBreakMode = UILineBreakModeClip;
        
        [self.contentView addSubview:speakersLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setTime:(NSString *)time {
    _time = time;
    timeLabel.text = time;
}
-(void)setTitle:(NSString *)title {
    _title = title;
    titleLabel.text = title;
    titleLabel.text = [titleLabel.text stringByAppendingString:@"\n\n\n"];
//    [titleLabel adjustFontSizeToFit];
    
}
-(void)setSpeakerText:(NSString *)speakerText {
    _speakerText = speakerText;
    speakersLabel.text = speakerText;
    speakersLabel.text = [speakersLabel.text stringByAppendingString:@"\n\n\n"];
    NSLog(@"%d: %@", [speakerText length], speakerText);

//        [titleLabel adjustFontSizeToFit];
}

- (void)setColor:(int)color {
    _color = color;
    switch (color) {
        case 1: //mainstage
            self.backgroundColor = [UIColor colorWithRed:174/255.0 green:94/255.0 blue:114/255.0 alpha:.1];
            self.selectionStyle = kTableViewCellSelectionStyle;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _hoogte = 88;
        break; //wing
        case 2:
            self.backgroundColor = [UIColor colorWithRed:98/255.0 green:135/255.0 blue:159/255.0 alpha:.1];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.selectionStyle = kTableViewCellSelectionStyle;
            _hoogte = 90;
            break;
        case 0: //general
            self.backgroundColor = [UIColor colorWithRed:156/255.0 green:169/255.0 blue:88/255.0 alpha:.1];
            self.selectionStyle = kTableViewCellSelectionStyle;
            self.userInteractionEnabled = NO;
            _hoogte = 44;
            break;
        default:
            self.selectionStyle = UITableViewCellAccessoryNone;
            _hoogte = 44;
            break;
    }
}

- (int)hoogte {
    if (_title.length < 25 && _color != 0 && _speakerText.length < 36) {

        float width = self.contentView.frame.size.width;
        float height = self.contentView.frame.size.height;
        float contentWidth = 200;
        float contentOffsetX = (width-contentWidth)/2;
        float contentHeight = 20;
        
        float contentOffsetY = 11;
        speakersLabel.frame = CGRectMake(contentOffsetX, contentOffsetY*2+contentHeight-10, contentWidth+50, contentHeight*2);
                return 60;
    }
    return _hoogte;
}

@end
