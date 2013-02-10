//
//  AppConfig.h
//  CheckIn
//
//  Created by wolfert on 10/29/12.
//
//

#define kNotificationSoundDefault @"sound.caf"

#define kRegionLunatechOffice [[CLRegion alloc] initCircularRegionWithCenter:CLLocationCoordinate2DMake(51.919606, 4.456255) radius:30.0 identifier:@"Lunatech Labs"]
#define kRegionJoyOfCoding [[CLRegion alloc] initCircularRegionWithCenter:CLLocationCoordinate2DMake(51.897648, 4.494342) radius:50.0 identifier:@"Joy of Coding"]




#define kNetworkCheckInURL(username) [NSString stringWithFormat: @"http://joyofcoding.lunatech.com/checkin/%@", username]
#define kNetworkCheckOutURL(username) [NSString stringWithFormat: @"http://joyofcoding.lunatech.com/checkout/%@", username]

#define kTableViewCellFont [UIFont fontWithName:@"Monda" size:18.0]
#define kTableViewCellFontSmall [UIFont fontWithName:@"Monda" size:14.0]
#define kTableViewCellFontArvoSmall [UIFont fontWithName:@"Arvo" size:16.0]
#define kTableViewCellFontArvoExtraSmall [UIFont fontWithName:@"Arvo" size:12.0]

#define kTableViewCellTextColor [UIColor darkGrayColor]
#define kTableViewCellSelectionStyle UITableViewCellSelectionStyleGray

#define kTableViewHeaderFont [UIFont fontWithName:@"Monda-Bold" size:17.0]
#define kTableViewHeaderTextColor UIColorFromRGB(0x333333)

// Creates a UIColor from a hexcolor. param : 0x0000000
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]