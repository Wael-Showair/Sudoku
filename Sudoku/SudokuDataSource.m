//
//  SudokuDataSource.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuDataSource.h"
#import "LabelCell.h"
#import "MacroGrid.h"

#define NUM_OF_CELLS_PER_ROW        9

@interface SudokuDataSource ()
@property MacroGrid* grid;
@end

@implementation SudokuDataSource

-(instancetype)init{
  self = [super init];
  self.grid = [[MacroGrid alloc] init];
  return self;
}

#pragma Collection View Data Source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return  [self.grid numOfCells];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
  
  return cell;
}

#pragma Sudoku Cell Connection with IndexPath

-(NSString*) getValueOfSudokuCellAtIndexPath: (NSIndexPath*) indexPath{

  /* Note that I can change the method signature to take the index of the flattened array directly
   * But for now, for the sake of code readability, converting index =>RowColPair structure => index
   * does not harm the performance.
   */
  
  /* Get the row index as well as the column index of the cell. */
  NSUInteger rowIndex    = indexPath.row / NUM_OF_CELLS_PER_ROW;
  NSUInteger columnIndex = indexPath.row % NUM_OF_CELLS_PER_ROW;
  
  /* Get the sudoku cell from the given row and column. */
  SudokuCell* sudokuCell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(rowIndex, columnIndex)];
  
  /* Display the value as string in the grid. */
  return [NSString stringWithFormat:@"%ld",sudokuCell.value];
}

-(void)setValueOfSudokuCellAtIndexPath:(NSIndexPath *)indexPath WithValue: (NSString*) value{
  
  /* Note that I can change the method signature to take the index of the flattened array directly
   * But for now, for the sake of code readability, converting index =>RowColPair structure => index
   * does not harm the performance.
   */
  
  /* Get the row index as well as the column index of the cell. */
  NSUInteger rowIndex    = indexPath.row / NUM_OF_CELLS_PER_ROW;
  NSUInteger columnIndex = indexPath.row % NUM_OF_CELLS_PER_ROW;
  
  /* Get the sudoku cell from the given row and column. */
  SudokuCell* sudokuCell = [self.grid getSudokuCellAtRowColumn:makeRowColPair(rowIndex, columnIndex)];
  
  sudokuCell.value = value.intValue;
}
@end
