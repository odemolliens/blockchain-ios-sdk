//
//  ODResourcesManager.m
//  ODiSyFramework
//
//  Created by Olivier Demolliens on 14/03/2014.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODResourcesManager.h"

//Bundle Manager
#import "ODSDKFilesManager.h"

@interface ODResourcesManager()
{
    
}

+ (NSBundle *)currentBundle;

@end

@implementation ODResourcesManager

#pragma mark - Init

+ (NSBundle *)currentBundle {
    static NSBundle* fwBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fwBundle = [[ODSDKFilesManager sdkBundle] retain];
    });
    return fwBundle;
}

#pragma mark - Util

+ (UIImage *)imageWithName:(NSString*)ressourceName
{
    return [UIImage imageWithContentsOfFile:[[[self class] currentBundle] pathForResource:ressourceName ofType:@"png"]];
}


@end
