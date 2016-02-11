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
  
  /* Draw bezier path with the bounds of the view bounds. */
  UIBezierPath* rootPath = [UIBezierPath bezierPathWithRect:bounds];

  /* Draw lines for grid */
  UIBezierPath* linePaths = [self drawGridLinesForRect:bounds withLineWidth:GRID_BORDER_WIDTH];

  /* Append the vertical line path to the root path. */
  [rootPath appendPath:linePaths];
  
  /* Set the stroke of the lines. */
  [GRID_BORDER_COLOR setStroke];
  [linePaths stroke];
  
  
  CGFloat macroGridWidth  = CGRectGetWidth(bounds);
  CGFloat macroGridHeight = CGRectGetMaxY(bounds);

  /* Set the size of the micro cell. */
  self.microCellSize = CGSizeMake(macroGridWidth/9, macroGridHeight/9);
  
  
  /* For each super grid cell, draw the internal lines.
   * TODO: Note that this can be take less processing power by drawing long 12 lines instead
   * of 9 * 4 lines = 36 lines. */
  for (unsigned short col=0; col<3; col++) {
    
    CGFloat x = col * macroGridWidth/3;
    
    for (unsigned short row=0; row<3; row++) {
    
      CGFloat y = row * macroGridHeight/3;
      
      CGRect rect = CGRectMake(x, y, macroGridWidth/3, macroGridHeight/3);
      UIBezierPath* gridPaths = [self drawGridLinesForRect:rect withLineWidth:0.3];
      [rootPath appendPath:gridPaths];
      [gridPaths stroke];
      
    }
  }
}

-(UIBezierPath*) drawGridLinesForRect: (CGRect) bounds withLineWidth: (CGFloat) lineWidth{

  CGFloat width  = CGRectGetWidth(bounds);
  CGFloat height = CGRectGetHeight(bounds);
  
  /* Draw bezier path for the vertical lines. */
  UIBezierPath* linePaths = [[UIBezierPath alloc] init];
  
  linePaths.lineWidth = lineWidth;
  
  /* Draw the first vertical line path. */
  [linePaths moveToPoint   :CGPointMake(CGRectGetMinX(bounds) + width/3, CGRectGetMinY(bounds))];
  [linePaths addLineToPoint:CGPointMake(CGRectGetMinX(bounds) + width/3, CGRectGetMaxY(bounds))];
  
  /* Draw the second vertical line path. */
  [linePaths moveToPoint   :CGPointMake(CGRectGetMinX(bounds) + 2*width/3, CGRectGetMinY(bounds))];
  [linePaths addLineToPoint:CGPointMake(CGRectGetMinX(bounds) + 2*width/3, CGRectGetMaxY(bounds))];
  
  /* Draw the first horizontal line path */
  [linePaths moveToPoint   :CGPointMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds)+ height/3)];
  [linePaths addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), CGRectGetMinY(bounds)+ height/3)];
  
  /* Draw the second horizontal line path */
  [linePaths moveToPoint   :CGPointMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds)+ 2*height/3)];
  [linePaths addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), CGRectGetMinY(bounds)+ 2*height/3)];
  
  return linePaths;

}

@end
