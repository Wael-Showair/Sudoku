//
//  ConstraintPropagation.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-13.
//  Copyright © 2016 Algonquin College. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SudokuSolution.h"


@implementation SudokuSolution

//-(void)updateSudokuCell:(SudokuCell *)cell inMacroGrid:(MacroGrid *)grid withValue:(NSUInteger)value{
//
//  /* 1. Check that given value belongs to the potential solution set of the cell. */
//  if (NO == [cell.potentialSolutionSet containsIndex:value] ||
//      NO ==  NSLocationInRange(value, [SudokuCell fullRange]) ||
//      nil == cell ||
//      nil == grid) {
//    
//    cell.value = value;
//    [self.delegate didFailToInsertValueOfSudokuCell:cell];
//  }else{
//    
//    /* 2. Eliminate the value from the peers of the cell. */
//    NSArray<SudokuCell*>* peers = [grid peersOfSudokuCell:cell];
//    
//    if (nil != peers) {
//      
//      for (SudokuCell* peerCell in peers) {
//        [peerCell.potentialSolutionSet removeIndex:value];
//      }
//      
//      /* 3. Update the value of the cell. */
//       cell.value = value;
//      
//      /* inform the delegate objects so that they can proper actions. */
//      [self.delegate didFinishUpdateValueOfSudokuCell:cell];
//
//    }
//  }
//
//}

-(MacroGrid*)solveSudokuGrid:(MacroGrid *)grid{

  /* Create an internal macro grid to start solving the given sudoku grid.
   * Note that this grid initially has no cells' values and every cell has all full range from 1->9
   * in the cells' potential solution sets.
   */
  MacroGrid* solvedGrid = [[MacroGrid alloc] init];
  NSArray<SudokuCell*>* cellsOfSolvedGrid= [solvedGrid getFlattenedMicroGridsCellsArray];
  
  NSArray<SudokuCell*>* cellsOfSourceGrid= [grid getFlattenedMicroGridsCellsArray];
  
  __block BOOL canSolveGrid = YES;
  
  /* Iterate over the source grid cells. */
  [cellsOfSourceGrid enumerateObjectsUsingBlock:^(SudokuCell* sourceCell, NSUInteger index, BOOL* shouldStop){
    /* If value of the cell belongs to a valid potential range of values (1->9), Apply the constraint
     * propagation algorithm over the destination grid.
     */
    if (YES == NSLocationInRange(sourceCell.value, [SudokuCell fullRange])) {
      SudokuCell* destinationCell = [cellsOfSolvedGrid objectAtIndex:index];
      BOOL success = [self assignValue:sourceCell.value toSudokuCell:destinationCell inMacroGrid:solvedGrid];
      if (NO == success) {
        canSolveGrid = NO;
        *shouldStop = YES;
      }
    }
    
  }];
    
  if (NO == canSolveGrid) {
    return nil;
  }
  
  return solvedGrid;
}

/* It turns out that the fundamental operation is not assigning a value, but rather eliminating one 
 * of the possible values for a cell.Then assign value(d) in a cell can be defined as
 * "eliminate all other possible values from the cell except the required number d".
 */
-(BOOL) assignValue: (NSUInteger) value toSudokuCell: (SudokuCell*) cell inMacroGrid: (MacroGrid*) grid{

  /* Since a value would be assigned to a cell, this means that the value does not belong to 
   * the impossible solution set.
   */
  NSMutableIndexSet* impossibleSolutionSet = [[NSMutableIndexSet alloc] initWithIndexSet:cell.potentialSolutionSet ];
  [impossibleSolutionSet removeIndex:value];
  
  /* Iterate over every value(d) in the impossbile solution set to eliminate that value(d) from the
   * potential solution set of the given cell.
   */
  [impossibleSolutionSet enumerateIndexesUsingBlock:^(NSUInteger impossibleValue, BOOL* shouldStop){
    [self eliminateValue:impossibleValue fromSudokuCell:cell inMacroGrid:grid];
    *shouldStop = NO;
  }];
  return YES;
}

-(BOOL) eliminateValue: (NSUInteger) value fromSudokuCell: (SudokuCell*) cell inMacroGrid: (MacroGrid*) grid{

  NSArray<SudokuCell*>* peers;
  NSArray<SudokuCell*>* superSet;
  NSUInteger lastPotentialValueOfCell;
  SudokuCell* targetCell;
  NSMutableIndexSet* setOfCellsIndexes;
  
  if (NO == [cell.potentialSolutionSet containsIndex:value]) {
    return YES; /* value has been already eliminated. */
  }
  
  /* Eliminate the value from the potential solution set. */
  [cell.potentialSolutionSet removeIndex:value];
  
  switch (cell.potentialSolutionSet.count) {
    case 0:
      /* Contradication: You have just removed the last value from the potential solution set.*/
      [cell.potentialSolutionSet addIndex:value];
      NSAssert(value == cell.value, @"Can't Eliminate the last value from the potential solution set");
      return NO;
      break;

    case 1:
      /* If the cell contains only one value(v) in its potential solution set, then remove this
       * value(v) from the peers of the given cell.
       */
      lastPotentialValueOfCell = [cell.potentialSolutionSet firstIndex];
      cell.value = lastPotentialValueOfCell;
      peers = [grid peersOfSudokuCell:cell];
      for (SudokuCell* peerCell in peers) {
        
        [self eliminateValue:lastPotentialValueOfCell fromSudokuCell:peerCell inMacroGrid:grid];
      }
      break;
      
    default:
      /* Do nothting. */
      break;
  }
  
  /* If a super set (row/column/micro_grid) is having only one possible cell for a value, then assign
   * the value to that cell.
   */
  superSet = [grid superSetOfSudokuCell:cell];
  setOfCellsIndexes = [[NSMutableIndexSet alloc] init];
  [superSet enumerateObjectsUsingBlock:^(SudokuCell* cellInSuperSet, NSUInteger cellIndex, BOOL* shouldStop){
    if ([cellInSuperSet.potentialSolutionSet containsIndex:value]) {
      [setOfCellsIndexes addIndex:cellIndex];
      *shouldStop = NO;
    }
  }];

  
  switch (setOfCellsIndexes.count) {
    case 0:
      /* Contradiction: There is no cell that could have this value. */
      NSAssert(NO, @"Value can't be assigned to any cell");
      return NO;
      break;

    case 1:
      /* Once cell can only have the value(d), so assign the value(d) to the cell. */
      targetCell = [superSet objectAtIndex:[setOfCellsIndexes firstIndex]];
      return [self assignValue:value toSudokuCell:targetCell inMacroGrid:grid];
      break;
      
    default:
      /* Do nothing. */
      break;
  }
  
  return YES;
}

@end
