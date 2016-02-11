//
//  SudokuBoard.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NUM_OF_MACRO_CELLS      9

@interface SudokuBoard : UICollectionView
@property CGSize microCellSize;
@property BOOL shouldCreateNewGame;
@end
