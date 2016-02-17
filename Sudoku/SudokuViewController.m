//
//  ViewController.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuViewController.h"


#define SETUP_GAME_BTN_TITLE    @"Setup Game"
#define DONE_BTN_TITLE          @"Done"
#define EMPTY_STRING            @""
#define GREEN_COLOR             [UIColor colorWithRed:0.376 green:0.655 blue:0.161 alpha:1] /*#60a729*/
#define GREEN_COLOR_TRANSPARENT [UIColor colorWithRed:0.376 green:0.655 blue:0.161 alpha:0.1] /*#60a729*/
#define RED_COLOR               [UIColor redColor]
#define NO_COLOR                [UIColor clearColor]
#define GREY_COLOR              [UIColor colorWithRed:0.431 green:0.431 blue:0.431 alpha:0.2] /*#6e6e6e*/

@interface SudokuViewController ()
@property (weak, nonatomic) IBOutlet SudokuBoard *sudokuCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *solveBtn;

@property (strong,nonatomic) SudokuDataSource* dataSource;
@property (strong, nonatomic) SudokuSolution* solution;
@end

@implementation SudokuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  /* Set the data source of the collection view. */
  SudokuDataSource* dataSource = [[SudokuDataSource alloc] init];
  self.dataSource = dataSource;
  self.sudokuCollectionView.dataSource = dataSource;
  self.solution = [[SudokuSolution alloc] init];
  self.solution.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}

#pragma Collection View Delegate

-(void)collectionView:(UICollectionView *)collectionView
      willDisplayCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath{

  if ([CELL_IDENTIFIER isEqualToString:[cell reuseIdentifier]]) {
    LabelCell* labelCell = (LabelCell*) cell;
    labelCell.textLabel.text = [self.dataSource getValueOfSudokuCellAtIndexPath:indexPath];
    if (NO == [labelCell.textLabel.text isEqualToString:EMPTY_STRING]) {
      [self applyVisualEffectForInitialCell:labelCell];
    }
  }
}

#pragma Collection View Flow Layout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

  CGFloat cellWidth  = self.sudokuCollectionView.bounds.size.width/NUM_OF_MACRO_CELLS;
  CGFloat cellHeight = self.sudokuCollectionView.bounds.size.height/NUM_OF_MACRO_CELLS;
  
  return CGSizeMake(cellWidth, cellHeight);
}

#pragma actions

- (IBAction)onTapSolve:(id)sender {
  MacroGrid* grid = self.dataSource.grid;
  [self.solution solveSudokuGrid: &grid];
}

#pragma Solution Delegate

- (void)solver:(SudokuSolution *)solver didFailToSolveSudokuGrid:(MacroGrid *)grid{
  
}

-(void)solver:(SudokuSolution *)solver didSolveSudokuGrid:(MacroGrid *)grid withUpdatedIndexes:(NSIndexSet *)indexes{

  /* assigne the solved grid cells to the data source. */
  self.dataSource.grid = grid;

  /* Get indexe paths for the given indexes. */
  NSArray<NSIndexPath*>* indexPaths = [self constructIndexPathsFromIndexes:indexes];
  
  /* Reload the cells of the collection view for the upated cells. */
  [self reloadCollectionViewCellsAtIndexPaths:indexPaths];
  
}

#pragma internal methods

-(NSArray<NSIndexPath*>*)constructIndexPathsFromIndexes: (NSIndexSet*)indexes{
  NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray arrayWithCapacity:indexes.count];
  [indexes enumerateIndexesUsingBlock:^(NSUInteger indexOfUpdatedCell, BOOL* shouldStop){
    [indexPaths addObject:[NSIndexPath indexPathForItem:indexOfUpdatedCell inSection:0]];
    *shouldStop = NO;
  }];
  
  return indexPaths;
}

- (void) reloadCollectionViewCellsAtIndexPaths:(NSArray<NSIndexPath*>*) indexPaths{
  
  if (nil == indexPaths) {
    return;
  }
  
  /* Reload the cell of the collection view at the given indexPath. */
  [self.sudokuCollectionView reloadItemsAtIndexPaths:indexPaths];
  
  /* For every updated cell (solved by the algorithm), change its appearance.*/
  for (NSIndexPath* indexPath in indexPaths) {
    [self applyVisualEffectForSolvedCellAtIndexPath:indexPath];
  }
}

- (void) applyVisualEffectForSolvedCellAtIndexPath: (NSIndexPath*) indexPath{
  
  /* Get the exact cell view that was selected by user. */
  LabelCell* cell = (LabelCell*)[self.sudokuCollectionView cellForItemAtIndexPath:indexPath];
  
  cell.backgroundColor = GREEN_COLOR_TRANSPARENT;
}

-(void) applyVisualEffectForInitialCell: (LabelCell*) cell{
  cell.backgroundColor = GREY_COLOR;

}
@end
