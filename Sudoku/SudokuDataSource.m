//
//  SudokuDataSource.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuDataSource.h"
#import "LabelCell.h"


@interface SudokuDataSource ()
@property NSArray* dummy;
@end
@implementation SudokuDataSource

-(instancetype)init{
  self = [super init];
  self.dummy = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9"];
  return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return  self.dummy.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
  
  return cell;
}


-(NSString*) getLabelAtIndexPath: (NSIndexPath*) indexPath{
 return [self.dummy objectAtIndex:indexPath.row];
}
@end
