//
//  TTableViewCell.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-15.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "TTableViewCell.h"
#import "TTableView.h"



@implementation TTableViewCell
- (void)initCell
{
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initCell];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initCell];
    }
    return self;
}
@end

@implementation UITableViewCell (TTableViewCell)
+ (NSString*)getSelfName
{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

+ (id)loadReuseableNib:(UITableView*)tableView
{
    NSString* selfName = [self getSelfName];
    id cell = [tableView dequeueReusableCellWithIdentifier:selfName];
    if(!cell)
    {
        UINib *nib = [UINib nibWithNibName:selfName bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:selfName];
        cell = [tableView dequeueReusableCellWithIdentifier:selfName];
        //NSLog(@"cell new:%@", selfName);
    }
    return cell;
}

+ (id)loadReuseableNoNib:(UITableView*)tableView style:(UITableViewCellStyle)style
{
    NSString* selfName = [self getSelfName];
    id cell = [tableView dequeueReusableCellWithIdentifier:selfName];
    if(!cell)
    {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:selfName];
        //NSLog(@"cell new:%@", selfName);
    }
    return cell;
}

+ (id)loadReuseableFromStoryboard:(UITableView*)tableView
{
    NSString* selfName = [self getSelfName];
    return [tableView dequeueReusableCellWithIdentifier:selfName];
}

@end