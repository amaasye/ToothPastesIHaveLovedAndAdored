//
//  ViewController.m
//  ToothPastesIHaveLovedAndAdored
//
//  Created by Syed Amaanullah on 1/22/15.
//  Copyright (c) 2015 Syed Amaanullah. All rights reserved.
//

#import "AdoredToothPastesViewController.h"
#import "ToothPastesTableViewController.h"

#define kNSUserDefaultsLastSavedKey @"Last Saved Key"

@interface AdoredToothPastesViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *adoredToothPastes;
@property (weak, nonatomic) IBOutlet UITableView *toothPastesTableView;
@end

@implementation AdoredToothPastesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
    if (self.adoredToothPastes == nil) {
    self.adoredToothPastes = [NSMutableArray new];}
}

-(NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}


-(void)load {
    NSURL *plist = [[self documentsDirectory] URLByAppendingPathComponent:@"pastes.plist"];
    self.adoredToothPastes = [NSMutableArray arrayWithContentsOfURL:plist];
}

-(void)save {
    NSURL *plist = [[self documentsDirectory] URLByAppendingPathComponent:@"pastes.plist"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [self.adoredToothPastes writeToURL:plist atomically:YES];
    NSLog(@"%@", plist);

    [userDefaults setObject:[NSDate date] forKey:kNSUserDefaultsLastSavedKey];
    [userDefaults synchronize];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adoredToothPastes.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.adoredToothPastes objectAtIndex:indexPath.row];
    return cell;
}

-(IBAction)unwindFromToothPasteViewController:(UIStoryboardSegue *)segue {
    ToothPastesTableViewController *viewController = segue.sourceViewController;
    [self.adoredToothPastes addObject:[viewController adoredToothpaste]];
    [self save];
    [self.toothPastesTableView reloadData];
}

@end
