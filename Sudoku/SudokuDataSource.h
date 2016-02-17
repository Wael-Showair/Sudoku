//
//  SudokuDataSource.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SudokuCell.h"
#import "MacroGrid.h"

@interface SudokuDataSource : NSObject <UICollectionViewDataSource>
@property (strong, nonatomic)MacroGrid* grid;

-(NSString*) getValueOfSudokuCellAtIndexPath: (NSIndexPath*) indexPath;

-(SudokuCell*) sudokuCellAtIndexPath: (NSIndexPath*) indexPath;

@end
