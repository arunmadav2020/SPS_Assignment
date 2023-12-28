//
//  main.swift
//  CocktailBook
//
//  Created by Arun Kumar on 12/12/2023.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain( CommandLine.argc,
                   CommandLine.unsafeArgv,
                   nil, NSStringFromClass(appDelegateClass))
