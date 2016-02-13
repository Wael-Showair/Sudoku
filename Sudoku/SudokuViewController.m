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

#define SETUP_GAME_BTN_TITLE    @"Setup Game"
#define DONE_BTN_TITLE        @"Done"

@interface SudokuViewController ()
@property (weak, nonatomic) IBOutlet SudokuBoard *sudokuCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *solveBtn;
@property (weak, nonatomic) IBOutlet UIButton *setupGameDoneBtn;
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

#pragma actions

- (IBAction)onTapNewGame:(UIButton*)newGameDoneBtn {

  if ([newGameDoneBtn.titleLabel.text isEqualToString:SETUP_GAME_BTN_TITLE]) {
    
    /* Set the mode of the grid to new game creation */
    self.sudokuCollectionView.shouldCreateNewGame = YES;
    
    /* Change the title of the button*/
    [self.setupGameDoneBtn setTitle:DONE_BTN_TITLE forState:UIControlStateNormal] ;
    
    /* Disbale other buttons in the stack view. */
    self.clearBtn.enabled = NO;
    self.solveBtn.enabled = NO;
    
  }else{
    
    /* Set the mode of the grid to play mode */
    self.sudokuCollectionView.shouldCreateNewGame = NO;
    
    /* Change the title of the button*/
    [self.setupGameDoneBtn setTitle:SETUP_GAME_BTN_TITLE forState:UIControlStateNormal];
    
    /* Disbale other buttons in the stack view. */
    self.clearBtn.enabled = YES;
    self.solveBtn.enabled = YES;
    
  }
  
}

- (IBAction)onTapSave:(id)sender {
}

- (IBAction)onTapClear:(id)sender {
}

@end
