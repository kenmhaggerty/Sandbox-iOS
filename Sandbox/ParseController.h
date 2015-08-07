//
//  ParseController.h
//  Sandbox
//
//  Created by Ken M. Haggerty on 8/7/15.
//  Copyright (c) 2015 MCMDI. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <Foundation/Foundation.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

@interface ParseController : NSObject

// PUSH NOTIFICATIONS //
+ (BOOL)shouldProcessPushNotificationWithData:(NSDictionary *)notificationPayload
+ (void)pushNotificationWithData:(NSDictionary *)data recipients:(NSArray *)recipients;

@end