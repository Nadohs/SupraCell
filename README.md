# SupraCell

SupraCell is cell/xib template designed to make swipe-able cell design easier by putting the buttons and main content all on one view.  


###Installation
1)Move contents of *Template* folder into the path below, replacing USERNAME with yours.
**~/Users/USERNAME/Library/Developer/Xcode/Templates/**

###Usage
1)Create a new file and select the SupraCell tab.

2)Before creating your first NewSupraCell from template create a BaseSupraCell to add the base class for your custom cell class.

3)Create a NewSupraCell from template, and design cell in xib (see design section) 

4)Add cell to UITableView in the normal way etc.
If the xib name and cellIdentifer name are the same can use `tableView.useCell(identifier:String)`
**NOTE:**template makes these the same by default
` tableView.useCell("FirstSupraCell")`

###Design

Cell is separated into 3 views

|---leftView---||---mainView--||---rightView--|

These views adjust to fit the tableView, so you should use autolayouts to constrain your views within these.

The autolayouts are already preset for these such that:

1)mainView width is tableView width.
2)leftView/rightView widths are fixed, but you can adjust them accordingly



	