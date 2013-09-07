//
//  ViewCell.m
//  TTableViewExample
//
//  Created by ren pan on 13-9-7.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "ViewCell.h"

@interface ViewCell ()
{
    UILabel* label_title;
    UIButton* buttonRight;
}
@end

@implementation ViewCell
@synthesize blockCellDelete = _blockCellDelete;


- (void)initForSubClass
{
    self.enableLeft = NO;
    self.enableRight = YES;
    self.leftNewOffsetX = 80;
    self.rightNewOffsetX = self.contentView.frame.size.width + 80;
    
    if(label_title == nil)
    {
        label_title = [[UILabel alloc] initWithFrame:self.bounds];
        [label_title setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:label_title];
    }
}

- (void)layoutBottomView
{
    if(!self.bottomRightView)
    {
        self.bottomRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.bottomRightView.backgroundColor = [UIColor redColor];
        [self insertSubview:self.bottomRightView atIndex:0];
        
        CGRect f = self.bottomRightView.frame;
        buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonRight setTitle:@"删除" forState:UIControlStateNormal];
        buttonRight.frame = CGRectMake(f.size.width - 80, 0, 80, f.size.height);
        [buttonRight setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
        [self.bottomRightView addSubview:buttonRight];
        [buttonRight addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setData:(id)data
{
    label_title.text = [NSString stringWithFormat:@"section = %d, row = %d", self.indexPath.section, self.indexPath.row];
}

- (void)btnDelete:(id)sender
{
    if(_blockCellDelete)
    {
        _blockCellDelete(self);
    }
}
@end
