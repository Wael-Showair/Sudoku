# README #

This is a fun iOS application to solve Sudoku grids programmatically.

### 1. Summary ###

* The app targets only iOS (9.0+) platform for iPhone and iPad devices. All credits go to **Peter Norvig** for the derivation of the algorithm used to solve the Sudoku grids . You can find detailed information about his algorithm in [this link][1].Also you can find an overview about the software architecture of the app in the Keynote file [sudoku.key][2]

### 2. Technical Details ###

* Objective C is the programming language used to develop the app.
* Test Driven Developement ( **TDD** ) is the methodology used from the early begining of the app development.
* Interface Builder Storyboards are used to design UI of the app using Auto Layout. The Sudoku Board grid is not a raster image. Instead It is a Vector image created by Bezier Paths using **UIBezierPath** class. Thus the grid is adaptive for any screen resolution and dimension.
* Sufficient UI Testing and Unit Tests have been done to ensure correct app functionality and  high percentage of Code Coverage (about 93%).
* Xcode is the IDE that is used during the development of the app.

### 3. App Building & Deployment ###

* Using the latest version of Xcode IDE 7.2

### 3.1 App Building ###

Check out the source code in this repository using "Source Code"->"Check out". Then Enter the following URL in the "repository location" box: https://github.com/Wael-Showair/sudoku.git

There are three build configuration for the app **Debug**, **Release** & **Testing**. The first two configurations are created by default for any iOS project created by Xcode. The **Testing Build Configuration** is created by me to have more control on some code blocks while executing Unit Tests. Please note that **Test Build Configuration** is duplicated from **Debug Build Configuration**.

As for the Sudoku target build, there are two preprocessor macros (**UNIT_TESTING** and **DEBUG_SOLVED_GRIDS**) that I have defined to help me control the different code blocks during the execution of the UNIT/UI Tests. These preprocessor macros are only defined for **Testing Build Configuration**.

Note: you don't need to change anything to build and run the application.

### 3.2 App Deployment ###

 
There are two ways for the user to add input to the Sudoku grid:

1. You can add numbers to the rows through the file "**sudoku_grid.plist**".

2.  You can add numbers to each sub grid through the file "**sudoku_grid_in_micro_grids.plist**".

Note: In either cases, an unresolved square is represeted by zero and users should not change the names of the keys.

Afterwards, It is straight forward. Just build and run the corresponding Xcode Scheme then press "Solve" button.
The bottom bar that contains the numeric buttons is just for display, there is no related action with these buttons.

### 4. Contact Me ###

* For further questions or discussion, [email me](mailto:showair.wael@gmail.com) or check my[ personal website][3] 





[1]:http://norvig.com/sudoku.html
[2]:https://github.com/Wael-Showair/sudoku/blob/master/sudoku.key
[3]:http://waelshowair.com
