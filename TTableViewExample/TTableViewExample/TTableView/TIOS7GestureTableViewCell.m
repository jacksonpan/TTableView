//
//  TIOS7GestureTableViewCell.m
//  t2u
//
//  Created by ren pan on 13-7-18.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "TIOS7GestureTableViewCell.h"

@interface TIOS7GestureTableViewCell ()
{
    UIView* viewForLine;
    UIView* viewForTopBottomLine;
}
@end

@implementation TIOS7GestureTableViewCell
@synthesize islastCell = _islastCell;
@synthesize isFirstCell = _isFirstCell;
@synthesize indexPath = _indexPath;
@synthesize lineStartOffsetX = _lineStartOffsetX;

- (void)initForSubClass
{

}

- (void)initUI
{    
    CGRect selfF = self.frame;
    
    _lineStartOffsetX = 15.0f;
    
    viewForTopBottomLine = [UIView new];
    viewForTopBottomLine.frame = CGRectMake(0, 0, selfF.size.width, 1);
    viewForTopBottomLine.backgroundColor = [UIColor colorWithWhite:0.9137f alpha:1];
    [self.contentView addSubview:viewForTopBottomLine];
    
    viewForLine = [UIView new];
    viewForLine.frame = CGRectMake(_lineStartOffsetX, 0, selfF.size.width - _lineStartOffsetX, 1);
    viewForLine.backgroundColor = [UIColor colorWithWhite:0.9137f alpha:1];
    [self.contentView addSubview:viewForLine];
    
    [self initForSubClass];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect selfF = self.frame;
    
    if(viewForLine)
    {
        CGRect lineF = CGRectMake(_lineStartOffsetX, selfF.size.height - 1, selfF.size.width - _lineStartOffsetX, 1);
        viewForLine.frame = lineF;
    }
    
    if(viewForTopBottomLine)
    {
        [viewForTopBottomLine setHidden:YES];
        if(_isFirstCell)
        {
            [viewForTopBottomLine setHidden:NO];
            viewForTopBottomLine.frame = CGRectMake(0, 0, selfF.size.width, 1);
        }
        if(_islastCell)
        {
            [viewForTopBottomLine setHidden:NO];
            viewForTopBottomLine.frame = CGRectMake(0, selfF.size.height - 1, selfF.size.width, 1);
        }
    }
}

- (void)checkCellWithIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView
{
    _indexPath = indexPath;
    NSInteger rows = [tableView numberOfRowsInSection:_indexPath.section];
    if(rows == 1)
    {
        _isFirstCell = YES;
        _islastCell = YES;
    }
    else
    {
        if(_indexPath.row == 0)
        {
            _isFirstCell = YES;
            _islastCell = NO;
        }
        else if(_indexPath.row == rows - 1)
        {
            _isFirstCell = NO;
            _islastCell = YES;
        }
        else
        {
            _islastCell = NO;
            _isFirstCell = NO;
        }
    }
    
    [self setNeedsLayout];
}
@end
