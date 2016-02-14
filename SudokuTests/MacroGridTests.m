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

  /* Make sure that all values of the cells are set properly. */
  int expectedResults[81]={
    1,2,3,10,11,12,19,20,21,
    4,5,6,13,14,15,22,23,24,
    7,8,9,16,17,18,25,26,27,
    28,29,30,37,38,39,46,47,48,
    31,32,33,40,41,42,49,50,51,
    34,35,36,43,44,45,52,53,54,
    55,56,57,64,65,66,73,74,75,
    58,59,60,67,68,69,76,77,78,
    61,62,63,70,71,72,79,80,81
  };
  
  XCTAssertEqual(81, [self.grid numOfCells]);

  
  int k=0;
  for (int i=0; i< 9; i++) {
    for (int j=0; j<9; j++) {
      
      SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(i, j)];
      XCTAssertEqual(expectedResults[k], cell.value);
      k++;
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
  NSUInteger expectedResult [9] = {58,59,60,67,68,69,76,77,78};
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedResult[i], cellsOfRow[i].value);
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
  int expectedResults [9] = {20,23,26,47,50,53,74,77,80};
  
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedResults[i], cellsOfColumn[i].value);
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
  int expectedResults[9] = {7,8,9,16,17,18,25,26,27};
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedResults[i], cellsOfRow[i].value);
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
  int expectedResults[9] = {10,13,16,37,40,43,64,67,70};
  for (int i=0; i<9; i++) {
    XCTAssertEqual(expectedResults[i], cellsOfColumns[i].value);
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
  XCTAssertEqual(46, cell.value);
  
  NSUInteger index = [self.grid indexOfSudokuCell:cell];
  XCTAssertEqual(33, index);
}


-(void) testSuperSetOfValidSudokuCellInMacroGrid{
  
  /* Get cell at row 5, column 9 which maps to cell whose value = 51 */
  RowColPair pair = makeRowColPair(4, 8);
  
  /* Rows, then columns then Micro grid. */
  int expectedResults [21] = {
    31,32,33,40,41,42,49,50,51, //row
    21,24,27,48,54,75,78,81, //column without 51
    46,47,52,53 //rest of micro grid without 49,50,51,48,54
  };

  /* Get the cell from the macro grid. */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  
  /* Get the super set of the cell. */
  NSArray<SudokuCell*>* superSetCells = [self.grid superSetOfSudokuCell:cell];
  
  /* Make sure that the length of the super set is always 21 */
  XCTAssertEqual(21, superSetCells.count);
  
  for (int i=0; i<21; i++) {
    XCTAssertEqual(expectedResults[i], superSetCells[i].value);
  }
}

-(void) testSuperSetOfValidSudokuCellNotInMacroGrid{
  SudokuCell* cell = [[SudokuCell alloc] init];
  
  /* Get the super set of the cell. */
  NSArray<SudokuCell*>* superSetCells = [self.grid superSetOfSudokuCell:cell];
  
  XCTAssertNil(superSetCells);
}

-(void) testSuperSetOfInvalidSudokuCell{
  
  /* Get the super set of the cell. */
  NSArray<SudokuCell*>* superSetCells = [self.grid superSetOfSudokuCell:nil];
  
  XCTAssertNil(superSetCells);
}

-(void) testPeersOfValidSudokuCellInMacroGrid{
  
  /* Get cell at row 5, column 9 which maps to cell whose value = 51 */
  RowColPair pair = makeRowColPair(4, 8);
  
  /* Rows, then columns then Micro grid. */
  int expectedResults [21] = {
    31,32,33,40,41,42,49,50, //row without 51
    21,24,27,48,54,75,78,81, //column without 51
    46,47,52,53 //rest of micro grid without 49,50,51,48,54
  };
  
  /* Get the cell from the macro grid. */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  
  /* Get the super set of the cell. */
  NSArray<SudokuCell*>* peers = [self.grid peersOfSudokuCell:cell];
  
  /* Make sure that the length of the super set is always 21 */
  XCTAssertEqual(20, peers.count);
  
  for (int i=0; i<20; i++) {
    XCTAssertEqual(expectedResults[i], peers[i].value);
  }
}

-(void) testPeersOfValidSudokuCellNotInMacroGrid{
  SudokuCell* cell = [[SudokuCell alloc] init];
  
  /* Get the super set of the cell. */
  NSArray<SudokuCell*>* peers = [self.grid peersOfSudokuCell:cell];
  
  XCTAssertNil(peers);
}

-(void) testPeersOfInvalidSudokuCell{
  
  /* Get the super set of the cell. */
  NSArray<SudokuCell*>* peers = [self.grid peersOfSudokuCell:nil];
  
  XCTAssertNil(peers);
}

@end
