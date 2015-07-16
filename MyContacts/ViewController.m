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

@end

@implementation ViewController

NSMutableArray *allContactsAsStrings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    //ABRecordRef person;
    NSString *personAsString;
    

    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    allContactsAsStrings = [[NSMutableArray alloc] init];
    for (int i = 0; i < [allContacts count]; i++){
        
        //person = (__bridge ABRecordRef)allContacts[i];
        //personAsString = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        //[personAsString stringByAppendingString:(__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty)];
        //[allContactsAsStrings addObject:personAsString];
        
        //[allContactsAsStrings addObject:(__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)allContacts[i], kABPersonFirstNameProperty)];
        
        
       
        personAsString = (__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)allContacts[i], kABPersonFirstNameProperty);
        [personAsString stringByAppendingFormat:@" %@", (__bridge_transfer NSString *)ABRecordCopyValue((__bridge ABRecordRef)allContacts[i], kABPersonLastNameProperty)];
        [allContactsAsStrings addObject:personAsString];
        
        
        
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allContactsAsStrings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [allContactsAsStrings objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


