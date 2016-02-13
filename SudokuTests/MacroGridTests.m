//
//  MacroGridTests.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-12.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MacroGrid.h"
#import "RowColPair.h"
#import "MicroGrid.h"

@interface MacroGridTests : XCTestCase
@property (strong,nonatomic) MacroGrid* grid;
@end

@implementation MacroGridTests

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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
  
    /* Reset the static counter to 1 so that cells values of the next test, start from 1.
     * The count is static variable that is not destroyed by the end of the init method scope. */
    [MicroGrid resetCount];
}

- (void)testInitMacroGrid {
  
  XCTAssertEqual(81, [self.grid numOfCells]);

  /* Make sure that all values of the cells are set properly. */
  NSUInteger expectedCellValue = 1;
  for (int i=0; i< 9; i++) {
    for (int j=0; j<9; j++) {
      
      SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(i, j)];
      XCTAssertEqual(expectedCellValue, cell.value);
      expectedCellValue ++;
    }
  }
}

-(void) testGetSudokuCellAtRowColumn{
  /* Get element at 5th row , 4th column*/
  RowColPair pair = makeRowColPair(4, 3);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  NSUInteger expectedCellValue = 40;
  XCTAssertEqual(expectedCellValue, cell.value);
}

-(void) testtestGetSudokuCellAtInvalidRowColumn{
  /* Get element at row 10, column 5*/
  RowColPair pair = makeRowColPair(9, 4);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  
  XCTAssertNil(cell);
}

-(void) testGetRowAtValidIndex{
  /* Get an index for 8th row that has index 7. */
  NSArray<SudokuCell*>* cellsOfRow = [self.grid getRowAtIndex:7];
  NSUInteger expectedCellValue = 64;
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedCellValue, cellsOfRow[i].value);
    expectedCellValue++;
  }
}

-(void) testGetRowAtInvalidIndex{
  /* Get an index for 10th row that has index 9. */
  NSArray<SudokuCell*>* cellsOfRow = [self.grid getRowAtIndex:9];
  XCTAssertNil(cellsOfRow);
}

-(void) testGetColumnAtValidIndex{
  /* Get an index for 8th column that has index 7. */
  NSArray<SudokuCell*>* cellsOfColumn = [self.grid getColumnAtIndex:7];
  NSUInteger expectedCellValue = 8;
  
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedCellValue, cellsOfColumn[i].value);
    expectedCellValue +=9;
  }
}

-(void) testGetColumnAtInvalidIndex{
  /* Get an index for 13th row that has index 12. */
  NSArray<SudokuCell*>* cellsOfColumn = [self.grid getColumnAtIndex:12];
  XCTAssertNil(cellsOfColumn);
}

-(void) testGetRowForCellAtValidIndex{
  /* Get row for cell at row 3, col 4 which maps to index 2*9+4 = 22. */
  NSArray<SudokuCell*>* cellsOfRow = [self.grid getRowForCellAtIndex:22];
  XCTAssertNotNil(cellsOfRow);
  NSUInteger expectedCellValue = 19;
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedCellValue, cellsOfRow[i].value);
    expectedCellValue++;
  }
}

-(void) testGetRowForCellAtInvalidIndex{
  /* Get row for cell at index > 80. */
  NSArray<SudokuCell*>* cellsOfRow = [self.grid getRowForCellAtIndex:81];
  XCTAssertNil(cellsOfRow);
}

-(void) testGetColumnForCellAtValidIndex{
  /* Get column for cell at row 3, col 4 (indexes: 2,3) which maps to index 2*9+3 = 21. */
  NSArray<SudokuCell*>* cellsOfColumns = [self.grid getColumnForCellAtIndex:21];
  XCTAssertNotNil(cellsOfColumns);
  NSUInteger expectedCellValue = 4;
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedCellValue, cellsOfColumns[i].value);
    expectedCellValue +=9;
  }
}

-(void) testGetColumnForCellAtInvalidIndex{
  /* Get column for cell whose index is negative */
  NSArray<SudokuCell*>* cellsOfColumn = [self.grid getColumnForCellAtIndex:-1];
  XCTAssertNil(cellsOfColumn);
}

-(void) testGetIndexOfSudokuCell{
  /* Get cell at row 4, column 7. */
  RowColPair pair = makeRowColPair(3, 6); /* maps to index 3*9+6 = 33 */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  XCTAssertNotNil(cell);
  XCTAssertEqual(34, cell.value);
  
  NSUInteger index = [self.grid indexOfSudokuCell:cell];
  XCTAssertEqual(33, index);
}
@end
