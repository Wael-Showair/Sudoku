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

/* According to C99 standard, inline functions can't be accessed from outside its source code
 * files unless extern keyword is added.
 */
extern  RowColPair    convertIndexToPair(unsigned long index);
extern  unsigned long convertPairToIndex(RowColPair pair);

#endif /* RowColPair_h */
