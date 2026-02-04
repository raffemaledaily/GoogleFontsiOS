//
//  GFIFontLoader.m
//  GoogleFontsiOS
//
//  Created by Okada Yohei on 8/4/15.
//  Copyright (c) 2015 yohei okada. All rights reserved.
//

#import "GFIFontLoader.h"

#import <CoreText/CoreText.h>

@interface GFIFontLoader ()
+ (void)loadFontFile:(NSString *)fontFileName fromBundle:(NSString *)bundleName;
@end

@implementation GFIFontLoader
+ (void)loadFontFile:(NSString *)fontFileName fromBundle:(NSString *)bundleName {
    NSURL *bundleURL = [[NSBundle bundleForClass:[self class]] URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *bundle = bundleURL ? [NSBundle bundleWithURL:bundleURL] : [NSBundle bundleForClass:[self class]];
    
    NSURL *fontURL = [bundle URLForResource:fontFileName withExtension:@"ttf"];
    NSData *fontData = [NSData dataWithContentsOfURL:fontURL];
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);

    if (font) {
        CFErrorRef error = NULL;
        if (CTFontManagerRegisterGraphicsFont(font, &error) == NO) {
            CFStringRef errorDescription = error ? CFErrorCopyDescription(error) : NULL;
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:(__bridge_transfer NSString *)errorDescription
                                         userInfo:@{ NSUnderlyingErrorKey: (__bridge NSError *)error ?: (id)kCFNull }];
        }
        CGFontRelease(font);
    }

    if (provider) {
        CGDataProviderRelease(provider);
    }
}

+ (void)loadFontFile:(NSString *)fontFileName
          fromBundle:(NSString *)bundleName
           onceToken:(dispatch_once_t *)onceToken {
    dispatch_once(onceToken, ^{
        [self loadFontFile:fontFileName fromBundle:bundleName];
    });
}

@end
