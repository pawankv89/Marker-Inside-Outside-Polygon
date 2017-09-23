
3D Touch
=========

## 3D Touch .
------------
 Added Some screens here.
 
[![](https://github.com/pawankv89/3DTouch/blob/master/images/screen_1.png)]
[![](https://github.com/pawankv89/3DTouch/blob/master/images/screen_2.png)]
[![](https://github.com/pawankv89/3DTouch/blob/master/images/screen_3.png)]
[![](https://github.com/pawankv89/3DTouch/blob/master/images/screen_4.png)]

## Usage
------------
 iOS 9 Demo showing how to use 3D Touch on iPhone 6s devices in both Objective-C and Swift.

If 3D Touch is available, the Main View will bring up a Preview View upon shallow press (Peek), and a Commit View when the user presses deeper (Pop).

If 3D Touch is not available, a long press recognizer is implemented and calls the Preview View. Tapping the Preview View will transition back to the Main View.

Should the user disable 3D Touch while the app is running, the alternative long press recognizer is activated automatically (and disabled again if 3D Touch becomes available again).


```objective-c
- (void)createItemsWithIcons {
    
   // icons with my own images
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon1"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon2"];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon3"];
    
    // create several (dynamic) shortcut items
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.pk.Feed" localizedTitle:@"Launch Feed Controller" localizedSubtitle:@"Launch Feed Controller" icon:icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.pk.Notification" localizedTitle:@"Launch Notification Controller" localizedSubtitle:@"Launch Notification Controller" icon:icon2 userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.pk.Settings" localizedTitle:@"Launch Settings Controller" localizedSubtitle:@"Launch Settings Controller" icon:icon3 userInfo:nil];
    
    // add all items to an array
    NSArray *items = @[item1, item2, item3];
    
    // add this array to the potentially existing static UIApplicationShortcutItems
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:items];
    [UIApplication sharedApplication].shortcutItems = updatedItems;
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    // react to shortcut item selections
    NSLog(@"A shortcut item was pressed. It was %@.", shortcutItem.localizedTitle);

    // have we launched Feed
    if ([shortcutItem.type isEqualToString:@"com.pk.Feed"]) {
        [self launchViewController1];
    }
    
    // have we launched Notification
    if ([shortcutItem.type isEqualToString:@"com.pk.Notification"]) {
        [self launchViewController2];
    }
    
    // have we launched Settings
    if ([shortcutItem.type isEqualToString:@"com.pk.Settings"]) {
        [self launchViewController3];
    }
}


- (void)launchViewController1 {
    
    // grab our storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // instantiate our navigation controller
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    
    // instantiate second view controller
    FeedVC *feedVC = (FeedVC*)[storyboard instantiateViewControllerWithIdentifier:@"FeedVC"];
    
    // now push both controllers onto the stack
    [controller pushViewController:feedVC animated:NO];
    
    // make the nav controller visible
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}
- (void)launchViewController2 {
    
    // grab our storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // instantiate our navigation controller
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    
    // instantiate second view controller
    NotificationVC *notificationVC = (NotificationVC*)[storyboard instantiateViewControllerWithIdentifier:@"NotificationVC"];
    
    // now push both controllers onto the stack
    [controller pushViewController:notificationVC animated:NO];
    
    // make the nav controller visible
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

- (void)launchViewController3 {
    
    // grab our storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // instantiate our navigation controller
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    
    // instantiate second view controller
    SettingsVC *settingsVC = (SettingsVC*)[storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
    
    // now push both controllers onto the stack
    [controller pushViewController:settingsVC animated:NO];
    
    // make the nav controller visible
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

```

```objective-c

//Navigation
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Create 3D Touch
    [self createItemsWithIcons];
    
    // determine whether we've launched from a shortcut item or not
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item) {
        NSLog(@"We've launched from shortcut item: %@", item.localizedTitle);
    } else {
        NSLog(@"We've launched properly.");
    }
    
    // have we launched Feed
    if ([item.type isEqualToString:@"com.pk.Feed"]) {
        [self launchViewController1];
    }
    
    // have we launched Notification
    if ([item.type isEqualToString:@"com.pk.Notification"]) {
        [self launchViewController2];
    }
    
    // have we launched Settings
    if ([item.type isEqualToString:@"com.pk.Settings"]) {
        [self launchViewController3];
    }
    
    return YES;
}

```

### Deep Link Examples
Rather than boring log messages, I've added two options for Deep Linking a navigation controller:
 - Deep Link 1 will launch a navigation controller
 - Deep Link 2 launches a view controller that has been pushed onto the same navigation controller

```objective-c

```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each MBProgressHUD release can be found in the [CHANGELOG](CHANGELOG.mdown). 
