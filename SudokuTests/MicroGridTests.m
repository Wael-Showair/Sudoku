//
//  MicroGridTests.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-11.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MicroGrid.h"
#import "SudokuCell.h"

@interface MicroGridTests : XCTestCase
@property (strong,nonatomic)   MicroGrid* grid;
@end

@implementation MicroGridTests

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
  
  self.grid = [[MicroGrid alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
  
    /* Reset the static counter to 1 so that cells values of the next test, start from 1.
     * The count is static variable that is not destroyed by the end of the init method scope. */
    [MicroGrid resetCount];
}

- (void)testInitMicroGrid {
  XCTAssertEqual(9, [self.grid numOfCells]);
}

-(void) testGetRowInMicroGrid{
  
  /* Get first row */
  NSArray<SudokuCell*>* cellsInRow = [self.grid getRowAtIndex:0];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
  for (NSUInteger i=0; i<cellsInRow.count; i++) {
    XCTAssertEqual(i+1, cellsInRow[i].value);
  }
  
  /* Get second row */
  cellsInRow = [self.grid getRowAtIndex:1];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
  for (NSUInteger i=0; i<cellsInRow.count; i++) {
    XCTAssertEqual(i+4, cellsInRow[i].value);
  }
  
  /* Get thrird row */
  cellsInRow = [self.grid getRowAtIndex:2];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
  for (NSUInteger i=0; i<cellsInRow.count; i++) {
    XCTAssertEqual(i+7, cellsInRow[i].value);
  }
  
}

-(void) testGetRowInMicroGridWithInvalidIndex{
  NSArray<SudokuCell*>* cellsInRow = [self.grid getRowAtIndex:4];
  XCTAssertNil(cellsInRow);
}

-(void) testGetColumnInMicroGrid{
  /* Get firt column. */
  NSArray<SudokuCell*>* cellsInColumn = [self.grid getColumnAtIndex:0];
  XCTAssertNotNil(cellsInColumn);
  XCTAssertEqual(3, cellsInColumn.count);
  for (int i=0, j=1; i< 3; i++, j+=3) {
    XCTAssertEqual(j, cellsInColumn[i].value);
  }
  
  /* Get second column. */
  cellsInColumn = [self.grid getColumnAtIndex:1];
  XCTAssertNotNil(cellsInColumn);
  XCTAssertEqual(3, cellsInColumn.count);
  for (int i=0, j=2; i< 3; i++, j+=3) {
    XCTAssertEqual(j, cellsInColumn[i].value);
  }

  /* Get thrird column. */
  cellsInColumn = [self.grid getColumnAtIndex:2];
  XCTAssertNotNil(cellsInColumn);
  XCTAssertEqual(3, cellsInColumn.count);
  for (int i=0, j=3; i< 3; i++, j+=3) {
    XCTAssertEqual(j, cellsInColumn[i].value);
  }

}

-(void) testGetColumnInMicroGridWithInvalidIndex{
  NSArray<SudokuCell*>* cellsInRow = [self.grid getColumnAtIndex:-1];
  XCTAssertNil(cellsInRow);
}

-(void) testGetSudokuCellAtIndex{
  /* Get cell at 3rd row, 2nd column. It is value must be 8 */
  RowColPair pair = makeRowColPair(2, 1);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];

  XCTAssertNotNil(cell);
  XCTAssertEqual(8, cell.value);
}

-(void) testGetSudokuCellAtInvalidIndex{
  RowColPair pair = makeRowColPair(-1, 1);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  XCTAssertNil(cell);
}


@end
