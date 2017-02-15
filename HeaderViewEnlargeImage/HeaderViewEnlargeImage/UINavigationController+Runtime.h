//
//  UINavigationController+Runtime.h
//  HeaderViewEnlargeImage
//
//  Created by 边雷 on 17/2/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Runtime)
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *bl_popGestureRecognizer;
@end
