//
//  SudokuParser.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-14.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroGrid.h"

@interface SudokuParser : NSObject
@property (readonly) NSRange acceptableRange;

-(MacroGrid*) parseGridFromPropertyListFile: (NSString*) plistFileName;
@end
