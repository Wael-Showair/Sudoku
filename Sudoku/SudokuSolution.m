//
//  ConstraintPropagation.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-13.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuSolution.h"


@implementation SudokuSolution

-(void)updateSudokuCell:(SudokuCell *)cell inMacroGrid:(MacroGrid *)grid withValue:(NSUInteger)value{

  /* 1. Check that given value belongs to the potential solution set of the cell. */
  if (NO == [cell.potentialSolutionSet containsIndex:value] ||
      NO ==  NSLocationInRange(value, cell.range) ||
      nil == cell ||
      nil == grid) {
    
    cell.value = value;
    [self.delegate didFailToInsertValueOfSudokuCell:cell];
  }else{
    
    /* 2. Eliminate the value from the peers of the cell. */
    NSArray<SudokuCell*>* peers = [grid peersOfSudokuCell:cell];
    
    if (nil != peers) {
      
      for (SudokuCell* peerCell in peers) {
        [peerCell.potentialSolutionSet removeIndex:value];
      }
      
      /* 3. Update the value of the cell. */
       cell.value = value;
      
      /* inform the delegate objects so that they can proper actions. */
      [self.delegate didFinishUpdateValueOfSudokuCell:cell];

    }
  }

}
@end
