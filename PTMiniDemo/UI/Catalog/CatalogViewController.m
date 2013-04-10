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

@interface CatalogViewController ()

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
    [self.collectionView registerClass:[CatalogViewCell class] forCellWithReuseIdentifier:sCellReuseIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatalogViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.title = @"數字篇";
        cell.titleColor = [UIColor piRedColor];
        cell.borderColor = [UIColor piGreenColor];
        
    } else if (indexPath.row == 1) {
        cell.title = @"國旗篇";
        cell.titleColor = [UIColor piNightBlueColor];
        cell.borderColor = [UIColor piLightBlueColor];
    }
    return cell;
}

@end
