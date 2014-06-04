//
//  UIImage+SDKLoader.m
//  ODiSyFramework
//
//  Created by Olivier Demolliens on 17/03/2014.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "UIImage+SDKLoader.h"

//Resources
#import "ODResourcesManager.h"

@implementation UIImage (SDKLoader)

+ (UIImage *)imageFromSDKWithName:(NSString*)ressourceName
{
    return [ODResourcesManager imageWithName:ressourceName];
}

@end
