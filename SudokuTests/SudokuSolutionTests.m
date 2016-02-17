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


@property (strong,nonatomic) SudokuSolution* solution;
@property (strong,nonatomic) SudokuParser* parser;

/* Let the testing class be delegate for Sudoku Solution class. Thus this is asynchrounous function
 * call testing to the delegate. XCTestExpectation must be used in this case.
 * Since the delegate methods such as
 * 1. solver:didFailToSolveSudokuGrid:
 * 2. solver:didSolveSudokuGrid:withUpdatedIndexes:
 * Both will be shared among different testing methods. Thus every method should set the following
 * objects before solving any Sudoku grid:
 * 1. What is the expected grid cells (represented by property expectedSolvedCellsValues )
 * 2. What is the expected set of indexes that should have been updated (represented by property expectedSetOfIndexes)
 * 3. Finally each test method should initialize its expectation object
 */
@property XCTestExpectation* expectation;

@property NSMutableIndexSet* expectedSetOfIndexes;
@property NSArray<NSNumber*>* expectedSolvedCellsValues;
@end

@implementation SudokuSolutionTests

-(void) solver:(SudokuSolution *)solver didFailToSolveSudokuGrid:(MacroGrid *)grid{

  [self.expectation fulfill];
}

-(void)solver:(SudokuSolution *)solver didSolveSudokuGrid:(MacroGrid *)grid withUpdatedIndexes:(NSIndexSet *)indexes{

  NSArray<SudokuCell*>* cellsOfSolvedGrid = [grid getFlattenedCells:MacroGridFlattingTypeMicroGrids];

  /* Verify cells of micro grids.*/
  for (int i=0; i< 81; i++) {
    
    /* Verify the value of the cell. */
    XCTAssertEqual(self.expectedSolvedCellsValues[i].intValue, cellsOfSolvedGrid[i].value);
    
    /* Verify that the cell has only one possible value */
    XCTAssertEqual(1, cellsOfSolvedGrid[i].potentialSolutionSet.count);
    
    /* Verify that the cell value is the same as its only possible value*/
    XCTAssertEqual(cellsOfSolvedGrid[i].value, cellsOfSolvedGrid[i].potentialSolutionSet.firstIndex);
  }
  
  /* Verify the indexes of updates cells in the gird. */
 // XCTAssertEqual(self.expectedSetOfIndexes.count, indexes.count);
  //XCTAssertTrue([self.expectedSetOfIndexes isEqualToIndexSet:indexes]);
  
  [self.expectation fulfill];
}

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  
  /* Let this testing class delegate to Sudoku Solution object. */
  self.solution = [[SudokuSolution alloc] init];
  self.solution.delegate = self;
  
  /* Most of testing methos might need a parser to get input macro grid. */
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
  
  /* 1. Determine what are the expected cells in the solved grid. */
  self.expectedSolvedCellsValues =
  @[
    @4,@8,@3,@9,@6,@7,@2,@5,@1, //micro_grid_0
    @9,@2,@1,@3,@4,@5,@8,@7,@6, //micro_grid_1
    @6,@5,@7,@8,@2,@1,@4,@9,@3, //micro_grid_2
    @5,@4,@8,@7,@2,@9,@1,@3,@6, //micro_grid_3
    @1,@3,@2,@5,@6,@4,@7,@9,@8, //micro_grid_4
    @9,@7,@6,@1,@3,@8,@2,@4,@5, //micro_grid_5
    @3,@7,@2,@8,@1,@4,@6,@9,@5, //micro_grid_6
    @6,@8,@9,@2,@5,@3,@4,@1,@7, //micro_grid_7
    @5,@1,@4,@7,@6,@9,@3,@8,@2  //micro_grid_8
  ];
  
  /* 2. Determine what are the expected cells that would be updated by the sudoku solver.*/
  self.expectedSetOfIndexes = [[NSMutableIndexSet alloc] init];
  int indexes []={
    0,1,3,5,7,8,          //indexes of empty cells in row_0
    10,11,13,15,16,       //indexes of empty cells in row_1
    18,19,22,25,26,       //indexes of empty cells in row_2
    27,28,31,34,35,       //indexes of empty cells in row_3
    37,38,39,40,41,42,43, //indexes of empty cells in row_4
    45,46,49,52,53,       //indexes of empty cells in row_5
    54,55,58,61,62,       //indexes of empty cells in row_6
    64,65,67,69,70,       //indexes of empty cells in row_7
    72,73,75,77,79,80     //indexes of empty cells in row_8
  };
  for (int i=0; i<sizeof(indexes)/sizeof(indexes[0]); i++) {
    [self.expectedSetOfIndexes addIndex:indexes[i]];
  }
  
  /* 3. Determine what is the expectation object for this test. */
  self.expectation = [self expectationWithDescription:@"Solve Sudoku Grid"];
  
  MacroGrid* grid = [self.parser parseGridFromPropertyListFile:@"sudoku_grid"];
  [self.solution solveSudokuGrid:&grid];
  
  [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

-(void) testSolveHardSudokuGridSuccess{
  /* 1. Determine what are the expected cells in the solved grid. */
  self.expectedSolvedCellsValues =
  @[
    @4, @1, @7,     @3, @6, @9,     @8, @2, @5,
    @6, @3, @2,     @1, @5, @8,     @9, @4, @7,
    @9, @5, @8,     @7, @2, @4,     @3, @1, @6,
    @8, @2, @5,     @4, @3, @7,     @1, @6, @9,
    @7, @9, @1,     @5, @8, @6,     @4, @3, @2,
    @3, @4, @6,     @9, @1, @2,     @7, @5, @8,
    @2, @8, @9,     @6, @4, @3,     @5, @7, @1,
    @5, @7, @3,     @2, @9, @1,     @6, @8, @4,
    @1, @6, @4,     @8, @7, @5,     @2, @9, @3
    ];
  
  /* 2. Determine what are the expected cells that would be updated by the sudoku solver.*/
  self.expectedSetOfIndexes = nil;
  
  /* 3. Determine what is the expectation object for this test. */
  self.expectation = [self expectationWithDescription:@"Solve Hard Sudoku Grid"];
  
  MacroGrid* grid = [self.parser parseGridFromPropertyListFile:@"sudoku_grid_hard"];

  [self.solution solveSudokuGrid:&grid];
  
  [self waitForExpectationsWithTimeout:1.0 handler:nil];

}

@end
