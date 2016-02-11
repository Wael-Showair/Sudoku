//
//  LabelCell.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-10.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_IDENTIFIER @"label-cell"
@interface LabelCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
