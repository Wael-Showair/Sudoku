//
//  RowColPair.c
//  Sudoku
//
//  Created by Wael Showair on 2016-02-12.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#include "RowColPair.h"

RowColPair makeRowColPair (unsigned long row, unsigned long column){
  
  RowColPair pair = {row, column};
  return pair;
}

inline unsigned long convertPairToIndex(RowColPair pair){
  return pair.row * 9 + pair.column;
}

inline RowColPair convertIndexToPair(unsigned long index){
  unsigned long row    = index / 9;
  unsigned long column = index % 9;
  
  return  makeRowColPair(row, column);
}