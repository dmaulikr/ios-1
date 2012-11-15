//
//  OHWHistoryViewController.m
//  OhHeyWorld
//
//  Created by Eric Roland on 11/14/12.
//  Copyright (c) 2012 Oh Hey World, Inc. All rights reserved.
//

#import "OHWHistoryViewController.h"
#define appDelegate (OHWAppDelegate *)[[UIApplication sharedApplication] delegate]

@interface OHWHistoryViewController ()

@end

@implementation OHWHistoryViewController
@synthesize userLocations = _userLocations;

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  User *user = [appDelegate user];
  NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
  _userLocations = [user.userUserLocations sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _userLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UserLocation* userLocation = [_userLocations objectAtIndex:indexPath.row];
  Location* location = userLocation.location;
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 240, 35)];
    nameLabel.tag = 1;
    [cell.contentView addSubview:nameLabel];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,33,33)];
    image.tag = 2;
    [cell.contentView addSubview:image];
  }
  
  UILabel *nameLabel = (UILabel*)[cell viewWithTag:1];
  nameLabel.text = [NSString stringWithFormat:@"%@", location.address];
  
  UIImageView *imageView = (UIImageView*)[cell viewWithTag:2];
  imageView.image = [UIImage imageNamed:@"default_location.jpg"];
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UserLocation* userLocation = [_userLocations objectAtIndex:indexPath.row];
  [appDelegate setUserLocation:userLocation];
  OHWCheckedinViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckedinView"];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
