//
//  MenuViewController.h
//  CheckIn
//
//  Created by wolfert on 10/30/12.
//
//

#import <UIKit/UIKit.h>
#import "TableViewHeader.h"
#import "TableViewFooter.h"
#import "ProgramCell.h"
#import "EventParser.h"
#import "EventDetailViewController.h"

@interface MenuViewController : UITableViewController <UITextFieldDelegate> {
    NSArray * _events;
    NSArray * _eventCells;
    NSString * _prevTime;
}

@end
