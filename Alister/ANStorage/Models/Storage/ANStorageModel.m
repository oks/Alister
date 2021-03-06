//
//  ANStorageModel.m
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageModel.h"
#import "ANStorageSectionModel.h"

@interface ANStorageModel ()

@property (nonatomic, strong) NSMutableArray<ANStorageSectionModel*>* sectionModels;

@end

@implementation ANStorageModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.sectionModels = [NSMutableArray new];
    }
    return self;
}

- (id)objectAtIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    if (self.sectionModels.count > index)
    {
        ANStorageSectionModel* model = self.sectionModels[section];
        if ([model numberOfObjects] > index)
        {
            return model.objects[index];
        }
    }
    return nil;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath
{
    id object = nil;
    if (indexPath)
    {
        object = [self objectAtIndex:(NSUInteger)indexPath.row inSection:(NSUInteger)indexPath.section];
    }
    else
    {
        NSAssert(NO, @"Somthing wrong, indexpath is nil!!!");
    }
    
    return object;
}

- (NSArray*)itemsInSection:(NSUInteger)section
{
    if (self.sectionModels.count > section)
    {
        ANStorageSectionModel* sectionModel = self.sectionModels[section];
        return sectionModel.objects;
    }
    return nil;
}

- (NSArray*)sections
{
    return [self.sectionModels copy];
}

- (ANStorageSectionModel*)sectionAtIndex:(NSUInteger)index
{
    if (self.sectionModels.count > index)
    {
        return self.sectionModels[index];
    }
    return nil;
}

- (void)addSection:(id)section
{
    [self.sectionModels addObject:section];
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    [self.sectionModels removeObjectAtIndex:index];
}

- (void)removeAllSections
{
    [self.sectionModels removeAllObjects];
}


@end
