//
//  ODLocalizableManager.m
//  ODiSyFramework
//
//  Created by Olivier Demolliens on 17/03/2014.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "ODLocalizableManager.h"

//Bundle Manager
#import "ODSDKFilesManager.h"

@interface ODLocalizableManager()
{
    
}

@end

@implementation ODLocalizableManager


+ (NSString *)stringFromSDKWithKey:(NSString *)key withComment:(NSString *)comment
{
    
    NSBundle *cBundle = [ODSDKFilesManager sdkBundle];
    
    if(cBundle==nil) {
        NSLog(@"SDK bundle path is not setted correctly:%@",cBundle);
        return nil;
    }
    
    NSString *cLocalizableFile = kBundleLocalizableName;
    
    if([cLocalizableFile length]==0) {
        NSLog(@"SDK localizable name is not setted correctly:%@",cBundle);
        return nil;
    }
    
    return [cBundle localizedStringForKey:key value:comment table:cLocalizableFile];
}



@end
