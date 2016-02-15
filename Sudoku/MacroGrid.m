//
//  MacroGrid.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-12.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "MacroGrid.h"
#import "MicroGrid.h"

#define NUM_OF_CELLS_IN_MACRO_GRID  81
#define NUM_OF_MICRO_GRIDS          9
#define NUM_OF_CELLS_PER_ROW        9
#define NUM_OF_CELLS_PER_COL        9

#define ConvertIndexInto

@interface MacroGrid ()

/* Note that cells property is private so that the interface of the class with outside world stays
 * the same and independent on the actual implementation of the data structure type of the cells
 * property.
 */
@property NSMutableOrderedSet* cellsOfMicroGrids;

@property NSMutableOrderedSet* cells;
@end

@implementation MacroGrid

-(instancetype)init{
  
  NSMutableArray<SudokuCell*>* cellsOfMicroGrids = [[NSMutableArray alloc] init];
  
  /* Create 9 micro grids in the macro grid. */
  for (int i=0; i< NUM_OF_MICRO_GRIDS ; i++) {
    
    MicroGrid* microGrid = [[MicroGrid alloc] init];
    
    /* Get flattened cells of the micro grid. */
    NSArray<SudokuCell*>* flattenedCells = [microGrid getFlattenedCellsArray];
    
    /* add the micro grid cells into cells of the macro grid. */
    [cellsOfMicroGrids addObjectsFromArray:flattenedCells];
  }
  
  return [self initWithMicroGrids:cellsOfMicroGrids];
}

-(instancetype)initWithMicroGrids:(NSArray<SudokuCell *> *)cellsOfMicroGrids{
  
  if (nil == cellsOfMicroGrids) {
    return nil;
  }
  
  if (NUM_OF_CELLS_IN_MACRO_GRID != cellsOfMicroGrids.count) {
    return nil;
  }
  
  self = [super init];
  
  self.cellsOfMicroGrids = [NSMutableOrderedSet orderedSetWithArray:cellsOfMicroGrids];
  self.cells             = [[NSMutableOrderedSet alloc] init];

  /* Reorder cells of macro grid to be easily integerated with Collection View Data soure. */
  for (int n=0, i=0; n<NUM_OF_MICRO_GRIDS; n++) {
    NSMutableIndexSet* setOfIndexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(i, 3)];
    [setOfIndexes addIndexesInRange:NSMakeRange(i+9, 3)];
    [setOfIndexes addIndexesInRange:NSMakeRange(i+18, 3)];
    
    NSArray* macroRow = [self.cellsOfMicroGrids objectsAtIndexes:setOfIndexes];
    [self.cells addObjectsFromArray:macroRow];
    i += ((2 == n%3)? 21:3);
  }

#if UNIT_TESTING
  [MicroGrid resetCount];
#endif
  return self;
}

-(NSArray<SudokuCell *> *)getRowForCellAtIndex:(NSUInteger)index{
  if (NUM_OF_CELLS_IN_MACRO_GRID > index) {
    
    /* Row index is calculated through dividing given index by number of cells per row. */
    NSUInteger rowIndex = index/NUM_OF_CELLS_PER_ROW;

    /* return the row at the relative index. */
    return [self getRowAtIndex:rowIndex];
  }else{
    return nil;
  }
}

-(NSArray<SudokuCell *> *)getColumnForCellAtIndex:(NSUInteger)index{
  if (NUM_OF_CELLS_IN_MACRO_GRID > index) {

    /* Colum number is calculated by getting the remainder of dividing given index by
     * number of cells per colum.
     */
    NSUInteger columnIndex = (index % NUM_OF_CELLS_PER_COL);
    
    /* return the column at the relative index. */
    return [self getColumnAtIndex:columnIndex];
  }else{
    return nil;
  }
}

-(NSArray<SudokuCell *> *)getRowAtIndex:(NSUInteger)index{
  
  if (NUM_OF_CELLS_PER_ROW > index) {
    
    /* Create a range of consecutive indexes since cells of any macro grid are actually
     * represented by flattend data structure.
     * Requesting row at index n, means that cells[n+i]: i=0->8
     * should be returned from the method.
     */
    
    /* Create set of indexes of the cells that construct the row by creating a NSRange. */
    NSRange range = NSMakeRange(index * NUM_OF_CELLS_PER_ROW,  NUM_OF_CELLS_PER_ROW);
    NSIndexSet* setOfIndexes = [NSIndexSet indexSetWithIndexesInRange:range];
    
    /* Return the cells of the given indexes. */
    return [self.cells objectsAtIndexes:setOfIndexes];
    
  }else{
    return nil;
  }
}

-(NSArray<SudokuCell *> *)getColumnAtIndex:(NSUInteger)index{
  
  if (NUM_OF_CELLS_PER_COL > index) {
    
    /* Since the cells of any macro grid are represented by flattened data structure,
     * Requesting column at index n, means that cells[n+9*i]: i=0->8
     */
    
    /* Create set of indexes of the cells that construct the column by create mutable index set.
     * Can't use NSRange since the objects are not consecutive.
     */
    
    /* Add index of first cell in the column. */
    NSMutableIndexSet* setOfIndexes = [NSMutableIndexSet indexSetWithIndex:index];
    
    for (int i=0; i<NUM_OF_CELLS_PER_COL-1; i++) {
      /* Add index of the next cell in the column. */
      index+=NUM_OF_CELLS_PER_ROW;
      [setOfIndexes addIndex:index];
    }
    
    /* Return the cells of the given indexes. */
    return [self.cells objectsAtIndexes:setOfIndexes];
    
  }else{
    return nil;
  }
}

-(SudokuCell *)getSudokuCellAtRowColumn:(RowColPair)pair{
  
  if (NUM_OF_CELLS_PER_ROW > pair.row  && NUM_OF_CELLS_PER_COL > pair.column) {
    
    /* Since the cells of any micro grid are represented by flattened data structure,
     * Requesting cell at row n & column m, means that the cell is actually is at index = n*3+m
     */
    NSUInteger index = convertPairToIndex(pair);
    
    /* return the cell of the given row/column pair. */    
    return [self.cells objectAtIndex:index];
    
  }else{
    
    return nil;
  }
}

-(NSUInteger)indexOfSudokuCell:(SudokuCell *)cell{
  return [self.cells indexOfObject:cell];
}

-(NSArray<SudokuCell *> *)superSetOfSudokuCell:(SudokuCell *)cell{
  
  /* Get index of the sudoku cell in the macro grid. */
  NSUInteger index = [self indexOfSudokuCell:cell];

  if (NUM_OF_CELLS_IN_MACRO_GRID > index) {
    /* Convert the index into row/column pair structure.*/
    RowColPair pair = convertIndexToPair(index);
    
    NSArray* cellsOfRow       = [self getRowAtIndex:pair.row];
    NSArray* cellsOfColumn    = [self getColumnAtIndex:pair.column];
    NSArray* cellsOfMicroGrid = [self getMicroGridForSudokuCell:cell];
    
    /* Construct a set of all obtained cells. */
    
    /* TODO: What about returning NSSet for each of the previous getters methods. */
    NSMutableOrderedSet* superSet = [NSMutableOrderedSet orderedSetWithArray:cellsOfRow];
    [superSet addObjectsFromArray:cellsOfColumn];
    [superSet addObjectsFromArray:cellsOfMicroGrid];
    return superSet.array;
  }else{
    return nil;
  }
}

-(NSArray<SudokuCell *> *)peersOfSudokuCell:(SudokuCell *)cell{

  /* Get the super set of the cell, then remove the cell from its super set. */
  NSArray* superSet = [self superSetOfSudokuCell:cell];
  if(nil != superSet){
    NSMutableArray* peers = [NSMutableArray arrayWithArray:superSet];
    [peers removeObject:cell];
    
    return peers;
  }else{
    return nil;
  }
}

-(NSArray<SudokuCell*>*) getMicroGridForSudokuCell: (SudokuCell*) cell{
  
  /* Get index of the cell in the micro grid cells. */
  NSUInteger index = [self.cellsOfMicroGrids indexOfObject:cell];
  
  if ((NUM_OF_CELLS_IN_MACRO_GRID > index) ) {
    
    /* Divide index by number of micro grids to get the actual index of the micro grid.*/
    index /= NUM_OF_MICRO_GRIDS;
    
    /* Create set of indexes of the cells that construct the row by creating a NSRange. */
    NSRange range = NSMakeRange(index * NUM_OF_CELLS_PER_ROW,  NUM_OF_CELLS_PER_ROW);
    NSIndexSet* setOfIndexes = [NSIndexSet indexSetWithIndexesInRange:range];
    
    /* Return the cells of the given indexes. */
    return [self.cellsOfMicroGrids objectsAtIndexes:setOfIndexes];
  }else{
    return nil;
  }
}

-(NSUInteger)numOfCells{
  return self.cells.count;
}

#if UNIT_TESTING
-(NSArray<SudokuCell*>*) getFlattenedMicroGridsCellsArray{
  NSIndexSet* setOfIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, NUM_OF_CELLS_IN_MACRO_GRID)];
  return [self.cellsOfMicroGrids objectsAtIndexes:setOfIndexes];
}
#endif

@end
