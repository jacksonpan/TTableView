TTableView
==========

UITableView wrapper with block, and iOS7 style <br>

------------------------------------
Requirements
====================================

* iOS 6+ support, iOS 5 not test, you can test it and feedback.
* ARC only

##Basic usage
- (void)initUI
{
    __weak ViewController* _self = self;
    
    _myTableView.enableIOS7Style = YES;
    //_myTableView.enableTransform = YES;
    //[_myTableView setBlockTransform:TTableViewCellTransformFan];

    [_myTableView setBlockNumberOfSections:^NSInteger(TTableView *tableView) {
        return 5;
    }];
    
    [_myTableView setBlockNumberOfRows:^NSInteger(TTableView *tableView, NSInteger section) {
        return 5;
    }];
    
    [_myTableView setBlockCellForRowAtIndexPath:^UITableViewCell *(TTableView *tableView, NSIndexPath *indexPath) {
        ViewCell* cell = [ViewCell loadReuseableFromStoryboard:tableView];
        [cell checkCellWithIndexPath:indexPath tableView:tableView];
        [cell setBlockcellDidReveal:^(id _cell) {
            if(_self.currentSelectCell != _cell)
            {
                //_self.currentSelectCell.revealing = NO;
                _self.currentSelectCell = _cell;
            }
        }];
        [cell setBlockCellDelete:^(id _cell) {
            [_self delete:_cell];
        }];
        [cell setData:nil];
        return cell;
    }];
    
    [_myTableView setBlockDidSelectRowAtIndexPath:^(TTableView *tableView, NSIndexPath *indexPath) {
        ViewCell *cell = (ViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.revealing == YES)
        {
            cell.revealing = NO;
            return;
        }
    }];
}

for the detail, please see the example project

-------
License
=======

This code is distributed under the terms and conditions of the MIT license. 

-------
Contribution guidelines
=======

* if you are fixing a bug you discovered, please add also a unit test so I know how exactly to reproduce the bug before merging

-------
Contributors
=======

Author: Jack Pan

Contributors: waiting for you to join
