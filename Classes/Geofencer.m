//
//  Geofencer.m
//  CheckIn
//
//  Created by wolfert on 10/19/12.
//
//

#import "Geofencer.h"

@implementation Geofencer

+ (id) sharedFencer
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id) init
{
    NSLog(@" - Geofencer init " );
    if (self) {
        _regionManager = [[CLLocationManager alloc] init];

        _regionManager.delegate = self;
        _isMonitoring = false;
        _isCheckIn = -1;
    }
    return self;
}

- (NSMutableArray*) locations
{
    if (!_locations)
        _locations = [[NSMutableArray alloc] initWithObjects:
                          [[Location alloc] initWithIdentifier:@"Joy of Coding" longitude:4.494342 latitude:51.897648 andRadius:100.0], nil];
    return _locations;
}

#pragma mark -
#pragma mark locationManager delegation

- (void) startMonitoring
{
    if (!_isMonitoring) {
        NSLog(@" - Starting Region Monitoring ");
        for (int i = 0; i < [self.locations count]; i++) {
            [_regionManager startMonitoringForRegion:[[self.locations objectAtIndex:i] region]];
            [_regionManager setDesiredAccuracy:kCLLocationAccuracyBest];
        }
        [_regionManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _isMonitoring = YES;
    }
}

- (void) stopMonitoring
{
    if (_isMonitoring) {
        if (_isCheckIn == 1) {
            [self exitedRegion:0];
        }
        NSLog(@" - Stopping Region Monitoring ");
        for (int i = 0; i < [_locations count]; i++) {
            [_regionManager stopMonitoringForRegion:[[self.locations objectAtIndex:i] region]];
        }
        _isMonitoring = NO;
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@" - Entered Region");
    NSLog(@" - Entered Region %@ \n Location %.06f %.06f",[region description], _regionManager.location.coordinate.latitude,_regionManager.location.coordinate.longitude );
    
    [self enteredRegion:0];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@" - Exited Region viewController.status.text");
    NSLog(@" - Exited Region %@ \n Location %.06f %.06f",[region description], _regionManager.location.coordinate.latitude,_regionManager.location.coordinate.longitude );
    
    [self exitedRegion:0];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@" - Region Monitoring Started\n%@ \n Location %.06f %.06f",[region description], _regionManager.location.coordinate.latitude,_regionManager.location.coordinate.longitude );
    
    if ([region containsCoordinate:_regionManager.location.coordinate]) {
        NSLog(@" - Region Monitored Entered Region");
        [self enteredRegion:0];
    } else {
        NSLog(@" - Region Monitored Exited Region");
        [self exitedRegion:0];
    }
}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@" - LocationManager didFailWithError: %@", [error localizedDescription]);
}


#pragma mark -
#pragma mark Region code

- (void) enteredRegion:(int)regionIndex
{
    
    NSString *username =  [[NSUserDefaults standardUserDefaults] stringForKey: @"email_preferences"];
    if (!username || [username isEqualToString:@""])
        return;
    
    
    
    NSURL *url = [ NSURL URLWithString:kNetworkCheckInURL([username stringByReplacingOccurrencesOfString:@"@" withString:@""])];
    
    NSURLRequest *request = [ NSURLRequest requestWithURL: url ];
    if (_isCheckIn != 1) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[Notifier sharedNotifier] notifyMessage:[NSString stringWithFormat:@"You just entered %@", [[self.locations objectAtIndex:regionIndex] identifier]]];
        
        // create the connection with the request
        // and start loading the data
        NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (theConnection) {
            // Create the NSMutableData to hold the received data.
            // receivedData is an instance variable declared elsewhere.
            [theConnection start];	
        } else {
            // Inform the user that the connection failed.
            [[Notifier sharedNotifier] notifyMessage:[NSString stringWithFormat:@"Connection to server failed!"]];
        }
        _isCheckIn = 1;
    }
}

- (void) exitedRegion:(int)regionIndex
{
    NSString *username =  [[NSUserDefaults standardUserDefaults] stringForKey: @"email_preferences"];
    if (!username || [username isEqualToString:@""])
        return;
    

    NSURL *url = [ NSURL URLWithString:kNetworkCheckOutURL([username stringByReplacingOccurrencesOfString:@"@" withString:@""])];
    
    NSURLRequest *request = [ NSURLRequest requestWithURL: url ];
    
    if (_isCheckIn != 0) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[Notifier sharedNotifier] notifyMessage:[NSString stringWithFormat:@"You just left %@", [[self.locations objectAtIndex:regionIndex] identifier]]];
        
        // create the connection with the request
        // and start loading the data
        NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (theConnection) {
            // Create the NSMutableData to hold the received data.
            // receivedData is an instance variable declared elsewhere.
            [theConnection start];
        } else {
            // Inform the user that the connection failed.
            [[Notifier sharedNotifier] notifyMessage:[NSString stringWithFormat:@"Connection to server failed!"]];

        }
        _isCheckIn = 0;
    }
}


@end