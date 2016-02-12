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

- (void)testInit {
  XCTAssertEqual(9, [self.grid numOfCells]);
}

-(void) testGetRowInMicroGrid{
  NSArray<SudokuCell*>* cellsInRow = [self.grid getRowAtIndex:0];
  XCTAssertNotNil(cellsInRow);
  XCTAssertEqual(3, cellsInRow.count);
}

-(void) testGetRowInMicroGridWithInvalidIndex{
  NSArray<SudokuCell*>* cellsInRow = [self.grid getRowAtIndex:4];
  XCTAssertNil(cellsInRow);
}

-(void) testGetColumnInMicroGrid{
  NSArray<SudokuCell*>* cellsInColumn = [self.grid getColumnAtIndex:2];
  XCTAssertNotNil(cellsInColumn);
  XCTAssertEqual(3, cellsInColumn.count);
}

-(void) testGetColumnInMicroGridWithInvalidIndex{
  NSArray<SudokuCell*>* cellsInRow = [self.grid getColumnAtIndex:-1];
  XCTAssertNil(cellsInRow);
}

-(void) testGetSudokuCellAtIndex{
  RowColPair pair = makeRowColPair(2, 2);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  XCTAssertNotNil(cell);
}

-(void) testGetSudokuCellAtInvalidIndex{
  RowColPair pair = makeRowColPair(-1, 1);
  SudokuCell* cell = [self.grid getSudokuCellAtRowColumn:pair];
  XCTAssertNil(cell);
}


@end
