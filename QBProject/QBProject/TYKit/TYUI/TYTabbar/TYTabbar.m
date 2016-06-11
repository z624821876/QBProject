//
//  TYTabbar.m
//  TYKit
//
//  Created by QuincyYan on 16/4/10.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYTabbar.h"

@interface TYTabbar()
@property (nonatomic,strong) TYTabbarEntity *selectEntity;

@end

@implementation TYTabbar

- (instancetype)init {
    if (self != [super init]) {
        return nil;
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)reloadEntitys {
    for (TYTabbarEntity *entity in self.subviews) {
        if ([entity isKindOfClass:[TYTabbarEntity class]]) {
            [entity removeFromSuperview];
        }
    }
    
    for (int i = 0; i < self.entitys.count; i++) {
        TYTabbarEntity *entity = self.entitys[i];
        [entity addTarget:self action:@selector(tabbarItemSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:entity];
        if (i == self.selectedIndex) {
            [self tabbarItemSelected:entity];
        }
    }
    
    [self setNeedsLayout];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (selectedIndex < _entitys.count-1) {
        TYTabbarEntity *entity = _entitys[selectedIndex];
        [self tabbarItemSelected:entity];
    }
}

- (void)setNormalStateTextColor:(UIColor *)normalStateTextColor {
    _normalStateTextColor = normalStateTextColor;
    for (TYTabbarEntity *entity in self.entitys) {
        entity.normalStateTextColor = normalStateTextColor;
    }
}

- (void)setNormalStateBackgroundColor:(UIColor *)normalStateBackgroundColor {
    _normalStateBackgroundColor = normalStateBackgroundColor;
    for (TYTabbarEntity *entity in self.entitys) {
        entity.normalStateBackgroundColor = normalStateBackgroundColor;
    }
}

- (void)setSelectedStateTextColor:(UIColor *)selectedStateTextColor {
    _selectedStateTextColor = selectedStateTextColor;
    for (TYTabbarEntity *entity in self.entitys) {
        entity.selectedStateTextColor = selectedStateTextColor;
    }
}

- (void)setSelectedStateBackgroundColor:(UIColor *)selectedStateBackgroundColor {
    _selectedStateBackgroundColor = selectedStateBackgroundColor;
    for (TYTabbarEntity *entity in self.entitys) {
        entity.selectedStateBackgroundColor = selectedStateBackgroundColor;
    }
}

- (void)entityWithBadge:(NSInteger)badge atIndex:(NSInteger)index {
    if (index<self.entitys.count-1) {
        TYTabbarEntity *entity = self.entitys[index];
        entity.badgeValue = badge;
        [entity setNeedsDisplay];
    }
}

- (void)removeBadgeAtIndex:(NSInteger)index {
    if (index<self.entitys.count-1) {
        TYTabbarEntity *entity = self.entitys[index];
        entity.badgeValue = 0;
        [entity setNeedsDisplay];
    }
}

- (void)removeAllBadges {
    for (TYTabbarEntity *entity in self.entitys) {
        entity.badgeValue = 0;
        [entity setNeedsDisplay];
    }
}

- (void)layoutSubviews {
    CGFloat entityWidth = self.frame.size.width / _entitys.count;
    
    NSInteger index = 0;
    for (TYTabbarEntity *entity in _entitys) {
        entity.frame = CGRectMake(entityWidth * index,
                                  0,
                                  entityWidth,
                                  self.frame.size.height);
        [entity setNeedsDisplay];
        index ++;
    }
}

- (void)tabbarItemSelected:(TYTabbarEntity *)entity {
    if ([self.tyDelegate respondsToSelector:@selector(TYTabbar:didSelectedEntityInIndex:)]) {
        NSInteger index = [self.entitys indexOfObject:entity];
        BOOL selected = [self.tyDelegate TYTabbar:self didSelectedEntityInIndex:index];
        if (selected) {
            if (self.entitys) {
                [self.selectEntity setSelected:NO];
            }
            self.selectEntity = entity;
            [self.selectEntity setSelected:YES];
        }
    }
}

@end
