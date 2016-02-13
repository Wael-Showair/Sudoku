//
//  MacroGrid.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-12.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SudokuCell.h"
#import "RowColPair.h"

/* This class wraps a 9 micro grid in Sudoku game but with one matrix of size 9x9. 
 * Typically, there is only 1 macro grids in Sudoku game. 
 *
 * The features of this grid type is that:
 *
 * 1- it contains distinct numbers ranges from 1 to 9 per each row/column.
 * 2- it should perform membership-testing fast since it is expected frequently to check whether a
 *    number exists in a given row/column.
 * 3- Ordered objects is a requiremnt to be able to have a macro row/columne of 9 elements at any time
 * There NSOrderedSet/NSMutableOrderedSet classes in Objective-C that meet these requirements of
 * single row/column in macro grid.
 *
 * The whole rows and columns would be placed in single mutable order set. Thus interfacing with
 * Data Source would be straightforward.
 */

@interface MacroGrid : NSObject

-(NSUInteger) numOfCells;

/* Retrieve row from macro grid. This wil be using so much during the runtime to eliminate numbers
 * from potential solution sets of cells in a row.
 */
-(NSArray<SudokuCell*>*) getRowAtIndex: (NSUInteger) index;

/* Retrieve column from macro grid */
-(NSArray<SudokuCell*>*) getColumnAtIndex: (NSUInteger) index;

-(SudokuCell*) getSudokuCellAtRowColumn:(RowColPair) pair;

/* TODO: Create a parent class since these are the methods that are different from MicroGrid Class. */
-(NSArray<SudokuCell*>*) getRowForCellAtIndex: (NSUInteger) index;
-(NSArray<SudokuCell*>*) getColumnForCellAtIndex: (NSUInteger) index;
@end
