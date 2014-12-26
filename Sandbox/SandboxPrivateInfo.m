//
//  SandboxPrivateInfo.m
//  Sandbox
//
//  Created by Ken M. Haggerty on 7/23/13.
//  Copyright (c) 2013 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Private) //

// [_] Add in security check from sender?

#pragma mark - // IMPORTS (Private) //

#import "SandboxPrivateInfo.h"
#import "AKDebugger.h"

#pragma mark - // DEFINITIONS (Private) //

#define PRIVATE_DOCS @"Private Documents"

@interface SandboxPrivateInfo ()
@property (nonatomic, strong) NSString *pathForPrivateDocs;
+ (SandboxPrivateInfo *)sharedInfo;
@end

@implementation SandboxPrivateInfo

#pragma mark - // SETTERS AND GETTERS //

@synthesize pathForPrivateDocs = _pathForPrivateDocs;

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS (Getters) //

+ (NSString *)pathForPrivateDocs
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategory:@"Accounts" message:nil];
    
    SandboxPrivateInfo *sharedInfo = [SandboxPrivateInfo sharedInfo];
    NSString *pathForPrivateDocs = [sharedInfo pathForPrivateDocs];
    if (!pathForPrivateDocs)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        pathForPrivateDocs = [[paths objectAtIndex:0] stringByAppendingPathComponent:PRIVATE_DOCS];
        if (![[NSFileManager defaultManager] fileExistsAtPath:pathForPrivateDocs])
        {
            NSError *error;
            if (![[NSFileManager defaultManager] createDirectoryAtPath:pathForPrivateDocs withIntermediateDirectories:YES attributes:nil error:&error])
            {
                [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeError methodType:AKMethodTypeGetter customCategory:nil message:[NSString stringWithFormat:@"%@, %@", error, [error userInfo]]];
                pathForPrivateDocs = nil;
            }
        }
        [sharedInfo setPathForPrivateDocs:pathForPrivateDocs];
    }
    return pathForPrivateDocs;
}

+ (NSURL *)applicationDocumentsDirectory
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategory:@"Core Data" message:nil];

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

+ (SandboxPrivateInfo *)sharedInfo
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter customCategory:nil message:nil];
    
    static SandboxPrivateInfo *sharedInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInfo = [[SandboxPrivateInfo alloc] init];
    });
    return sharedInfo;
}

@end