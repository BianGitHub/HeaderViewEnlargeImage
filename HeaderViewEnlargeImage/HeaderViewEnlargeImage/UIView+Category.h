//
//  UIView+Category.h
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
#pragma mark - Frame
    /// 视图原点
@property (nonatomic) CGPoint bl_viewOrigin;
    /// 视图尺寸
@property (nonatomic) CGSize bl_viewSize;
    
#pragma mark - Frame Origin
    /// frame 原点 x 值
@property (nonatomic) CGFloat bl_x;
    /// frame 原点 y 值
@property (nonatomic) CGFloat bl_y;
    
#pragma mark - Frame Size
    /// frame 尺寸 width
@property (nonatomic) CGFloat bl_width;
    /// frame 尺寸 height
@property (nonatomic) CGFloat bl_height;
    
#pragma mark - 截屏
    /// 当前视图内容生成的图像
@property (nonatomic, readonly, nullable)UIImage *bl_capturedImage;
@end
