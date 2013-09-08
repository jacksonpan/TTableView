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
@property (nonatomic, strong) NSMutableArray* dataList;
@end

@implementation ViewController
@synthesize myTableView = _myTableView;
@synthesize currentSelectCell = _currentSelectCell;
@synthesize dataList = _dataList;

- (void)initUI
{
    if(_dataList == nil)
    {
        _dataList = [NSMutableArray new];
        for(int i=0;i<5;i++)
        {
            NSMutableArray* rows = [NSMutableArray new];
            for(int j=0;j<5;j++)
            {
                [rows addObject:[NSNull null]];
            }
            [_dataList addObject:rows];
        }
    }
    __weak ViewController* _self = self;
    
    _myTableView.enableIOS7Style = YES;
    //_myTableView.enableTransform = YES;
    //[_myTableView setBlockTransform:TTableViewCellTransformFan];

    [_myTableView setBlockNumberOfSections:^NSInteger(TTableView *tableView) {
        return _self.dataList.count;
    }];
    
    [_myTableView setBlockNumberOfRows:^NSInteger(TTableView *tableView, NSInteger section) {
        NSMutableArray* rows = [_self.dataList objectAtIndex:section];
        return rows.count;
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
    NSIndexPath* indexPath = [self.myTableView indexPathForCell:_cell];
    NSMutableArray* rows = [self.dataList objectAtIndex:indexPath.section];
    [rows removeLastObject];
    [_myTableView beginUpdates];
    [_myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
