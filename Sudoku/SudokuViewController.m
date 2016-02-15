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
#define QLIK_LOGO_COLOR         [UIColor colorWithRed:0.38 green:0.651 blue:0.157 alpha:1]
#define RED_COLOR               [UIColor redColor]
#define NO_COLOR                [UIColor clearColor]

@interface SudokuViewController ()
@property (weak, nonatomic) IBOutlet SudokuBoard *sudokuCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *solveBtn;
@property (weak, nonatomic) IBOutlet UIButton *setupGameDoneBtn;
@property (strong,nonatomic) SudokuDataSource* dataSource;
@property (strong, nonatomic) NSIndexPath* lastSelectedIndexPath;
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
    LabelCell* myCell = (LabelCell*) cell;
    myCell.textLabel.text = [self.dataSource getValueOfSudokuCellAtIndexPath:indexPath];
  }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  /* Display feedback visual effect for the selected cell. */
  [self displayVisualEffectForSelectedCellAtIndexPath:indexPath];
  
  /* update last selected index path. */
  self.lastSelectedIndexPath = indexPath;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  /* Get the exact cell view that was selected by user. */
  UICollectionViewCell* cell = [self.sudokuCollectionView cellForItemAtIndexPath:indexPath];
  
  /* Reset border width to zero so it should be removed and the content of the cell already
   * consists of UIBezier path, that is why default thin black border around every cell still
   * exists even after reseting the border here to zero. */
  cell.layer.borderWidth = 0;
  
  /* Hide the drop shadow of the deselected cell.*/
  cell.layer.shadowOpacity = 0;
}

#pragma Collection View Flow Layout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

  CGFloat cellWidth  = self.sudokuCollectionView.bounds.size.width/NUM_OF_MACRO_CELLS;
  CGFloat cellHeight = self.sudokuCollectionView.bounds.size.height/NUM_OF_MACRO_CELLS;
  
  return CGSizeMake(cellWidth, cellHeight);
}

#pragma actions

- (IBAction)onTapSetupGameDone:(UIButton*)setupGameDoneBtn {

  if ([setupGameDoneBtn.titleLabel.text isEqualToString:SETUP_GAME_BTN_TITLE]) {
    
    /* Set the mode of the grid to new game creation */
    self.sudokuCollectionView.shouldSetupNewGame = YES;
    
    /* Change the title of the button*/
    [self.setupGameDoneBtn setTitle:DONE_BTN_TITLE forState:UIControlStateNormal] ;
    
    /* Disbale other buttons in the stack view. */
    self.clearBtn.enabled = NO;
    self.solveBtn.enabled = NO;
    
  }else{
    
    /* Set the mode of the grid to play mode */
    self.sudokuCollectionView.shouldSetupNewGame = NO;
    
    /* Change the title of the button*/
    [self.setupGameDoneBtn setTitle:SETUP_GAME_BTN_TITLE forState:UIControlStateNormal];
    
    /* Disbale other buttons in the stack view. */
    self.clearBtn.enabled = YES;
    self.solveBtn.enabled = YES;
    
  }
  
}
- (IBAction)onTapSolve:(id)sender {
  [self.solution solveSudokuGrid: self.dataSource.grid];
}

- (IBAction)onTapSave:(id)sender {
}

- (IBAction)onTapClear:(id)sender {
}

-(IBAction)onTapNuemricBtn:(UIButton*)numericBtn{
  
  SudokuCell* cell = [self.dataSource sudokuCellAtIndexPath:self.lastSelectedIndexPath];
  
  if (nil == cell) {
    return;
  }
  
  [self.solution updateSudokuCell:cell inMacroGrid:self.dataSource.grid withValue:numericBtn.titleLabel.text.integerValue];

}

#pragma Solution Delegate

- (void) reloadCollectionViewCell{
  /* Reload the cell of the collection view at the given indexPath. */
  [self.sudokuCollectionView reloadItemsAtIndexPaths:@[self.lastSelectedIndexPath]];
  
  /* After reloading the collection view cell, it seems that the collection view is not longer
   * saving that the cell was selected.
   * As per Apple documentation, the following method does not cause any selection-related delegate
   * methods to be called.
   */
  [self.sudokuCollectionView selectItemAtIndexPath:self.lastSelectedIndexPath
                                          animated:NO
                                    scrollPosition:UICollectionViewScrollPositionNone];
  
}

- (void)didFinishUpdateValueOfSudokuCell:(SudokuCell *)cell{
  
  [self reloadCollectionViewCell];
  
  /* Make sure to keep the same visual effect for the reloaded selected cell.*/
  [self displayVisualEffectForSelectedCellAtIndexPath:self.lastSelectedIndexPath];
}

-(void)didFailToInsertValueOfSudokuCell:(SudokuCell *)cell{

  [self reloadCollectionViewCell];
  
  /* Get reference to the last selected cell. */
  UICollectionViewCell* selectedCell = [self.sudokuCollectionView cellForItemAtIndexPath:self.lastSelectedIndexPath];
  
  /* Highlight its borders and shadow color to red. */
  selectedCell.layer.shadowColor = RED_COLOR.CGColor;
  selectedCell.layer.borderColor = RED_COLOR.CGColor;
  
  /* Set the bakcgroundColor to transparent red color. */
  selectedCell.backgroundColor = [RED_COLOR colorWithAlphaComponent:0.3];
}

#pragma internal methods
- (void) displayVisualEffectForSelectedCellAtIndexPath: (NSIndexPath*) indexPath{
  
  /* Get the exact cell view that was selected by user. */
  UICollectionViewCell* cell = [self.sudokuCollectionView cellForItemAtIndexPath:indexPath];
  
  /* Change border color and width of for the cell. */
  cell.layer.borderColor = QLIK_LOGO_COLOR.CGColor;
  cell.layer.borderWidth = 1.5;
  
  /* Add inner drop shadow to the cell. */
  cell.layer.shadowColor = QLIK_LOGO_COLOR.CGColor;
  cell.layer.shadowOpacity = 0.8;
  
  cell.backgroundColor = NO_COLOR;
}
@end
