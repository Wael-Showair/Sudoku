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
#import "SudokuParser.h"

@interface SudokuSolutionTests : XCTestCase <SudokuSolutionDelegate>

@property (strong, nonatomic) MacroGrid* grid;
@property (strong,nonatomic) SudokuSolution* solution;
@property (strong,nonatomic) SudokuParser* parser;

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
  
  self.grid = [[MacroGrid alloc] init];
  self.solution = [[SudokuSolution alloc] init];
  self.solution.delegate = self;
  
  self.parser = [[SudokuParser alloc] init];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

-(void) testAssignValueToSudokuCellSuccess{
  MacroGrid* grid = [self.parser parseGridFromPropertyListFile:@"sudoku_grid"];

  /* Get cell at row 1, column 1*/
  RowColPair pair = makeRowColPair(0, 0);
  SudokuCell* cell = [grid getSudokuCellAtRowColumn:pair];
  BOOL sucess = [self.solution assignValue:4 toSudokuCell:cell inMacroGrid:grid];
  
  XCTAssertTrue(sucess);
}

-(void)testSolveSudokuGridSuccess{
  int expectedGrid []=
  {
    4,8,3,9,6,7,2,5,1, //micro_grid_0
    9,2,1,3,4,5,8,7,6, //micro_grid_1
    6,5,7,8,2,1,4,9,3, //micro_grid_2
    5,4,8,7,2,9,1,3,6, //micro_grid_3
    1,3,2,5,6,4,7,9,8, //micro_grid_4
    9,7,6,1,3,8,2,4,5, //micro_grid_5
    3,7,2,8,1,4,6,9,5, //micro_grid_6
    6,8,9,2,5,3,4,1,7, //micro_grid_7
    5,1,4,7,6,9,3,8,2  //micro_grid_8
  };
  
  MacroGrid* grid = [self.parser parseGridFromPropertyListFile:@"sudoku_grid"];
  MacroGrid* solvedGrid =  [self.solution solveSudokuGrid:grid];
  
  NSArray<SudokuCell*>* cellsOfSolvedGrid = [solvedGrid getFlattenedMicroGridsCellsArray];
  for (int i=0; i< 81; i++) {
    XCTAssertEqual(expectedGrid[i], cellsOfSolvedGrid[i].value);
  }
}

@end
