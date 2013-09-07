//
//  TGestureTableViewCell.h
//  Tu
//
//  Created by jacksonpan on 13-4-15.
//  Copyright (c) 2013年 jack. All rights reserved.
//

#import "TTableViewCell.h"

typedef enum {
    kFeedStatusNormal = 0,
    kFeedStatusLeftExpanded,
    kFeedStatusLeftExpanding,
    kFeedStatusRightExpanded,
    kFeedStatusRightExpanding,
}kFeedStatus;

@class TGestureTableViewCell;

typedef void(^cellDidBeginPan)(id _cell);
typedef void(^cellDidReveal)(id _cell);

@interface TGestureTableViewCell : TTableViewCell
@property (nonatomic, strong) UIView *bottomRightView;
@property (nonatomic, strong) UIView *bottomLeftView;
@property (nonatomic, assign) kFeedStatus currentStatus;
@property (nonatomic, assign) BOOL revealing;

@property (nonatomic, assign) CGFloat leftNewOffsetX;
@property (nonatomic, assign) CGFloat rightNewOffsetX;

@property (nonatomic, strong) cellDidBeginPan blockCellDidBeginPan;
@property (nonatomic, strong) cellDidReveal blockcellDidReveal;

@property (nonatomic, assign) BOOL enableLeft;
@property (nonatomic, assign) BOOL enableRight;

- (void)setBlockCellDidBeginPan:(cellDidBeginPan)blockCellDidBeginPan;
- (void)setBlockcellDidReveal:(cellDidReveal)blockcellDidReveal;

- (BOOL)enableGesture;
- (void)enableGesture:(BOOL)enable;

- (void)initUI;

@end
