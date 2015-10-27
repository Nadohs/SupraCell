# SupraCell ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

SupraCell is cell/xib template designed to make swipe-able cell design easier by putting the buttons and main content all on one view.  



![demo_swipe](https://github.com/Nadohs/SupraCell/blob/master/Media/demo_1.gif)




###Installation
  * Move contents of *Template* folder into the path below, replacing USERNAME with yours.
**~/Users/USERNAME/Library/Developer/Xcode/Templates/**

###Usage


![template](https://github.com/Nadohs/SupraCell/blob/master/Media/template.png)


  * Create a new file and select the SupraCell tab.

  * Before creating your first **NewSupraCell** from template create a **BaseSupraCell** to add the base class for your custom cell class.

  * Create a NewSupraCell from template, and design cell in xib [(see design section)](#Design) 

  * Add cell to UITableView in the normal way etc.
If the xib name and cellIdentifer name are the same can use `tableView.useCell(identifier:String)`

**NOTE:** template makes these the same by default

` tableView.useCell("FirstSupraCell")`

###Design

![design](https://github.com/Nadohs/SupraCell/blob/master/Media/cell1.png)

Cell is separated into 3 views

**|---leftView---||---mainView--||---rightView--|**

These views adjust to fit the tableView, so you should use autolayouts to constrain your views within these.

The autolayouts are already preset for these such that:

  * mainView width is tableView width.

  * leftView/rightView widths are fixed, but you can adjust them accordingly



	
