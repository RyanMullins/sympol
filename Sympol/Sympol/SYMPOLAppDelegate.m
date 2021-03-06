//
//  SYMPOLAppDelegate.m
//  Sympol
//
//  Created by Ryan Mullins on 5/7/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLAppDelegate.h"
#import "SYMPOLEvaluationController.h"
#import "SYMPOLEvaluationModel.h"

@implementation SYMPOLAppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController * rootViewController = [[UIStoryboard storyboardWithName:@"Evaluation" bundle:nil] instantiateInitialViewController];
    
    if ([rootViewController isKindOfClass:[SYMPOLEvaluationController class]]) {
        [((SYMPOLEvaluationController *)rootViewController) setupEvaluation];
    }
    
    [[self window] setRootViewController:rootViewController];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[SYMPOLEvaluationModel sharedEvaluationModel] reset];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
