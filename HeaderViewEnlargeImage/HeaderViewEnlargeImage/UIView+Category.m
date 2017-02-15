//
//  UIView+Category.m
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
#pragma mark - Frame
- (CGPoint)bl_viewOrigin {
    return self.frame.origin;
}
    
- (void)setBl_viewOrigin:(CGPoint)bl_viewOrigin {
    CGRect newFrame = self.frame;
    newFrame.origin = bl_viewOrigin;
    self.frame = newFrame;
}
    
- (CGSize)bl_viewSize {
    return self.frame.size;
}
    
- (void)setBl_viewSize:(CGSize)bl_viewSize {
    CGRect newFrame = self.frame;
    newFrame.size = bl_viewSize;
    self.frame = newFrame;
}
    
#pragma mark - Frame Origin
- (CGFloat)bl_x {
    return self.frame.origin.x;
}
    
- (void)setBl_x:(CGFloat)bl_x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = bl_x;
    self.frame = newFrame;
}
    
- (CGFloat)bl_y {
    return self.frame.origin.y;
}
    
- (void)setBl_y:(CGFloat)bl_y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = bl_y;
    self.frame = newFrame;
}
    
#pragma mark - Frame Size
- (CGFloat)bl_width {
    return self.frame.size.width;
}
    
- (void)setBl_width:(CGFloat)bl_width {
    CGRect newFrame = self.frame;
    newFrame.size.width = bl_width;
    self.frame = newFrame;
}
    
- (CGFloat)bl_height {
    return self.frame.size.height;
}
    
- (void)setBl_height:(CGFloat)bl_height {
    CGRect newFrame = self.frame;
    newFrame.size.height = bl_height;
    self.frame = newFrame;
}
    
#pragma mark - 截屏
- (UIImage *)bl_capturedImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    UIImage *result = nil;
    if ([self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES]) {
        result = UIGraphicsGetImageFromCurrentImageContext();
    }
    
    UIGraphicsEndImageContext();
    
    return result;
}
@end
