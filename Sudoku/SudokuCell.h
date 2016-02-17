//
//  SudokuCell.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-11.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INVALID_VALUE     0

/* This is the smallest unit in Sudoku game.*/
@interface SudokuCell : NSObject <NSCopying>

/* This is the final value of the cell. */
@property (nonatomic) NSUInteger value;

/* Reference to possible solutions in the cell. It should meet the following criteria:
 * 1- Unordered
 * 2- Mutable: an item could be removed from the possible solutions.
 * 3- Existing check must be very fast.
 *
 * Based on these requirements, NSMutableSet/NSMutableIndexedSet.
 */
@property (strong,nonatomic) NSMutableIndexSet* potentialSolutionSet;

+(NSRange) fullRange;

-(instancetype) initWithValue: (NSUInteger)value;

/* Eliminate given number from the solution set of the cell. */
-(void) eliminateNumberFromSolutionSet: (NSUInteger) number;

/* Perform values comparison from logical point of view. */
-(BOOL)isEqualToSudokuCell: (SudokuCell*) cell;

@end
