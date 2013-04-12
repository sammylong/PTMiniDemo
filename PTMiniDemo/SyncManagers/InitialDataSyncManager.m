//
//  InitialDataSyncManager.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "InitialDataSyncManager.h"
#import "Catalog.h"
#import "Item.h"

@interface InitialDataSyncManager () {
    BOOL _syncInProgress;
}

@end

@implementation InitialDataSyncManager

- (void)syncInitialData {
    if (_syncInProgress == NO) {
        _syncInProgress = YES;
        NSManagedObjectContext *context = self.managedObjectContext;
        // load definitions from plist
        NSURL *catalogDefinitionsURL = [[NSBundle mainBundle] URLForResource:@"CatalogDefinitions" withExtension:@"plist"];
        NSArray *catalogDefinitions = [[NSArray alloc] initWithContentsOfURL:catalogDefinitionsURL];
        for (NSDictionary *catalogDefinition in catalogDefinitions) {
            NSString *name = [catalogDefinition objectForKey:@"name"];
            // fetch catalog
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Catalog" inManagedObjectContext:context];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            fetchRequest.entity = entityDescription;
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name LIKE %@", name];
            fetchRequest.fetchLimit = 1;
            
            NSError __autoreleasing *error = nil;
            Catalog *catalog = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
            if (error) {
                NSLog(@"Error fetching catalog %@ - %@", error, error.userInfo);
            }
            if (catalog == nil) {
                // no catalog found, create one
                catalog = [[Catalog alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                catalog.name = name;
            }
            NSString *imageName = [catalogDefinition objectForKey:@"imageName"];
            catalog.imageName = imageName;
        }
        
        // fetch catalog: 'Flags'
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Catalog"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name LIKE %@", @"Flags"];
        fetchRequest.fetchLimit = 1;
        NSError __autoreleasing *error = nil;
        Catalog *catalog = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
        
        NSURL *flagDefinitionsURL = [[NSBundle mainBundle] URLForResource:@"FlagDefinitions" withExtension:@"plist"];
        NSArray *flagDefinitions = [[NSArray alloc] initWithContentsOfURL:flagDefinitionsURL];
        for (NSDictionary *flagDefinition in flagDefinitions) {
            NSString *answer = [flagDefinition objectForKey:@"nation"];
            // fetch this item
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            fetchRequest.entity = entityDescription;
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"answer LIKE %@", answer];
            fetchRequest.fetchLimit = 1;
            NSError __autoreleasing *error = nil;
            Item *item = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
            if (error) {
                NSLog(@"Error fetching item %@ - %@", error, error.userInfo);
            }
            if (item == nil) {
                // no item found, create one
                item = [[Item alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
                item.answer = answer;
            }
            NSString *imageName = [flagDefinition objectForKey:@"imageName"];
            item.imageName = imageName;
            NSString *continent = [flagDefinition objectForKey:@"continent"];
            NSString *detail = [NSString stringWithFormat:@"%@ is in %@", answer, continent];
            item.detail = detail;
            item.lastStudiedDate = [NSDate dateWithTimeIntervalSince1970:0.0];
            item.catalog = catalog;
        }
        
        // save
        error = nil;
        [context save:&error];
        _syncInProgress = NO;
    }
}

@end
