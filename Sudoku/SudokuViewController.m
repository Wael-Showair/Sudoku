//
//  ViewController.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuViewController.h"
#import "SudokuDataSource.h"
#import "LabelCell.h"
#import "SudokuBoard.h"

@interface SudokuViewController ()
@property (weak, nonatomic) IBOutlet SudokuBoard *sudokuCollectionView;
@property (strong,nonatomic) SudokuDataSource* dataSource;
@end

@implementation SudokuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /* Set the data source of the collection view. */
  SudokuDataSource* dataSource = [[SudokuDataSource alloc] init];
  self.dataSource = dataSource;
  self.sudokuCollectionView.dataSource = dataSource;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}

#pragma Collection View Delegate
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

  if ([CELL_IDENTIFIER isEqualToString:[cell reuseIdentifier]]) {
    LabelCell* myCell = (LabelCell*) cell;
    myCell.textLabel.text = [self.dataSource getLabelAtIndexPath:indexPath];
  }
}

#pragma Collection View Flow Layout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

  CGFloat cellWidth  = self.sudokuCollectionView.bounds.size.width/NUM_OF_MACRO_CELLS;
  CGFloat cellHeight = self.sudokuCollectionView.bounds.size.height/NUM_OF_MACRO_CELLS;
  
  return CGSizeMake(cellWidth, cellHeight);
}
@end
