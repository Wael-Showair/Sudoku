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
  
  
  self.grid = [[MicroGrid alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitMicroGrid {
  XCTAssertEqual(9, [self.grid numOfCells]);
}

-(void) testGetRowInMicroGrid{
  
  /* Get first row */
  NSArray<SudokuCell*>* cellsInRow = [self.grid getRowAtIndex:0];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
  
  int expectedResults1 []= {0,1,2};
  for (NSUInteger i=0; i<cellsInRow.count; i++) {
    XCTAssertEqual(0, cellsInRow[i].value);
    NSUInteger indexOfCellInRow = [self.grid indexOfSudokuCell:cellsInRow[i]];
    XCTAssertEqual(expectedResults1[i], indexOfCellInRow);
  }
  
  /* Get second row */
  cellsInRow = [self.grid getRowAtIndex:1];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
  int expectedResults2 []= {3,4,5};
  for (NSUInteger i=0; i<cellsInRow.count; i++) {
    XCTAssertEqual(0, cellsInRow[i].value);
    NSUInteger indexOfCellInRow = [self.grid indexOfSudokuCell:cellsInRow[i]];
    XCTAssertEqual(expectedResults2[i], indexOfCellInRow);
  }

  /* Get thrird row */
  cellsInRow = [self.grid getRowAtIndex:2];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
  int expectedResults3 []= {6,7,8};
  for (NSUInteger i=0; i<cellsInRow.count; i++) {
    XCTAssertEqual(0, cellsInRow[i].value);
    NSUInteger indexOfCellInRow = [self.grid indexOfSudokuCell:cellsInRow[i]];
    XCTAssertEqual(expectedResults3[i], indexOfCellInRow);
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
  int expectedResults1 []= {0,3,6};
  for (int j=0; j< 3;j++) {
    XCTAssertEqual(0, cellsInColumn[j].value);
    NSUInteger indexOfCellInColumn = [self.grid indexOfSudokuCell:cellsInColumn[j]];
    XCTAssertEqual(expectedResults1[j], indexOfCellInColumn);
  }
  
  /* Get second column. */
  cellsInColumn = [self.grid getColumnAtIndex:1];
  XCTAssertNotNil(cellsInColumn);
  XCTAssertEqual(3, cellsInColumn.count);
  int expectedResults2 []= {1,4,7};
  for (int j=0; j< 3;j++) {
    XCTAssertEqual(0, cellsInColumn[j].value);
    NSUInteger indexOfCellInColumn = [self.grid indexOfSudokuCell:cellsInColumn[j]];
    XCTAssertEqual(expectedResults2[j], indexOfCellInColumn);
  }
  
  /* Get thrird column. */
  cellsInColumn = [self.grid getColumnAtIndex:2];
  XCTAssertNotNil(cellsInColumn);
  XCTAssertEqual(3, cellsInColumn.count);
  int expectedResults3 []= {2,5,8};
  for (int j=0; j< 3;j++) {
    XCTAssertEqual(0, cellsInColumn[j].value);
    NSUInteger indexOfCellInColumn = [self.grid indexOfSudokuCell:cellsInColumn[j]];
    XCTAssertEqual(expectedResults3[j], indexOfCellInColumn);
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
  XCTAssertEqual(0, cell.value);
  
  NSUInteger cellIndex = [self.grid indexOfSudokuCell:cell];
  XCTAssertEqual(7, cellIndex);
}

-(void) testGetSudokuCellAtInvalidIndex{
  RowColPair pair = makeRowColPair(-1, 1);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  XCTAssertNil(cell);
}

-(void) testIndexOfSudokuCellNil{
  NSUInteger cellIndex = [self.grid indexOfSudokuCell:nil];
  XCTAssertEqual(NSNotFound, cellIndex);
}

-(void) testIndexOfSudokuCellWithValueOutOfRange{
  SudokuCell* cell = [[SudokuCell alloc] initWithValue:88];
  NSUInteger cellIndex = [self.grid indexOfSudokuCell:cell];
  XCTAssertEqual(NSNotFound, cellIndex);
}

@end
