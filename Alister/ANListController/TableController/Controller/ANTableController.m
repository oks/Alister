//
//  ANTableViewController.m
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANTableController.h"
#import "ANStorageMovedIndexPathModel.h"
#import "ANStorageUpdateModel.h"
#import "ANStorageSectionModelInterface.h"
#import "ANTableControllerManager.h"
#import "ANStorageUpdatingInterface.h"
#import "ANStorage.h"
#import "ANListControllerSearchManager.h"
#import "ANListControllerTableViewWrapper.h"
#import "ANListController+Interitance.h"

@interface ANTableController () <ANTableControllerManagerDelegate, ANListControllerTableViewWrapperDelegate>

@property (nonatomic, strong) id<ANListControllerWrapperInterface> listViewWrapper;

@end

@implementation ANTableController

+ (instancetype)controllerWithTableView:(UITableView*)tableView
{
    return [[self alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self)
    {
        self.tableView = tableView;
        self.listViewWrapper = [ANListControllerTableViewWrapper wrapperWithDelegate:self];
        
        ANTableControllerManager* manager = [ANTableControllerManager new];
        manager.delegate = self;
        manager.configurationModel.defaultFooterSupplementary = @"ANTableViewElementSectionFooter";
        manager.configurationModel.defaultHeaderSupplementary = @"ANTableViewElementSectionHeader";
        manager.configurationModel.reloadAnimationKey = @"UITableViewReloadDataAnimationKey";
        self.manager = manager;
    }
    return self;
}

- (ANTableControllerManager*)tableManager
{
    return self.manager;
}

- (void)setTableView:(UITableView*)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
}

- (void)dealloc
{
    UITableView* tableView = self.tableView;
    tableView.delegate = nil;
    tableView.dataSource = nil;
    self.tableView = nil;
    self.storage.listController = nil;
    self.storage = nil;
}


#pragma mark - Supplementaries

- (NSString*)tableView:(__unused UITableView*)tableView titleForHeaderInSection:(NSInteger)sectionNumber
{
    return [self.tableManager titleForSupplementaryIndex:(NSUInteger)sectionNumber
                                                    type:ANTableViewSupplementaryTypeHeader];
}

- (NSString*)tableView:(__unused UITableView*)tableView titleForFooterInSection:(NSInteger)sectionNumber
{
    return [self.tableManager titleForSupplementaryIndex:(NSUInteger)sectionNumber
                                                    type:ANTableViewSupplementaryTypeFooter];
}

- (UIView*)tableView:(__unused UITableView*)tableView viewForHeaderInSection:(NSInteger)sectionNumber
{
    return [self.tableManager supplementaryViewForIndex:(NSUInteger)sectionNumber
                                                   type:ANTableViewSupplementaryTypeHeader];
}

- (UIView*)tableView:(__unused UITableView*)tableView viewForFooterInSection:(NSInteger)sectionNumber
{
    return [self.tableManager supplementaryViewForIndex:(NSUInteger)sectionNumber
                                                   type:ANTableViewSupplementaryTypeFooter];
}

- (CGFloat)tableView:(__unused UITableView*)tableView heightForHeaderInSection:(NSInteger)sectionNumber
{
    return [self.tableManager heightForSupplementaryIndex:(NSUInteger)sectionNumber
                                                     type:ANTableViewSupplementaryTypeHeader];
}

- (CGFloat)tableView:(__unused UITableView*)tableView heightForFooterInSection:(NSInteger)sectionNumber
{
    return [self.tableManager heightForSupplementaryIndex:(NSUInteger)sectionNumber
                                                     type:ANTableViewSupplementaryTypeFooter];
}


#pragma mark - UITableView Protocols Implementation

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView*)tableView
{
    return (NSInteger)[self.currentStorage sections].count;
}

- (NSInteger)tableView:(__unused UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id <ANStorageSectionModelInterface> sectionModel = [self.currentStorage sectionAtIndex:(NSUInteger)section];
    return (NSInteger)[sectionModel numberOfObjects];
}

- (UITableViewCell*)tableView:(__unused UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id model = [self.currentStorage objectAtIndexPath:indexPath];;
    return [self.tableManager cellForModel:model atIndexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectionBlock)
    {
        id model = [self.currentStorage objectAtIndexPath:indexPath];
        self.selectionBlock(model, indexPath);
    }
}

@end
