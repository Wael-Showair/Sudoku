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

-(NSString*) getLabelAtIndexPath: (NSIndexPath*) indexPath;

@end
