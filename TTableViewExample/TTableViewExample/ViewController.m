//
//  ViewController.m
//  TTableViewExample
//
//  Created by ren pan on 13-9-7.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "ViewController.h"
#import "TTableView.h"
#import "ViewCell.h"

@interface ViewController ()
{
    
}
@property (nonatomic, strong) IBOutlet TTableView* myTableView;
@property (nonatomic, assign) ViewCell* currentSelectCell;
@end

@implementation ViewController
@synthesize myTableView = _myTableView;
@synthesize currentSelectCell = _currentSelectCell;

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

- (void)delete:(id)_cell
{
    NSIndexPath* indexPath = [(ViewCell*)_cell indexPath];
        
    [_myTableView beginUpdates];
    [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [_myTableView endUpdates];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
