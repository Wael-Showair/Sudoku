//
//  SudokuCell.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-11.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuCell.h"

@implementation SudokuCell

#pragma initalization

-(instancetype) init{

  self = [super init];

  /* Initialize the value of the cell to invalid value*/
  return [self initWithValue:INVALID_VALUE];
  
}

-(instancetype) initWithValue: (NSUInteger)value{
  self = [super init];
  
  /* Create a range of numbers from 1 to 9 */
  self.range = NSMakeRange(1, 9);

/* During unit testing, there is no need to override the value that is out of range.*/
#if !UNIT_TESTING
  
  /* If the given value is out of range, set value to invalid value */
  if (!NSLocationInRange(value, self.range)) {
    value = INVALID_VALUE;
  }
  
#endif
  
  self.value = value;
  return self;
}

-(void) setValue:(NSUInteger)value{
  
  if (INVALID_VALUE == value) {
    
    /* Set the potential solution set of the cell */
    self.potentialSolutionSet = [[NSMutableIndexSet alloc] initWithIndexesInRange:self.range];

  }
#if UNIT_TESTING
  else{
    /* Since initial value for testing environment is not invalied value, instead it is 1->81*/
    self.potentialSolutionSet = [[NSMutableIndexSet alloc] initWithIndexesInRange:self.range];
  }
#endif
  //else{
    /* No need to initialize the solution set. */
    //self.potentialSolutionSet = nil;
  //}
  _value = value;
}

#pragma Comparison

/* source: http://nshipster.com/equality/ */

-(BOOL)isEqualToSudokuCell: (SudokuCell*) cell{
  
  if (!cell) {
    return NO;
  }

  /* This is the key factor of deciding whether two cells are logically equal or not.
   * TODO: Perhaps, need to check potential solution set as well. */
  if (self.value != cell.value) {
    return NO;
  }
  
  return YES;
  
}

-(BOOL) isEqual:(id) cell{
  if (self != cell) {
    return NO;
  }
  
  if (![cell isKindOfClass:[SudokuCell class]]) {
   return NO;
  }
  
  return [self isEqualToSudokuCell:cell];
}

#if 0
/* My implementation of the hash method prevents the data structure that constructs the grid cells
 * from retrieving the index of a given cell.
 */
-(NSUInteger)hash{
  
  /* hash implementations might be improved by bit-shifting or rotating composite values that may overlap.*/
  return self.value ^ [self.potentialSolutionSet hash];
}
#endif
#pragma actions

-(void)eliminateNumberFromSolutionSet:(NSUInteger)number{
  
  if(!NSLocationInRange(number, self.range) ||
     ![self.potentialSolutionSet containsIndex:number]){
    return;
  }

  /* Remove the given number from the current potentional solution set. */
  [self.potentialSolutionSet removeIndex:number];
}

@end
