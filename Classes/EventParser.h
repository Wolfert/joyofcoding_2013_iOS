//
//  EventParser.h
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "ProgramCell.h"

@interface EventParser : NSObject {
    NSString * _prevTime;
}

@property(nonatomic, retain) NSMutableArray * eventArray;
@property(nonatomic, retain) NSMutableArray * eventCellArray;

- (void) parse;
- (ProgramCell*) createCell:(Event*)event;

@end
