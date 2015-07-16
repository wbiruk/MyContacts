//
//  ViewController.m
//  MyContacts
//
//  Created by Wiktor Biruk on 16/07/15.
//  Copyright (c) 2015 Wiktor Biruk. All rights reserved.
//

#import "ViewController.h"
@import AddressBook;

@interface ViewController ()

@property (nonatomic) ABAddressBookRef addressBook;
@property (strong, nonatomic) NSArray *allContacts;
@property (strong, nonatomic) NSMutableArray *allContactsAsStrings;
@property (strong, nonatomic) NSString *personAsString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    self.allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(self.addressBook);
    
    self.allContactsAsStrings = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.allContacts count]; i++){
        
        // get first name and last name
        self.personAsString = (__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)self.allContacts[i], kABPersonFirstNameProperty);
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)self.allContacts[i], kABPersonLastNameProperty);
        
        // append last name to first name and this string to array
        self.personAsString = [self.personAsString stringByAppendingFormat:@" %@", lastName];
        [self.allContactsAsStrings addObject:self.personAsString];
    }
    
}

- (IBAction)buttonSortTapped:(UIButton *)sender {
    // sort alphabetically
    [self.allContactsAsStrings sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allContactsAsStrings count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.allContactsAsStrings objectAtIndex:indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


