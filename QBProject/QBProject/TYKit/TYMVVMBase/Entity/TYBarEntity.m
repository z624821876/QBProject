//
//  TYBarEntity.m
//  MPProject
//
//  Created by QuincyYan on 16/5/24.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYBarEntity.h"

@interface TYBarEntity()
@property (nonatomic,strong) UIView *redPointView;

@end

@implementation TYBarEntity

- (instancetype)init {
    if (self != [super init]) {
        return nil;
    }
    
    [self initStaticParams];
    [self addSubview:self.entityButton];
    [self.entityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentEdgeInsets);
    }];
    
    [self addSubview:self.redPointView];
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-2);
        make.top.equalTo(self).offset(2);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
    @weakify(self);
    [RACObserve(self, entityCornerRatius)
     subscribeNext:^(NSNumber *entityCornerRatius) {
         @strongify(self);
         [self.entityButton.layer setCornerRadius:entityCornerRatius.floatValue];
    }];
    
    [RACObserve(self, entityAlpha)
     subscribeNext:^(NSNumber *entityAlpha) {
        @strongify(self);
         [self.entityButton setAlpha:entityAlpha.floatValue];
    }];
    
    [RACObserve(self, entityFont)
     subscribeNext:^(UIFont *entityFont) {
         @strongify(self);
         [self.entityButton.titleLabel setFont:entityFont];
     }];
    
    [RACObserve(self, entityTextColor)
     subscribeNext:^(UIColor *entityTextColor) {
         @strongify(self);
         [self.entityButton setTitleColor:entityTextColor forState:0];
     }];
    
    [RACObserve(self, entityBadgeValue)
     subscribeNext:^(NSNumber *entityBadgeValue) {
         @strongify(self);
         [self.redPointView setHidden:entityBadgeValue.intValue == 0];
    }];
    
    [RACObserve(self, isEntityButtonTouchable)
     subscribeNext:^(NSNumber *isEntityButtonTouchable) {
         @strongify(self);
         [self.entityButton setEnabled:isEntityButtonTouchable.boolValue];
         [self.entityButton setTitleColor:isEntityButtonTouchable.boolValue ? [UIColor whiteColor] : [UIColor colorWithHexString:@"81ecff"] forState:0];
    }];
    
    [RACObserve(self, entityNetworkImage)
     subscribeNext:^(NSString *entityNetworkImage) {
         @strongify(self);
         [self.entityButton sd_setBackgroundImageWithURL:[NSURL URLWithString:entityNetworkImage] forState:0 placeholderImage:self.entityPlaceHolderImage];
    }];
    
    return self;
}

+ (TYBarEntity *)entityWithIcon:(NSString *)entityImage scale:(NSNumber *)entityScale {
    TYBarEntity *entity = [[TYBarEntity alloc] init];
    entity.entityImage = [UIImage imageNamed:entityImage];
    entity.entityImageScale = entityScale;
    return entity;
}

+ (TYBarEntity *)entityWithTitle:(NSString *)entityTitle isEntityButtonTouchable:(NSNumber *)touchable {
    TYBarEntity *entity = [[TYBarEntity alloc] init];
    entity.entityTitle = entityTitle;
    entity.isEntityButtonTouchable = touchable;
    entity.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    return entity;
}

+ (TYBarEntity *)entityWithDefaultReturnIconWithTitle:(NSString *)entityTitle {
    TYBarEntity *entity = [[TYBarEntity alloc] init];
    entity.entityTitle = entityTitle;
    entity.entityImage = [UIImage imageNamed:@"ue_navibar_arrow"];
    entity.entityImageScale = [NSNumber numberWithFloat:3.0f];
    return entity;
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    if (_entityButton) {
        [self.entityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(contentEdgeInsets);
        }];
    }
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    _titleEdgeInsets = titleEdgeInsets;
    self.entityButton.titleEdgeInsets = titleEdgeInsets;
}

- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    _imageEdgeInsets = imageEdgeInsets;
    self.entityButton.imageEdgeInsets = imageEdgeInsets;
}

- (void)initStaticParams {
    self.entityFont = [UIFont systemFontOfSize:17];
    self.entityTextColor = [UIColor whiteColor];
    self.entityImageScale = [NSNumber numberWithFloat:1.0f];
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.entityAlpha = [NSNumber numberWithFloat:1.0f];
    self.entityNetworkSize = CGSizeMake(40, 40);
    
    self.isEntityButtonTouchable = [NSNumber numberWithBool:YES];
}

- (UIButton *)entityButton {
    if (!_entityButton) {
        _entityButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _entityButton.clipsToBounds = YES;
    }
    return _entityButton;
}

- (UIView *)redPointView {
    if (!_redPointView) {
        _redPointView = [[UIView alloc] init];
        _redPointView.backgroundColor = [UIColor redColor];
        _redPointView.clipsToBounds = YES;
        _redPointView.layer.cornerRadius = 4;
    }
    return _redPointView;
}

@end
