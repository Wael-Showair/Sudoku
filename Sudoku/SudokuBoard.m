//
//  SudokuBoard.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuBoard.h"

#define GRID_BORDER_WIDTH   2.0
#define GRID_BORDER_COLOR   [UIColor blackColor]

@interface SudokuBoard ()
@property (strong, nonatomic) NSMutableArray* paths;
@end
@implementation SudokuBoard

- (void)awakeFromNib{
  self.layer.borderColor = GRID_BORDER_COLOR.CGColor;
  self.layer.borderWidth = GRID_BORDER_WIDTH;
}

- (void)drawRect:(CGRect)bounds {
  CGFloat width = CGRectGetWidth(bounds);
  CGFloat height = CGRectGetMaxY(bounds);
  
  /* Draw bezier path with the bounds of the view bounds. */
  UIBezierPath* rootPath = [UIBezierPath bezierPathWithRect:bounds];

  /* Draw bezier path for the vertical lines. */
  UIBezierPath* verticalLinePath = [[UIBezierPath alloc] init];

  /* Append the vertical line path to the root path. */
  [rootPath appendPath:verticalLinePath];
  
  /* Set the stroke of the lines. */
  [GRID_BORDER_COLOR setStroke];
  [verticalLinePath stroke];
  verticalLinePath.lineWidth = GRID_BORDER_WIDTH;
  
  /* Draw the first vertical line path. */
  [verticalLinePath moveToPoint   :CGPointMake(width/3, CGRectGetMinY(bounds))];
  [verticalLinePath addLineToPoint:CGPointMake(width/3, CGRectGetMaxY(bounds))];

  /* Draw the second vertical line path. */
  [verticalLinePath moveToPoint   :CGPointMake(2*width/3, CGRectGetMinY(bounds))];
  [verticalLinePath addLineToPoint:CGPointMake(2*width/3, CGRectGetMaxY(bounds))];
  
  /* Draw the first horizontal line path */
  [verticalLinePath moveToPoint:CGPointMake(CGRectGetMinX(bounds), height/3)];
  [verticalLinePath addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), height/3)];
  
  /* Draw the first horizontal line path */
  [verticalLinePath moveToPoint:CGPointMake(CGRectGetMinX(bounds), 2*height/3)];
  [verticalLinePath addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), 2*height/3)];
  
  /* Apply the stroke color to all paths.*/
  [verticalLinePath stroke];
}


@end
