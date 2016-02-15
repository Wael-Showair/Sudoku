//
//  SudokuParser.m
//  Sudoku
//
//  Created by Wael Showair on 2016-02-14.
//  Copyright © 2016 Algonquin College. All rights reserved.
//

#import "SudokuParser.h"

#define PROPERTY_LIST_FILE_NAME      @"sudoku_grid"
#define PROPERTY_LIST_FILE_EXTENSION @"plist"
#define MIN_VALUE_ACCEPTED            0
#define LENGTH_OF_ACCEPTED_VALUES     10
#define NUM_OF_CELLS_IN_MACRO_GRID    81

@interface SudokuParser ()
@property (readwrite) NSRange acceptableRange;

@end

@implementation SudokuParser

-(instancetype)init{
  
  self = [super init];
  
  /* Accepted number are only from 0 to 9 (i.e. they are 10 numbers.)*/
  self.acceptableRange = NSMakeRange(MIN_VALUE_ACCEPTED, LENGTH_OF_ACCEPTED_VALUES);
  
  return self;
}

-(MacroGrid*)parseGridFromPropertyListFile:(NSString*) plistFileName{
  
  if(nil == plistFileName){
    return nil;
  }
  
  /* In Objective C, it is a must to add __block type specifier if the variable will be modified in Block*/
  __block BOOL canParseInputGrid = YES;
  
  /* Create an array to hold cells of the micro grid in it.*/
  NSMutableArray<SudokuCell*>* cellsOfMicroGrids = [[NSMutableArray alloc] initWithCapacity:NUM_OF_CELLS_IN_MACRO_GRID];
  
  /* Get path of the property list file.*/
  NSString* pathOfPListFile = [[NSBundle mainBundle] pathForResource:plistFileName ofType:PROPERTY_LIST_FILE_EXTENSION];
  
  /* Load the dictionary from the property list file. */
  NSDictionary* inputMacroGrid = [NSDictionary dictionaryWithContentsOfFile:pathOfPListFile];
  NSArray* dictionaryKeys = inputMacroGrid.allKeys;
  dictionaryKeys = [dictionaryKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
  
  for (NSString* key in dictionaryKeys) {
    
    NSArray* inputMicroGrid = [inputMacroGrid objectForKey:key];
    
    /* Iterate over numbers in the micro grid array (in the plist). */
    for (NSNumber* number in inputMicroGrid) {
      
      /* If input number is out of the acceptable range for the cell, break the loop. */
      if (NO == NSLocationInRange(number.intValue, self.acceptableRange)) {
        
        canParseInputGrid = NO;
        break;
        
      }else{
        
        SudokuCell* cell = [[SudokuCell alloc] initWithValue:number.intValue];
        [cellsOfMicroGrids addObject:cell];
      }//else
    }// Loop through micro grid (which is represented by NSArray)
    
    if (NO == canParseInputGrid) {
      break;
    }
  } //Loop through Dictionary keys
  
  /* If there is any error detected in the input micro grids, return nil. */
  if (NO == canParseInputGrid) {
    return nil;
  }

  /* Create the macro grid with the given input cells. */
  return [[MacroGrid alloc] initWithMicroGrids:cellsOfMicroGrids];
}

@end
