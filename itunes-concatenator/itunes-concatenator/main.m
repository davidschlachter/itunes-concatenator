//
//  main.m
//  itunes-concatenator
//
//  Created by David Schlachter on 2014-08-26.
//  Copyright (c) 2014 Red Eft Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

#import <Sparkle/Sparkle.h>

int main(int argc, const char * argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
