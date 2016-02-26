//
//  NSUserDefaults.swift
//  Silverback
//
//  Created by Christian Otkjær on 05/11/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Array

public extension NSUserDefaults
{
    func setArray<T where T:AnyObject>(array: Array<T>?, forKey key: String)
    {
        if let array = array
        {
            setObject(array, forKey: key)
        }
        else
        {
            removeObjectForKey(key)
        }
    }

    func arrayForKey<T where T:AnyObject>(key: String, defaultArray: Array<T>? = nil) -> Array<T>?
    {
        if let array = objectForKey(key) as? Array<T>
        {
            return array
        }
        
        return defaultArray
    }
}