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

@property (strong, nonatomic) NSMutableArray *allContactsAsStrings;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    //ABRecordRef person;
    NSString *personAsString;
    self.allContactsAsStrings = [[NSMutableArray alloc] init];

    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for (int i = 0; i < [allContacts count]; i++){
        
        //person = (__bridge ABRecordRef)allContacts[i];
        //personAsString = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        //[personAsString stringByAppendingString:(__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty)];
        //[allContactsAsStrings addObject:personAsString];
        
        //[allContactsAsStrings addObject:(__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)allContacts[i], kABPersonFirstNameProperty)];
        
        
       
        personAsString = (__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)allContacts[i], kABPersonFirstNameProperty);
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)allContacts[i], kABPersonLastNameProperty);
        
        personAsString = [personAsString stringByAppendingFormat:@" %@", lastName];
        [self.allContactsAsStrings addObject:personAsString];
        
        
        
    }
    
    
    
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


