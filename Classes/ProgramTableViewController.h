//
//  ProgramTableViewController.h
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

@interface ProgramTableViewController : UITableViewController <UITextFieldDelegate> {
    NSArray * _events;
    NSArray * _eventCells;
}

- (BOOL) saveUser:(NSString*)user;
- (BOOL) isValidTwitterHandle: (NSString*) handle;
- (void) openWebLocation;


@property (nonatomic, strong) UITextField * userInputField;
@property (nonatomic, strong) NSString * user;
@property (nonatomic, strong) UITableViewCell * activeCheckInMode;

@end
