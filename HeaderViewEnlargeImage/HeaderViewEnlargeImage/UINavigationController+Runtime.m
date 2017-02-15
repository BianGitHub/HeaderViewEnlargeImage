//
//  UINavigationController+Runtime.m
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "UINavigationController+Runtime.h"
#import <objc/runtime.h>

@interface BLFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>
    
@property (nonatomic, weak) UINavigationController *navigationController;
    
@end

@implementation BLFullScreenPopGestureRecognizerDelegate
    
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    //判断是否是根控制器 如果是 取消手势
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    // 如果正在转场动画 取消手势
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    // 判断手指方向
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}
    
    @end
@implementation UINavigationController (Runtime)

+ (void)load {
    
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(bl_pushViewController:animated:));
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
    
- (void)bl_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.bl_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.bl_popGestureRecognizer];
        
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        // 拦截handleNavigationTransition:方法
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        self.bl_popGestureRecognizer.delegate = [self bl_fullScreenPopGestureRecognizerDelegate];
        [self.bl_popGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // 禁用系统的交互手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [self bl_pushViewController:viewController animated:animated];
    }
}
    
- (BLFullScreenPopGestureRecognizerDelegate *)bl_fullScreenPopGestureRecognizerDelegate {
    BLFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[BLFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}
    
- (UIPanGestureRecognizer *)bl_popGestureRecognizer {
    // 运行时关联对象  调用运行时方法前,判断对象属性是否已经获取, 如果获取直接返回
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        // 动态创建属性, 记录属性数组
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}
    
@end
