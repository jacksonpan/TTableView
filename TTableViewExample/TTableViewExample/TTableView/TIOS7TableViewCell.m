//
//  TIOS7TableViewCell.m
//  t2u
//
//  Created by ren pan on 13-7-5.
//  Copyright (c) 2013年 ren pan. All rights reserved.
//

#import "TIOS7TableViewCell.h"

@interface TIOS7TableViewCell ()
- (void)drawContentView:(CGRect)rect;
@end


@implementation TContentViewCell
- (void)drawRect:(CGRect)rect
{
	[(TIOS7TableViewCell *)[self superview] drawContentView:rect];
}
@end

@implementation TIOS7TableViewCell
@synthesize tContentView = _tContentView;
@synthesize islastCell = _islastCell;
@synthesize isFirstCell = _isFirstCell;
@synthesize indexPath = _indexPath;
@synthesize lineStartOffsetX = _lineStartOffsetX;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
	{
		[self initUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.opaque = NO;
    _lineStartOffsetX = 15.0f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if(_tContentView == nil)
    {
        _tContentView = [[TContentViewCell alloc] initWithFrame:CGRectZero];
        [_tContentView setBackgroundColor:[UIColor clearColor]];
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_tContentView];
    
    [self initContent];
}

- (void)initContent
{

}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[_tContentView setNeedsDisplay];
}

- (void)checkCellWithIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView
{
    _indexPath = indexPath;
    NSInteger rows = [tableView numberOfRowsInSection:_indexPath.section];
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
    [self setNeedsDisplay];
    
    //[self.textLabel setText:[NSString stringWithFormat:@"sec:%d, row:%d", indexPath.section, indexPath.row]];
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self setNeedsDisplay];
    
    // Configure the view for the selected state
}
 */

- (void)drawContentView:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    if(self.isSelected && self.selectionStyle != UITableViewCellSelectionStyleNone)
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
        [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.00f] setFill];
        [path fill];
        
        [self drawCell:rect];
        
        UIBezierPath *bottomline1 = [UIBezierPath bezierPath];
        [bottomline1 moveToPoint:CGPointMake(0.0f, CGRectGetMaxY(rect))];
        [bottomline1 addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
        [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.00f] setStroke];
        [bottomline1 stroke];
        
        UIBezierPath *bottomline2 = [UIBezierPath bezierPath];
        [bottomline2 moveToPoint:CGPointMake(0.0f, 0.0f)];
        [bottomline2 addLineToPoint:CGPointMake(CGRectGetMaxX(rect), 0.0f)];
        [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.00f] setStroke];
        [bottomline2 stroke];
    }
    else
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
        [[UIColor whiteColor] setFill];
        [path fill];
        
        [self drawCell:rect];
        
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(_lineStartOffsetX, CGRectGetMaxY(rect))];
        [line addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
        [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.00f] setStroke];
        [line stroke];
        
        if(_islastCell)
        {
            UIBezierPath *bottomline = [UIBezierPath bezierPath];
            [bottomline moveToPoint:CGPointMake(0.0f, CGRectGetMaxY(rect))];
            [bottomline addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
            [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.00f] setStroke];
            [bottomline stroke];
        }
        if(_isFirstCell)
        {
            UIBezierPath *bottomline = [UIBezierPath bezierPath];
            [bottomline moveToPoint:CGPointMake(0.0f, 0.0f)];
            [bottomline addLineToPoint:CGPointMake(CGRectGetMaxX(rect), 0.0f)];
            [[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.00f] setStroke];
            [bottomline stroke];
        }
    }
}

- (void)layoutSubviews
{
	CGRect b = [self bounds];
	[_tContentView setFrame:b];
    [super layoutSubviews];
}

- (void)drawCell:(CGRect)rect
{

}
@end
