//
//  UIImage+SDKLoader.h
//  ODiSyFramework
//
//  Created by Olivier Demolliens on 17/03/2014.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SDKLoader)

+ (UIImage *)imageFromSDKWithName:(NSString*)ressourceName;

@end
