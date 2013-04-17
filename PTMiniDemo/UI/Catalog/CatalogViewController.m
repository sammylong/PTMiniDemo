//
//  CatalogViewController.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "CatalogViewController.h"
#import "CatalogViewCell.h"
#import "UIColor+ptmini.h"
#import "LineLayout.h"
#import "Catalog.h"
#import "UIViewController+ALModal.h"
#import "StickerViewController.h"
#import "BubbleViewController.h"

// TODO should not do this in production
typedef enum {
      eCatalogNumbers
    , eCatalogFlags
    , eCatalogCount
} eCatalog;

@interface CatalogViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

static NSString *sCellReuseIdentifier = @"CatalogViewCell";

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoS"]];
    self.navigationItem.titleView = titleView;
    
    LineLayout *lineLayout = (LineLayout *)self.collectionView.collectionViewLayout;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    CGFloat height = CGRectGetHeight(self.collectionView.bounds);
    CGFloat top = 160.0f;
    CGFloat bottom = height - top - lineLayout.itemSize.height;
    CGFloat left = roundf((width - lineLayout.itemSize.width)/2.0f);
    CGFloat right = left;
    // must add this line so that the section remains in one (row)
    lineLayout.sectionInset = UIEdgeInsetsMake(top, left, bottom, right);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[CatalogViewCell class] forCellWithReuseIdentifier:sCellReuseIdentifier];
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Catalog"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:_managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error fetching catalogs %@ - %@", error, error.userInfo);
        self.fetchedResultsController.delegate = nil;
        self.fetchedResultsController = nil;
    }
    return _fetchedResultsController;
}


#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // TODO
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    // TODO
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    // TODO
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
}


#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatalogViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sCellReuseIdentifier forIndexPath:indexPath];
    Catalog *catalog = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.title = catalog.name;
    cell.titleColor = [UIColor piRedColor];
    cell.borderColor = [UIColor piNightBlueColor];
    if (catalog.imageName != nil) {
        cell.image = [UIImage imageNamed:catalog.imageName];
    }
    return cell;
}


#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // open detail view
    Catalog *catalog = [self.fetchedResultsController objectAtIndexPath:indexPath];
    StudyViewController *studyViewController = nil;
    switch (indexPath.row) {
        case eCatalogNumbers: {
            BubbleViewController *bubbleViewController = [[BubbleViewController alloc] initWithCatalog:catalog];
            bubbleViewController.presentOptionsAfterPlayingAudio = YES;
            studyViewController = bubbleViewController;
            break;
        }
        case eCatalogFlags: {
            StickerViewController *stickerViewController = [[StickerViewController alloc] initWithCatalog:catalog];
            stickerViewController.cuedTime = 1.0;
            studyViewController = stickerViewController;
            break;
        }
        default:
            break;
    }
    if (studyViewController) {
        studyViewController.cancelBlock = ^ {
            NSError __autoreleasing *error = nil;
            [self.managedObjectContext save:&error];
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:studyViewController animated:YES completion:nil];
    }
}

@end
