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

typedef enum _MacroGridFlattingType{
  MacroGridFlattingTypeMicroGrids = 0,
  MacroGridFlattingTypeCells = 1
}MacroGridFlattingType;

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

-(instancetype) initWithMicroGrids: (NSArray<SudokuCell*>*) cellsOfMicroGrids;
-(instancetype) initWithRowsOfCells: (NSArray<SudokuCell*>*) cells;
-(MacroGrid*) copyMacroGrid;
-(NSUInteger) numOfCells;

/* Retrieve row from macro grid. This wil be using so much during the runtime to eliminate numbers
 * from potential solution sets of cells in a row.
 */
-(NSArray<SudokuCell*>*) getRowAtIndex: (NSUInteger) index;

/* Retrieve column from macro grid */
-(NSArray<SudokuCell*>*) getColumnAtIndex: (NSUInteger) index;

-(SudokuCell*) getSudokuCellAtRowColumn:(RowColPair) pair;
-(NSArray<SudokuCell*>*) getMicroGridForSudokuCell: (SudokuCell*) cell;

/* TODO: Create a parent class since these are the methods that are different from MicroGrid Class.
 *        I am not even sure even I am gonna call them for future uses or not? Since I can
 *        convert the index into pair of row/column then use the above methods to get the row/column cells.
 */
-(NSArray<SudokuCell*>*) getRowForCellAtIndex: (NSUInteger) index;
-(NSArray<SudokuCell*>*) getColumnForCellAtIndex: (NSUInteger) index;

/* Get index of the given sudoku cell */
-(NSUInteger) indexOfSudokuCell:(SudokuCell*) cell;

/* Get super set of cells for the given cell. The super set should include all the elements that
 * include the cell macro row, column & micro grid. The super set will include the cell itself.
 * Typically, the number of elements for any super set must be 9+8+4 = 21 sudoku cells
 */
-(NSArray<SudokuCell*>*) superSetOfSudokuCell: (SudokuCell*) cell;

/* Get the peers of the given sudoku cell. The peers set does not include the given cell. Typically
 * the peers set must be 8+8+4 = 20 elements.
 */
-(NSSet<SudokuCell*>*) peersOfSudokuCell: (SudokuCell*) cell;

-(NSArray<SudokuCell*>*) getFlattenedCells: (MacroGridFlattingType)type;

-(void) display;
@end
