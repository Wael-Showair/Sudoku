//
//  SudokuDataSource.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SudokuDataSource : NSObject <UICollectionViewDataSource>

-(NSString*) getValueOfSudokuCellAtIndexPath: (NSIndexPath*) indexPath;
-(void)      setValueOfSudokuCellAtIndexPath: (NSIndexPath*) indexPath WithValue:(NSString*) value;

@end
