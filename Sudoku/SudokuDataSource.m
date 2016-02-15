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

  /* Get the sudoku cell from the given index path. */
  SudokuCell* sudokuCell = [self sudokuCellAtIndexPath:indexPath];
  
  if (INVALID_VALUE == sudokuCell.value) {
    /* Display empty value as string in the grid. */
    return @"";
  } else {
    /* Display the value as string in the grid. */
    return [NSString stringWithFormat:@"%ld",sudokuCell.value];
  }
}

-(void)setValueOfSudokuCellAtIndexPath:(NSIndexPath *)indexPath WithValue: (NSString*) value{
  
  SudokuCell* sudokuCell = [self sudokuCellAtIndexPath:indexPath];
  sudokuCell.value = value.intValue;
}

-(SudokuCell*) sudokuCellAtIndexPath: (NSIndexPath*) indexPath{
 
  /* Note that I can change the method signature to take the index of the flattened array directly
   * But for now, for the sake of code readability, converting index =>RowColPair structure => index
   * does not harm the performance.
   */
  
  if (nil == indexPath) {
    return nil;
  }
  
  /* Convert index path to row/column pair structure. */
  RowColPair pair =  convertIndexToPair(indexPath.row);
  
  /* Get the sudoku cell from the given row and column. */
  return [self.grid getSudokuCellAtRowColumn:pair];

}

@end
