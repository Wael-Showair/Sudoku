//
//  SudokuTests.m
//  SudokuTests
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SudokuCell.h"

@interface SudokuCellTests : XCTestCase

@end

@implementation SudokuCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitSudokuCell {
  SudokuCell* cell = [[SudokuCell alloc] init];
  XCTAssertNotNil(cell);
  XCTAssertEqual(0, cell.value);
  XCTAssertTrue(NSEqualRanges(cell.range, NSMakeRange(1, 9)));
  XCTAssertTrue([cell.potentialSolutionSet containsIndexesInRange:NSMakeRange(1, 9)]);
}

- (void)testInitSudokuCellWithValue {
  SudokuCell* cell = [[SudokuCell alloc] initWithValue:5];
  XCTAssertNotNil(cell);
  XCTAssertEqual(5, cell.value);
  XCTAssertTrue(NSEqualRanges(cell.range, NSMakeRange(1, 9)));
  XCTAssertNil(cell.potentialSolutionSet);
}

- (void)testInitSudokuCellWithInvalidValue {
  SudokuCell* cell = [[SudokuCell alloc] initWithValue:33];
  XCTAssertNotNil(cell);
  XCTAssertEqual(0, cell.value);
  XCTAssertTrue(NSEqualRanges(cell.range, NSMakeRange(1, 9)));
  XCTAssertTrue([cell.potentialSolutionSet containsIndexesInRange:NSMakeRange(1, 9)]);

}

- (void)testEliminateNumberFromSolutionSet {
  SudokuCell* cell = [[SudokuCell alloc] init];
  [cell eliminateNumberFromSolutionSet:6];
  XCTAssertFalse([cell.potentialSolutionSet containsIndex:6]);
}

- (void)testEliminateInvalidNumFromSolutionSet {
  SudokuCell* cell = [[SudokuCell alloc] init];
  [cell eliminateNumberFromSolutionSet:46];
  XCTAssertTrue([cell.potentialSolutionSet containsIndexesInRange:NSMakeRange(1, 9)]);
}

- (void)testcompareToSudokuCellSuccess {
  SudokuCell* cell1 = [[SudokuCell alloc] initWithValue:7];
  SudokuCell* cell2 = [[SudokuCell alloc] initWithValue:7];
  
  XCTAssertTrue([cell1 isEqualToSudokuCell:cell2]);
}

- (void)testcompareToSudokuCellFail {
  SudokuCell* cell1 = [[SudokuCell alloc] initWithValue:7];
  SudokuCell* cell2 = [[SudokuCell alloc] initWithValue:9];
  
  XCTAssertFalse([cell1 isEqualToSudokuCell:cell2]);
}

- (void)testcompareToSudokuCellNil {
  SudokuCell* cell1 = [[SudokuCell alloc] initWithValue:7];
  
  XCTAssertFalse([cell1 isEqualToSudokuCell:nil]);
}


@end
