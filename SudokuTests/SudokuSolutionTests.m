//
//  ConstraintPropagationTests.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-13.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MicroGrid.h"
#import "SudokuSolution.h"

@interface SudokuSolutionTests : XCTestCase <SudokuSolutionDelegate>
@property(strong, nonatomic) MacroGrid* grid;
@property(strong,nonatomic) SudokuSolution* solution;
@property XCTestExpectation* expectation;
@property NSUInteger expectedValue;
@end

@implementation SudokuSolutionTests

-(void)didFailToInsertValueOfSudokuCell:(SudokuCell *)cell{
  [self.expectation fulfill];
  
  XCTAssertNotNil(cell);
  XCTAssertEqual(self.expectedValue, cell.value);
}

-(void)didFinishUpdateValueOfSudokuCell:(SudokuCell *)cell{
  [self.expectation fulfill];
  
  XCTAssertNotNil(cell);
  XCTAssertEqual(self.expectedValue, cell.value);
}

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  
  /* Since the launces before running the test, and it already must have initialize the MacroGrid which
   * in turn calls intialize micro grid 9 times. Hence the starting value of the cells accumulate
   * over the previous value (which is multiples of 81). So need to reset the static counter
   * in the micro grid such that any test starts running after the the app launch still starts
   * from 1.
   */
  [MicroGrid resetCount];
  
  self.grid = [[MacroGrid alloc] init];
  self.solution = [[SudokuSolution alloc] init];
  self.solution.delegate = self;
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testUpdateSudokuCellInMacroGridWithValueValid{
  self.expectation = [self expectationWithDescription:@"update cell"];
  
  /* Get Sudoku cell at row 7, column 7 whose value = 73 */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(6, 6)];
  self.expectedValue = 8;
  [self.solution updateSudokuCell:cell inMacroGrid:self.grid withValue:8];

  [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

-(void) testUpdateTwoSudokuCellsInSameRowFail{
  
  self.expectation = [self expectationWithDescription:@"update cell"];
  
  /* Get Sudoku cell at row 2, column 8 whose value = 23 */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(1, 7)];
  
  self.expectedValue = 9;
  [self.solution updateSudokuCell:cell inMacroGrid:self.grid withValue:9];
  [self waitForExpectationsWithTimeout:1.0 handler:nil];
  
  [NSThread sleepForTimeInterval: 1.0];
  /* Get another cell in the same row, it is located at row 2, column 4 whose value is 13
   * then update it to the conflict value that was assigned to the previous cell.
   */
  cell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(1, 3)];
  self.expectedValue = 9;
  self.expectation = [self expectationWithDescription:@"update 2nd cell"];
  [self.solution updateSudokuCell:cell inMacroGrid:self.grid withValue:9];
  [self waitForExpectationsWithTimeout:1.0 handler:nil];
  
}

@end
