//
//  ANStorageSectionModelTest.m
//  Alister
//
//  Created by Oksana on 7/5/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorageSectionModel.h"

@interface ANStorageSectionModelTest : XCTestCase

@property (nonatomic, strong) ANStorageSectionModel* model;
@property (nonatomic, strong) NSString* fixtureObject;
@property (nonatomic, assign) NSInteger fixtureIndex;

@end

@implementation ANStorageSectionModelTest

- (void)setUp
{
    [super setUp];
    self.model = [ANStorageSectionModel new];
    self.fixtureIndex = 0;
    self.fixtureObject = @"test";
}

- (void)tearDown
{
    self.model = nil;
    self.fixtureObject = nil;
    [super tearDown];
}

- (void)test_conformsProtocol_positive
{
    expect(self.model).conformTo(@protocol(ANStorageSectionModelInterface));
}

- (void)test_addItem_positive_whenValid
{
    //when
    [self.model addItem:self.fixtureObject];
    
    //then
    expect(self.model.objects[0]).equal(self.fixtureObject);
}

- (void)test_addItem_positive_itemAddsOnlyOnce
{
    //when
    [self.model addItem:self.fixtureObject];
    
    //then
    expect(self.model.objects).haveCount(1);
}

- (void)test_addItem_negative_addNilNotThrowException
{
    self.fixtureObject = nil;
    //then
    expect(^{
        //when
        [self.model addItem:self.fixtureObject];
    }).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_positive_whenValidData
{
    //when
    [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects[self.fixtureIndex]).equal(self.fixtureObject);
    expect(^{
        [self.model.objects objectAtIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_positive_addsOnlyOnce
{
    //when
    [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects).haveCount(1);
}

- (void)test_insertItemAtIndex_negative_whenIndexOutOfRangeNoExpection
{
    self.fixtureIndex = NSUIntegerMax;
    //then
    expect(^{
        [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_insertItemAtIndex_negative_whenItemIsNilNoExpection
{
    self.fixtureObject = nil;
    //then
    expect(^{
        [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    }).notTo.raiseAny();
}

- (void)test_removeItemAtIndex_positive_indexValid
{
    //given
    [self.model insertItem:self.fixtureObject atIndex:self.fixtureIndex];
    
    //when
    [self.model removeItemAtIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects).haveCount(0);
}

- (void)test_removeItemAtIndex_negative_indexInvalid
{
    //when
    [self.model removeItemAtIndex:self.fixtureIndex];
    
    //then
    expect(self.model.objects).haveCount(0);
}

- (void)test_replaceItemAtIndexWithItem_positive_objectAndIndexValid
{
    
}




- (void)testNumberOfObjects
{
	
}

- (void)testObjects
{
	
}

- (void)testSupplementaryModelOfKind
{
	
}

- (void)updateSupplementaryModel:(id)model forKind:(NSString*)kind
{
	
}

@end
