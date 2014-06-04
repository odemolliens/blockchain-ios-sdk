//
//  ODSDKBundleManager.m
//  ODiSyFramework
//
//  Created by Olivier Demolliens on 17/03/2014.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODSDKFilesManager.h"

@implementation ODSDKFilesManager


+ (NSBundle *)sdkBundle
{
    NSString* frameworkBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",kBundleResources]];
    return [NSBundle bundleWithPath:frameworkBundlePath];
}

+ (NSString *)sdkLocalizable
{
    return kBundleLocalizableName;
}

@end
