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
  
  
  self.grid = [[MacroGrid alloc] init];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
  
}

- (void)testInitMacroGrid {
  
  XCTAssertEqual(81, [self.grid numOfCells]);
  int k=0;
  for (int i=0; i< 9; i++) {
    for (int j=0; j<9; j++) {
      
      SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(i, j)];
      XCTAssertEqual(0, cell.value);
      
      NSUInteger indexOfCellInMacroGrid = [self.grid indexOfSudokuCell:cell];
      NSUInteger expectedIndex = [NSIndexSet indexSetWithIndex:k].firstIndex;
      
      
      XCTAssertEqual(expectedIndex, indexOfCellInMacroGrid);
      k++;
    }
  }
}

-(void) testInitMacroGridWithInvalidMicroGridsNil{
  MacroGrid* grid = [[MacroGrid alloc] initWithMicroGrids:nil];
  XCTAssertNil(grid);
}

-(void) testInitMacroGridWithInvalidMicroGridsIncorrectCount{
  SudokuCell* cell = [[SudokuCell alloc] init];
  /* Length of the Array must be 81 but I send it with only one object to achieve the test target.*/
  NSArray<SudokuCell*>* cellsOfMicroGrid = [NSArray arrayWithObject:cell];
  
  MacroGrid* grid = [[MacroGrid alloc]initWithMicroGrids:cellsOfMicroGrid];
  XCTAssertNil(grid);
}

-(void) testInitMacroGridWithRows{
  NSArray<SudokuCell*>* cellsOfGrid1 = [self.grid getFlattenedCells:MacroGridFlattingTypeCells];
  NSArray<SudokuCell*>* cellsOfFirstMicroGrids = [self.grid getFlattenedCells:MacroGridFlattingTypeMicroGrids];
  
  
  MacroGrid* grid2 = [[MacroGrid alloc] initWithRowsOfCells:cellsOfGrid1];
  NSArray<SudokuCell*>* cellsOfSecondMicroGrids = [grid2 getFlattenedCells:MacroGridFlattingTypeMicroGrids];
  
  XCTAssertEqual(cellsOfFirstMicroGrids.count , cellsOfSecondMicroGrids.count);
}

-(void) testInitMacroGridWithRowsNil{
  MacroGrid* grid = [[MacroGrid alloc] initWithRowsOfCells:nil];
  XCTAssertNil(grid);

}

-(void) testInitMacroGridWithIncorrectCountOfCells{
  SudokuCell* cell = [[SudokuCell alloc] init];
  /* Length of the Array must be 81 but I send it with only one object to achieve the test target.*/
  NSArray<SudokuCell*>* cellsOfMicroGrid = [NSArray arrayWithObject:cell];
  
  MacroGrid* grid = [[MacroGrid alloc]initWithRowsOfCells:cellsOfMicroGrid];
  XCTAssertNil(grid);
}

-(void) testGetSudokuCellAtRowColumn{
  /* Get element at 5th row , 4th column*/
  RowColPair pair = makeRowColPair(4, 3);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  NSUInteger expectedCellIndex = 39;
  
  XCTAssertNotNil(cell);
  XCTAssertEqual(0 , cell.value);
  NSUInteger cellIndex = [self.grid indexOfSudokuCell:cell];
  XCTAssertEqual(expectedCellIndex, cellIndex);
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
  NSUInteger expectedResult [9] = {63,64,65,66,67,68,69,70,71};
  for (int i=0; i<9; i++) {
    XCTAssertEqual(0, cellsOfRow[i].value);
    NSUInteger cellIndex = [self.grid indexOfSudokuCell:cellsOfRow[i]];
    XCTAssertEqual(expectedResult[i], cellIndex);
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
  int expectedResults [9] = {7,16,25,34,43,52,61,70,79};
  
  for (int i=0; i<9; i++) {
    XCTAssertEqual(0, cellsOfColumn[i].value);
    NSUInteger cellIndex = [self.grid indexOfSudokuCell:cellsOfColumn[i]];
    XCTAssertEqual(expectedResults[i], cellIndex);
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
  XCTAssertEqual(9, cellsOfRow.count);
  int expectedResults[9] = {18,19,20,21,22,23,24,25,26};
  for (int i=0; i<9; i++) {
    XCTAssertEqual(0, cellsOfRow[i].value);
    NSUInteger cellIndex = [self.grid indexOfSudokuCell:cellsOfRow[i]];
    XCTAssertEqual(expectedResults[i], cellIndex);
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
  XCTAssertEqual(9, cellsOfColumns.count);
  
  int expectedResults[9] = {3,12,21,30,39,48,57,66,75};
  for (int i=0; i<9; i++) {
    XCTAssertEqual(0, cellsOfColumns[i].value);
    NSUInteger cellIndex = [self.grid indexOfSudokuCell:cellsOfColumns[i]];
    XCTAssertEqual(expectedResults[i], cellIndex);
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
  XCTAssertEqual(0, cell.value);
  
  NSUInteger index = [self.grid indexOfSudokuCell:cell];
  XCTAssertEqual(33, index);
}


-(void) testSuperSetOfValidSudokuCellInMacroGrid{
  
  /* Get cell at row 5, column 9 which maps to cell whose index 44 (4*9+8) */
  RowColPair pair = makeRowColPair(4, 8);
  
  /* Rows, then columns then Micro grid. */
  int expectedResults [3][9] = {
    {36,37,38,39,40,41,42,43,44}, //row
    {8,17,26,35,44,53,62,71,80}, //column
    {33,34,35,42,43,44,51,52,53} //rest of micro grid without indexes 42,43,44,35,53
  };
  
  /* Get the cell from the macro grid. */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  
  /* Get the super set of the cell. */
  NSArray* superSetCells = [self.grid superSetOfSudokuCell:cell];
  
  /* Make sure that the length of the super set is always 21 */
  XCTAssertEqual(3, superSetCells.count);
  
  for (int i=0; i<3; i++) {
    for (int j=0; j<9; j++) {
      XCTAssertEqual(0, ((SudokuCell*)(superSetCells[i][j])).value);
      NSUInteger cellIndex = [self.grid indexOfSudokuCell:superSetCells[i][j]];
      XCTAssertEqual(expectedResults[i][j], cellIndex);
    }
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
  
  /* Get cell at row 5, column 9 which maps to cell whose index 44 (4*9+8) */
  RowColPair pair = makeRowColPair(4, 8);
  
  /* Rows, then columns then Micro grid. */
  int expectedResults [21] = {
    36,37,38,39,40,41,42,43, //row without index 44
    8,17,26,35,53,62,71,80, //column without index 44
    33,34,51,52 //rest of micro grid without indexes 42,43,44,35,53
  };
  NSMutableIndexSet* expectedIndexes = [[NSMutableIndexSet alloc] init];
  for (int i=0; i<21; i++) {
    [expectedIndexes addIndex:expectedResults[i]];
  }
  
  /* Get the cell from the macro grid. */
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  
  /* Get the super set of the cell. */
  NSSet<SudokuCell*>* peers = [self.grid peersOfSudokuCell:cell];
  
  /* Make sure that the length of the super set is always 21 */
  XCTAssertEqual(20, peers.count);

  for (SudokuCell* peerCell in peers) {
    XCTAssertEqual(0, peerCell.value);
    NSUInteger cellIndex = [self.grid indexOfSudokuCell:peerCell];
    XCTAssertTrue([expectedIndexes containsIndex:cellIndex]);
  }
  
}

-(void) testPeersOfValidSudokuCellNotInMacroGrid{
  SudokuCell* cell = [[SudokuCell alloc] init];
  
  /* Get the super set of the cell. */
  NSSet<SudokuCell*>* peers = [self.grid peersOfSudokuCell:cell];
  
  XCTAssertNil(peers);
}

-(void) testPeersOfInvalidSudokuCell{
  
  /* Get the super set of the cell. */
  NSSet<SudokuCell*>* peers = [self.grid peersOfSudokuCell:nil];
  
  XCTAssertNil(peers);
}

-(void) testGetMicroGridForSudokuCellNil{
  NSArray* microGridCe = [self.grid getMicroGridForSudokuCell:nil];
  XCTAssertNil(microGridCe);
}

-(void) testGetFlattenedMicroGridsCells{
  
  int expectedResults [] ={
    0,1,2,9,10,11,18,19,20,     //micro_grid_0
    3,4,5,12,13,14,21,22,23,    //micro_grid_1
    6,7,8,15,16,17,24,25,26,    //micro_grid_2
    27,28,29,36,37,38,45,46,47, //micro_grid_3
    30,31,32,39,40,41,48,49,50, //micro_grid_4
    33,34,35,42,43,44,51,52,53, //micro_grid_5
    54,55,56,63,64,65,72,73,74, //micro_grid_6
    57,58,59,66,67,68,75,76,77, //micro_grid_7
    60,61,62,69,70,71,78,79,80  //micro_grid_8
  };
  
  NSArray<SudokuCell*>* cellsOfMicroGrid = [self.grid getFlattenedCells:MacroGridFlattingTypeMicroGrids];
  
  XCTAssertNotNil(cellsOfMicroGrid);
  XCTAssertEqual(81, cellsOfMicroGrid.count);
  
  for (int i=0; i< 81; i++) {
    SudokuCell* cell = cellsOfMicroGrid[i];
    XCTAssertEqual(0, cell.value);
    
    NSUInteger indexOfCellInMacroGrid = [self.grid indexOfSudokuCell:cell];
    
    XCTAssertEqual(expectedResults[i], indexOfCellInMacroGrid);

  }
}

-(void) testGetFlattenedGridCells{
  
  NSArray<SudokuCell*>* cellsOfMacroGrid = [self.grid getFlattenedCells:MacroGridFlattingTypeCells];
  
  XCTAssertNotNil(cellsOfMacroGrid);
  XCTAssertEqual(81, cellsOfMacroGrid.count);
  
  for (int index=0; index< 81; index++) {
    SudokuCell* cell = cellsOfMacroGrid[index];
    XCTAssertEqual(0, cell.value);
    
    NSUInteger indexOfCellInMacroGrid = [self.grid indexOfSudokuCell:cell];
    
    XCTAssertEqual(index, indexOfCellInMacroGrid);
    
  }
}

-(void) testGetFlattenedCellsInvalidFlattingType{
  
  /* Defined types for flatting cells are either micro grids (value =0) or macro cells (value=1)
   * value 2 is undefined. the method should throws an exception.
   */
  XCTAssertThrows([self.grid getFlattenedCells:2]);
}

-(void) testDeepCopyGrid{
  /* Change some cell in the gird, just to verify that their contents don't change after taking copy of them.*/
  NSArray<SudokuCell*>* sourceCells = [self.grid getFlattenedCells:MacroGridFlattingTypeCells];
  [sourceCells enumerateObjectsUsingBlock:^(SudokuCell* srcCell, NSUInteger index, BOOL* shouldStop){
    srcCell.potentialSolutionSet = [NSMutableIndexSet indexSetWithIndex:index%9];
    srcCell.value = index%9;
  }];
  
  MacroGrid* copyOfGrid = [self.grid copyMacroGrid];
  XCTAssertNotEqual(copyOfGrid, self.grid);
  

  NSArray<SudokuCell*>* destinationCells = [copyOfGrid getFlattenedCells:MacroGridFlattingTypeCells];
  
  [sourceCells enumerateObjectsUsingBlock:^(SudokuCell* srcCell, NSUInteger index, BOOL* shouldStop){
    
    SudokuCell* destCell = [destinationCells objectAtIndex:index];
    XCTAssertNotEqual(srcCell, destCell);//Different memory addresses since this is deep copy not shallow copy.
    XCTAssertEqual(srcCell.value, destCell.value); //Content should be the same.
    
    XCTAssertNotEqual(srcCell.potentialSolutionSet, destCell.potentialSolutionSet); //Different memoty addresses.
    XCTAssertEqual(srcCell.potentialSolutionSet.count, destCell.potentialSolutionSet.count); //should have same contents.
    XCTAssertEqual([srcCell.potentialSolutionSet firstIndex], [destCell.potentialSolutionSet firstIndex]);
    
  }];
  

}

-(void) testDisplay{
  [self.grid display];
}
@end
