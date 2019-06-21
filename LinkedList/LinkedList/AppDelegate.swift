//
//  AppDelegate.swift
//  LinkedList
//
//  Created by Artem Lytkin on 21/06/2019.
//  Copyright © 2019 Artem Lytkin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let list = LinkedList<Int>()
        
        list.append(value: 0)
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        
        list.reverse()
        
        
        var node = createNode(0)
        addNode(node, 1)
        
        print(node?.pointee.data)
        print(node?.pointee.next.pointee.data)
        
        return true
    }

}

