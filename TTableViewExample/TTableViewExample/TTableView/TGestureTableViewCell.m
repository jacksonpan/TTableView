//
//  TGestureTableViewCell.m
//  Tu
//
//  Created by jacksonpan on 13-4-15.
//  Copyright (c) 2013年 jack. All rights reserved.
//

#import "TGestureTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

typedef enum {
    LMFeedCellDirectionNone=0,
	LMFeedCellDirectionRight,
	LMFeedCellDirectionLeft,
} LMFeedCellDirection;

#define kMinimumVelocity  self.contentView.frame.size.width*1.5
#define kMinimumPan       60.0
#define kBOUNCE_DISTANCE  7.0
#define kAnimateDelay     0.1

@interface TGestureTableViewCell ()
{
    
}

//flag
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGFloat initialHorizontalCenter;
@property (nonatomic, assign) CGFloat initialTouchPositionX;

@property (nonatomic, assign) LMFeedCellDirection lastDirection;
@property (nonatomic, assign) CGFloat originalCenter;

@end

@implementation TGestureTableViewCell
@synthesize bottomLeftView = _bottomLeftView;
@synthesize bottomRightView = _bottomRightView;
@synthesize initialHorizontalCenter=_initialHorizontalCenter;
@synthesize initialTouchPositionX=_initialTouchPositionX;
@synthesize panGesture = _panGesture;
@synthesize lastDirection = _lastDirection;
@synthesize originalCenter = _originalCenter;
@synthesize currentStatus = _currentStatus;
@synthesize revealing = _revealing;
@synthesize leftNewOffsetX = _leftNewOffsetX;
@synthesize rightNewOffsetX = _rightNewOffsetX;

@synthesize blockCellDidBeginPan = _blockCellDidBeginPan;
@synthesize blockcellDidReveal = _blockcellDidReveal;

@synthesize enableLeft = _enableLeft;
@synthesize enableRight = _enableRight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initGesture];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initGesture];
    }
    return self;
}

- (void)initUI
{

}

- (void)initGesture
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    _currentStatus = kFeedStatusNormal;
    _enableLeft = YES;
    _enableRight = YES;
    
    _originalCenter = ceil(self.bounds.size.width / 2);
    _leftNewOffsetX = -_originalCenter/2;
    _rightNewOffsetX = self.contentView.frame.size.width + _originalCenter/2;
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
    _panGesture.delegate = self;
    [self addGestureRecognizer:_panGesture];
    
    [self initUI];
}

- (BOOL)enableGesture
{
    return self.panGesture.enabled;
}

- (void)enableGesture:(BOOL)enable
{
    self.panGesture.enabled = enable;
}

- (void)layoutBottomView
{
    if(!self.bottomRightView)
    {
        _bottomRightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _bottomRightView.backgroundColor = [UIColor lightGrayColor];
        [self insertSubview:_bottomRightView atIndex:0];
    }
    if(!self.bottomLeftView)
    {
        _bottomLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _bottomLeftView.backgroundColor =  [UIColor colorWithRed:132/255.0 green:176/255.0 blue:201/255.0 alpha:1.0];
        [self insertSubview:_bottomLeftView atIndex:0];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)togglePanelWithFlag
{
    switch (_currentStatus)
    {
        case kFeedStatusLeftExpanding:
        {
            _bottomRightView.alpha = 0.0f;
            _bottomLeftView.alpha = 1.0f;
        }
            break;
        case kFeedStatusRightExpanding:
        {
            _bottomRightView.alpha = 1.0f;
            _bottomLeftView.alpha = 0.0f;
        }
            break;
        case kFeedStatusNormal:{
            [_bottomRightView removeFromSuperview];
            self.bottomRightView = nil;
            [_bottomLeftView removeFromSuperview];
            self.bottomLeftView = nil;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark UIPanGestureRecognizer

- (void)panGestureHandle:(UIPanGestureRecognizer *)recognizer
{
    //begin pan...
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        _initialTouchPositionX = [recognizer locationInView:self].x;
        _initialHorizontalCenter = self.contentView.center.x;
        if(_currentStatus == kFeedStatusNormal)
        {
            [self layoutBottomView];
        }
        if(_blockCellDidBeginPan)
        {
            _blockCellDidBeginPan(self);
        }
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged)
    { //status change
        CGFloat panAmount  = _initialTouchPositionX - [recognizer locationInView:self].x;
        CGFloat newCenterPosition     = _initialHorizontalCenter - panAmount;
        CGFloat centerX               = self.contentView.center.x;
        if(centerX>_originalCenter && _currentStatus!=kFeedStatusLeftExpanding)
        {
            _currentStatus = kFeedStatusLeftExpanding;
            [self togglePanelWithFlag];
        }
        else if(centerX<_originalCenter && _currentStatus!=kFeedStatusRightExpanding)
        {
            _currentStatus = kFeedStatusRightExpanding;
            [self togglePanelWithFlag];
        }
        if(panAmount > 0)
        {
            _lastDirection = LMFeedCellDirectionLeft;
        }
        else
        {
            _lastDirection = LMFeedCellDirectionRight;
        }
        if (newCenterPosition > self.bounds.size.width + _originalCenter)
        {
            newCenterPosition = self.bounds.size.width + _originalCenter;
        }
        else if (newCenterPosition < -_originalCenter)
        {
            newCenterPosition = -_originalCenter;
        }
        if(_lastDirection == LMFeedCellDirectionRight)
        {
            if(_enableLeft == NO)
            {
                return;
            }
        }
        else if(_lastDirection == LMFeedCellDirectionLeft)
        {
            if(_enableRight == NO)
            {
                return;
            }
        }
        CGPoint center = self.contentView.center;
        center.x = newCenterPosition;
        self.contentView.layer.position = center;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGPoint translation = [recognizer translationInView:self];
        CGFloat velocityX = [recognizer velocityInView:self].x;
        
        //判断是否push view
        BOOL isNeedPush = (fabs(velocityX) > kMinimumVelocity);
        isNeedPush |= ((_lastDirection == LMFeedCellDirectionLeft && translation.x < -kMinimumPan) ||
                       (_lastDirection== LMFeedCellDirectionRight && translation.x > kMinimumPan));
        
        if (velocityX > 0 && _lastDirection == LMFeedCellDirectionLeft)
        {
            isNeedPush = NO;
        }
        else if (velocityX < 0 && _lastDirection == LMFeedCellDirectionRight)
        {
            isNeedPush = NO;
        }
        if (isNeedPush && !self.revealing)
        {
            if(_lastDirection==LMFeedCellDirectionRight)
            {
                if(_enableLeft == NO)
                {
                    return;
                }
                _currentStatus = kFeedStatusLeftExpanding;
                [self togglePanelWithFlag];
            }
            else{
                if(_enableRight == NO)
                {
                    return;
                }
                _currentStatus = kFeedStatusRightExpanding;
                [self togglePanelWithFlag];
            }
            [self _slideOutContentViewInDirection:_lastDirection];
            [self _setRevealing:YES];
        }
        else if (self.revealing && translation.x != 0)
        {
            LMFeedCellDirection direct = _currentStatus==kFeedStatusRightExpanding?LMFeedCellDirectionLeft:LMFeedCellDirectionRight;
            
            [self _slideInContentViewFromDirection:direct];
            [self _setRevealing:NO];
        }
        else if (translation.x != 0)
        {
            // Figure out which side we've dragged on.
            LMFeedCellDirection finalDir = LMFeedCellDirectionRight;
            if (translation.x < 0)
                finalDir = LMFeedCellDirectionLeft;
            [self _slideInContentViewFromDirection:finalDir];
            [self _setRevealing:NO];
        }
    }
}


#pragma mark -
#pragma mark revealing setter
- (void)setRevealing:(BOOL)revealing
{
	if (_revealing == revealing) {
		return;
    }
	[self _setRevealing:revealing];
	
	if (self.revealing) {
		[self _slideOutContentViewInDirection:_lastDirection];
	} else {
		[self _slideInContentViewFromDirection:_lastDirection];
    }
}

- (void)_setRevealing:(BOOL)revealing
{
	_revealing=revealing;
    if(self.revealing && _blockcellDidReveal)
    {
        _blockcellDidReveal(self);
    }
}

#pragma mark
#pragma mark - ContentView Sliding
- (void)_slideInContentViewFromDirection:(LMFeedCellDirection)direction
{
    
	CGFloat bounceDistance = 0;
    NSLog(@"%f", self.contentView.center.x);
	if (self.contentView.center.x == _originalCenter)
		return;
	
	switch (direction) {
		case LMFeedCellDirectionRight:
			bounceDistance = kBOUNCE_DISTANCE;
			break;
		case LMFeedCellDirectionLeft:
			bounceDistance = -kBOUNCE_DISTANCE;
			break;
		default:
			break;
	}
	
	[UIView animateWithDuration:kAnimateDelay
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
					 animations:^{
                         self.contentView.center = CGPointMake(_originalCenter, self.contentView.center.y);
                     }
					 completion:^(BOOL f) {
						 [UIView animateWithDuration:kAnimateDelay delay:0
											 options:UIViewAnimationOptionCurveEaseOut
										  animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, bounceDistance, 0); }
										  completion:^(BOOL f) {
                                              [UIView animateWithDuration:kAnimateDelay delay:0
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, -bounceDistance, 0); }
                                                               completion:^(BOOL f){
                                                                   _currentStatus=kFeedStatusNormal;
                                                                   [self togglePanelWithFlag];
                                                               }];
                                          }];
                     }];
}



- (void)_slideOutContentViewInDirection:(LMFeedCellDirection)direction;
{
	CGFloat newCenterX = 0;
    CGFloat bounceDistance = 0;
    switch (direction) {
        case LMFeedCellDirectionLeft:{
            newCenterX = _leftNewOffsetX;//- _originalCenter/2;
            bounceDistance = -kBOUNCE_DISTANCE;
            _currentStatus=kFeedStatusLeftExpanded;
        }
            break;
        case LMFeedCellDirectionRight:{
            newCenterX = _rightNewOffsetX;//self.contentView.frame.size.width + _originalCenter/2;
            bounceDistance = kBOUNCE_DISTANCE;
            _currentStatus=kFeedStatusRightExpanded;
        }
            break;
        default:
            break;
    }
    
	[UIView animateWithDuration:kAnimateDelay
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
                         self.contentView.center = CGPointMake(newCenterX, self.contentView.center.y);
                     }
                     completion:^(BOOL f) {
						 [UIView animateWithDuration:kAnimateDelay delay:0
											 options:UIViewAnimationOptionCurveEaseIn
										  animations:^{
                                              self.contentView.frame = CGRectOffset(self.contentView.frame, -bounceDistance, 0);
                                          }
										  completion:^(BOOL f) {
											  [UIView animateWithDuration:kAnimateDelay delay:0
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   self.contentView.frame = CGRectOffset(self.contentView.frame, bounceDistance, 0);
                                                               }
                                                               completion:NULL];
										  }];
                     }];
}

#pragma mark
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer == _panGesture) {
		UIScrollView *superview = (UIScrollView *)self.superview;
		CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:superview];
		// Make it scrolling horizontally
		return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO &&
                (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
	}
	return YES;
}

@end
