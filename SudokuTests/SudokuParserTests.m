//
//  SudokuParserTests.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-14.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SudokuParser.h"

@interface SudokuParserTests : XCTestCase
@property (strong, nonatomic) SudokuParser* parser;
@end

@implementation SudokuParserTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  self.parser = [[SudokuParser alloc] init];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
  self.parser = nil;
}

- (void)testInitParser{
  
  NSRange expectedRange = NSMakeRange(0, 10);
  XCTAssertNotNil(self.parser);
  XCTAssertTrue(NSEqualRanges(expectedRange, self.parser.acceptableRange));
}

-(void) testParseGridFromPListSuccess{
  int expectedResults[] =
  {
    0,0,3,0,2,0,6,0,0, //micro_grid_0
    9,0,0,3,0,5,0,0,1, //micro_grid_1
    0,0,1,8,0,6,4,0,0, //micro_grid_2
    0,0,8,1,0,2,9,0,0, //micro_grid_3
    7,0,0,0,0,0,0,0,8, //micro_grid_4
    0,0,6,7,0,8,2,0,0, //micro_grid_5
    0,0,2,6,0,9,5,0,0, //micro_grid_6
    8,0,0,2,0,3,0,0,9, //micro_grid_7
    0,0,5,0,1,0,3,0,0  //micro_grid_8
  };
  
  MacroGrid* grid = [self.parser parseGridFromPropertyListFile:@"sudoku_grid"];
  NSArray<SudokuCell*>* cellsOfMicroGrids = [grid getFlattenedMicroGridsCellsArray];
  
  XCTAssertNotNil(grid);
  XCTAssertEqual(81, [grid numOfCells]);
  
  for (int i=0; i<81; i++) {
    XCTAssertEqual(expectedResults[i], cellsOfMicroGrids[i].value);
  }
}

@end
