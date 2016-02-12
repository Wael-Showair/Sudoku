//
//  RowColPair.h
//  Sudoku
//
//  Created by Wael Showair on 2016-02-12.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#ifndef RowColPair_h
#define RowColPair_h

#include <stdio.h>
typedef struct _RowColPair{
  unsigned long row;
  unsigned long column;
}RowColPair;

RowColPair makeRowColPair (unsigned long row, unsigned long column);

#endif /* RowColPair_h */
