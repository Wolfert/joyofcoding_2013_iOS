//
//  EventParser.m
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import "EventParser.h"

@implementation EventParser

- (id) init {
    if (self = [super init]) {
        _eventCellArray = [[NSMutableArray alloc] init];
        _eventArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) parse
{
    NSData *jsonData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"program" withExtension:@"json"]];
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    // values in foreach loop
    for (NSDictionary *jsonEvent in [jsonObjects objectForKey:@"events"]) {
        Event * event = [[Event alloc] init];
        event.title = [jsonEvent objectForKey:@"title"];
        event.time = [jsonEvent objectForKey:@"time"];
        event.location = [jsonEvent objectForKey:@"location"];
        event.speaker = [jsonEvent objectForKey:@"speaker"];
        event.contentURL = [jsonEvent objectForKey:@"contentURL"];
        event.color = [[jsonEvent objectForKey:@"color"] integerValue];
        [_eventCellArray addObject: [self createCell:event]];
        [_eventArray addObject: event];        
    }
}


- (ProgramCell*) createCell:(Event*)event {
    ProgramCell * cell = [[ProgramCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProgramCell"];
    if (![_prevTime isEqualToString: event.time])
        cell.time = event.time;
    
    cell.title = event.title;
    cell.speakerText = event.speaker;
    cell.color = event.color;
    _prevTime = event.time;
    
    return cell;
}


@end
