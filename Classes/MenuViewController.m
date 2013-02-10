//
//  MenuViewController.m
//  CheckIn
//
//  Created by wolfert on 10/30/12.
//
//

#import "MenuViewController.h"

#define kInputStateUser 1
#define kInputStateMode 2
#define kInputStateModeManual 3

@interface MenuViewController () {
}

@property (nonatomic, strong) UITextField * userInputField;
@property (nonatomic, strong) NSString * user;
@property (nonatomic, strong) UITableViewCell * activeCheckInMode;
@property (nonatomic) int state;

- (BOOL) saveUser:(NSString*)user;
- (BOOL) isValidEmail: (NSString*) email;
@end


@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    _user = [[NSUserDefaults standardUserDefaults] stringForKey: @"email_preferences"];
    
    UIImage * navBarImage = [UIImage imageNamed:@"navy_blue_navbar.png"];
    UIImage * bgImage = [UIImage imageNamed:@"bgnoise.png"];
    [[[self navigationController] navigationBar] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:bgImage]];
    
    self.tableView.tableHeaderView = [[TableViewHeader alloc] initWithFrame:CGRectMake(0, 20, 320, 150)];
    self.tableView.tableFooterView = [[TableViewFooter alloc] initWithFrame:CGRectMake(0, 20, 320, 100)];

    EventParser * ep = [[EventParser alloc] init];
    [ep parse];
    _events = ep.eventArray;
    _eventCells = ep.eventCellArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? [_eventCells count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"inputCell"];
        _userInputField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 280, 24)];
        _userInputField.placeholder = @"Your twitter handle";
        _userInputField.delegate = self;
        _userInputField.autocorrectionType = UITextAutocorrectionTypeNo;
        _userInputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userInputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userInputField.returnKeyType = UIReturnKeyDone;
        _userInputField.text = _user;
        _userInputField.textColor = kTableViewCellTextColor;
        _userInputField.font = kTableViewCellFontArvoSmall;
        _userInputField.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [cell.contentView addSubview:_userInputField];
        cell.textLabel.textColor = kTableViewCellTextColor;
        cell.textLabel.font = kTableViewCellFont;
        cell.selectionStyle = kTableViewCellSelectionStyle;
    } else {
        return [_eventCells objectAtIndex:indexPath.row];
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? @"Program" : @"Geofence check in";
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, tableView.bounds.size.width - 10, 18)];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = kTableViewHeaderTextColor;
    label.font = kTableViewHeaderFont;
    label.shadowOffset = CGSizeMake(0, 1);
    label.shadowColor = [UIColor lightGrayColor];
    [headerView addSubview:label];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section ? ((ProgramCell*)[_eventCells objectAtIndex:indexPath.row]).hoogte : 44;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
//        EventDetailViewController * detailView = [[EventDetailViewController alloc]init];
//        [self.navigationController pushViewController:detailView animated:YES];
//        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle bundleForClass:[self class]]];
        EventDetailViewController * detailView = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        detailView.event = [_events objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailView animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Keyboard delegat

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_userInputField resignFirstResponder];
    
    _user = _userInputField.text;
    if (![self saveUser:_user])
        return false;

    return YES;
}

- (BOOL) saveUser:(NSString*)user
{
    if (!user || [user isEqualToString:@""]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email_preferences"]) {
            _userInputField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email_preferences"];
            return YES;
        }
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email_preferences"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"email_preferences"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        // Restart because we want to checkin or checkout the new user
        [[Geofencer sharedFencer] stopMonitoring];
        [[Geofencer sharedFencer] startMonitoring];
        
        return YES;
    }
}

- (BOOL) isValidEmail: (NSString*) email
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
    return [predicate evaluateWithObject: email];
}

@end