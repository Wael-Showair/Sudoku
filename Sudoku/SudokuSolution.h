//
//  ConstraintPropagation.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-13.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SudokuCell.h"
#import "MacroGrid.h"

/* This class will be used into main scenarios:
 * 1. when the user is playing, if the input value is incorrect, update the cell's visual effect.
 *    That's why I will be using a delegate for the sake of handling error case.
 * 2. when ther user asks to solve the sudoku game.
 */

/* This custom protocol is to inform the delegate object of the Constraint Propagation object
 * that it has failed to update the value for the given Sudoku cell.
 */
@protocol SudokuSolutionDelegate
@optional
-(void) didFailToInsertValueOfSudokuCell: (SudokuCell*) cell;
-(void) didFinishUpdateValueOfSudokuCell: (SudokuCell*) cell;
@end

@interface SudokuSolution : NSObject
@property (weak,nonatomic) id<SudokuSolutionDelegate> delegate;
//-(void) updateSudokuCell:(SudokuCell*)cell inMacroGrid:(MacroGrid*)macroGrid withValue:(NSUInteger)value;

/* It is more professional if this methods can take pointer to pointer and return nil. */
-(void) solveSudokuGrid: (MacroGrid**) grid;
-(BOOL) assignValue: (NSUInteger) value toSudokuCell: (SudokuCell*) cell inMacroGrid: (MacroGrid*) grid;
@end
