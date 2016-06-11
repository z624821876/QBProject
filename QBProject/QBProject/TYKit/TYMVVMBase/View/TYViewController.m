//
//  BasicController.m
//  ULove
//
//  Created by TimothyYan on 16/3/24.
//  Copyright © 2016年 一斌. All rights reserved.
//

#import "TYViewController.h"
#import "TYBarEntity.h"

@interface TYViewController ()
@property (nonatomic,strong) TYViewModel *viewModel;
@end

@implementation TYViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    TYViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindInitialization];
         [viewController bindSubView];
         [viewController bindNotification];
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(TYViewModel *)viewModel{
    if (self!=[super init]) {
        return nil;
    }
    self.viewModel = viewModel;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tyNavigation.shadowImage = [UIImage new];
    self.tyNavigation.statusBarStyle = UIStatusBarStyleLightContent;
    self.tyNavigation.titleColor = [UIColor whiteColor];
    self.tyNavigation.tintColor = [UIColor whiteColor];
    self.tyNavigation.backgroundColor = [UIColor blackColor];
    
    if (!self.viewModel.isHiddenBackBarButton) {
        self.viewModel.leftBarButtons = @[[TYBarEntity entityWithIcon:@"TY_navibar_return_arrow" scale:@(3.0f)]];
    }
}

- (void)bindViewModel{
    @weakify(self);
    [RACObserve(self.viewModel, leftBarButtons)
     subscribeNext:^(NSArray *barButtons) {
         @strongify(self);
         self.navigationItem.leftBarButtonItems = [self barButtonsWithEntitys:barButtons isLeftEntitys:YES];
    }];
    
    [RACObserve(self.viewModel, rightBarButtons)
     subscribeNext:^(NSArray *barButtons) {
         @strongify(self);
         self.navigationItem.rightBarButtonItems = [self barButtonsWithEntitys:barButtons isLeftEntitys:NO];
     }];
    
    [RACObserve(self.viewModel, title)
     subscribeNext:^(NSString *title) {
         @strongify(self);
         self.navigationItem.title = title;
     }];
}

- (void)bindSubView {
    
}

- (void)bindNotification {
    
}

- (void)bindInitialization {

}

- (NSArray *)barButtonsWithEntitys:(NSArray *)entitys isLeftEntitys:(BOOL)isLeftEntitys {
    NSMutableArray *barButtons = [NSMutableArray array];
    for (int i = 0; i < entitys.count; i++) {
        id entity = entitys[i];
        if ([entity isKindOfClass:[TYBarEntity class]]) {
            TYBarEntity *barEntity = (TYBarEntity *)entity;
//            barEntity.backgroundColor = [UIColor redColor];
            [barEntity setTag:i];
            
            if (barEntity.entityImage) {
                [barEntity.entityButton setImage:[barEntity.entityImage scale:barEntity.entityImageScale.floatValue] forState:0];
            }
            
            if (barEntity.entityNetworkImage) {
                [barEntity.entityButton sd_setBackgroundImageWithURL:[NSURL URLWithString:barEntity.entityNetworkImage] forState:0 placeholderImage:barEntity.entityPlaceHolderImage];
            }
            
            if (barEntity.entityTitle && barEntity.entityTitle.length > 0) {
                [barEntity.entityButton setTitle:barEntity.entityTitle forState:0];
            }
            
            CGSize barEntitySize = [self barEntitySizeWithEntity:barEntity];
            [barEntity setFrame:CGRectMake(0, 0, barEntitySize.width, barEntitySize.height)];
            [barButtons addObject:[[UIBarButtonItem alloc] initWithCustomView:barEntity]];
            
            @weakify(self);
            [[barEntity.entityButton rac_signalForControlEvents:1<<6]
             subscribeNext:^(id x) {
                 @strongify(self);
                 NSNumber *entityTag = [NSNumber numberWithInteger:barEntity.tag];
                 if (isLeftEntitys) {
                     if (!self.viewModel.isHiddenBackBarButton && entityTag.intValue == 0) {
                         [self.viewModel.backBarCommand execute:nil];
                     }else {
                         [self.viewModel.leftBarCommand execute:entityTag];
                     }
                 }else {
                     [self.viewModel.rightBarCommand execute:entityTag];
                 }
            }];
        }
    }
    return barButtons;
}

- (CGSize)barEntitySizeWithEntity:(TYBarEntity *)entity {
    if (!CGSizeEqualToSize(entity.entityButtonSize, CGSizeZero)) {
        return entity.entityButtonSize;
    }
    
    CGSize entitySize = CGSizeZero;
    CGFloat entityMinHeight = 40;
    
    /// 先判断图片
    if (entity.entityImage) {
        CGSize imageSize = entity.entityImage.size;
        entitySize.width += imageSize.width / entity.entityImageScale.floatValue;
        entitySize.width += entity.imageEdgeInsets.left + entity.imageEdgeInsets.right;
    }
    
    if (entity.entityNetworkImage) {
        entitySize.width += entity.entityNetworkSize.width;
        entitySize.width += entity.imageEdgeInsets.left + entity.imageEdgeInsets.right;
    }
    
    if (entity.entityTitle && entity.entityTitle.length > 0) {
        CGSize titleSize = [entity.entityTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                            options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:entity.entityFont}
                                                            context:nil].size;
        entitySize.width += titleSize.width;
        entitySize.width += entity.titleEdgeInsets.left + entity.titleEdgeInsets.right;
    }
    
    entitySize.width += entity.contentEdgeInsets.left + entity.contentEdgeInsets.right;
    entitySize.height = entityMinHeight;
    return entitySize;
}

- (void)dealloc{
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
