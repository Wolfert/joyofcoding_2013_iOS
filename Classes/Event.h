//
//  Event.h
//  Joy of Coding
//
//  Created by wolfert on 2/10/13.
//
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property(nonatomic, retain) NSString * time;
@property(nonatomic, retain) NSString * title;
@property(nonatomic, retain) NSString * speaker;
@property(nonatomic, retain) NSString * location;
@property(nonatomic, retain) NSString * contentURL;
@property(nonatomic) int color;


@end
