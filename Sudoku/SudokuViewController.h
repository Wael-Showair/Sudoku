//
//  ViewController.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuDataSource.h"
#import "LabelCell.h"
#import "SudokuBoard.h"
#import "SudokuSolution.h"

@interface SudokuViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SudokuSolutionDelegate>


@end

