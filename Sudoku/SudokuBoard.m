//
//  SudokuBoard.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuBoard.h"
#import "LabelCell.h"

#define GRID_BORDER_WIDTH   2.0
#define GRID_BORDER_COLOR   [UIColor blackColor]
#define LABEL_CELL_NIB      @"LabelCell"

@interface SudokuBoard ()
@property (strong, nonatomic) UIBezierPath* linePaths;
@end
@implementation SudokuBoard

- (void)awakeFromNib{
  self.layer.borderColor = GRID_BORDER_COLOR.CGColor;
  self.layer.borderWidth = GRID_BORDER_WIDTH;
  
  /* Register NIB file of the label cell with the current collection view. */
  UINib* nibFile = [UINib nibWithNibName:LABEL_CELL_NIB bundle:nil];
  [self registerNib:nibFile forCellWithReuseIdentifier:CELL_IDENTIFIER];
}

- (void)drawRect:(CGRect)bounds {
  CGFloat width = CGRectGetWidth(bounds);
  CGFloat height = CGRectGetMaxY(bounds);
  
  /* Draw bezier path with the bounds of the view bounds. */
  UIBezierPath* rootPath = [UIBezierPath bezierPathWithRect:bounds];

  /* Draw bezier path for the vertical lines. */
  UIBezierPath* linePath = [[UIBezierPath alloc] init];

  /* Append the vertical line path to the root path. */
  [rootPath appendPath:linePath];
  
  /* Set the stroke of the lines. */
  [GRID_BORDER_COLOR setStroke];
  [linePath stroke];
  linePath.lineWidth = GRID_BORDER_WIDTH;
  
  /* Draw the first vertical line path. */
  [linePath moveToPoint   :CGPointMake(width/3, CGRectGetMinY(bounds))];
  [linePath addLineToPoint:CGPointMake(width/3, CGRectGetMaxY(bounds))];

  /* Draw the second vertical line path. */
  [linePath moveToPoint   :CGPointMake(2*width/3, CGRectGetMinY(bounds))];
  [linePath addLineToPoint:CGPointMake(2*width/3, CGRectGetMaxY(bounds))];
  
  /* Draw the first horizontal line path */
  [linePath moveToPoint:CGPointMake(CGRectGetMinX(bounds), height/3)];
  [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), height/3)];
  
  /* Draw the second horizontal line path */
  [linePath moveToPoint:CGPointMake(CGRectGetMinX(bounds), 2*height/3)];
  [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), 2*height/3)];
  
  /* Apply the stroke color to all paths.*/
  [linePath stroke];
}


@end
