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