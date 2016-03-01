//
//  NSUserDefaults.swift
//  Silverback
//
//  Created by Christian Otkjær on 05/11/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Helper

public extension NSUserDefaults
{
    internal func setOrRemoveObject(object: AnyObject?, forKey key:String)
    {
        if let object = object
        {
            setObject(object, forKey: key)
        }
        else
        {
            removeObjectForKey(key)
        }
    }
}

// MARK: - Text

public extension NSUserDefaults
{
    func setText(text: String?, defaultText: String? = nil, forKey key: String)
    {
        setOrRemoveObject(text ?? defaultText, forKey: key)
    }
    
    func textForKey(key: String, defaultText: String?) -> String?
    {
        return (objectForKey(key) as? String) ?? defaultText
    }
}

//MARK: - Array

public extension NSUserDefaults
{
    func setArray<T where T:AnyObject>(array: Array<T>?, defaultArray: Array<T>? = nil, forKey key: String)
    {
        setOrRemoveObject(array ?? defaultArray, forKey: key)
    }
    
    func arrayForKey<T where T:AnyObject>(key: String, defaultArray: Array<T>?) -> Array<T>?
    {
        return (arrayForKey(key) as? Array<T>) ?? defaultArray
    }
}

//MARK: - Codable

public extension NSUserDefaults
{
    func setCodable<C: NSCoding>(codable: C?, defaultCodable: C? = nil, forKey key: String)
    {
        setOrRemoveObject((codable ?? defaultCodable)?.archivableData, forKey: key)
    }
    
    func codableForKey<C: NSCoding>(key: String, defaultCodable: C? = nil) -> C?
    {
        return dataForKey(key)?.asCodable(C) ?? defaultCodable
    }
}

// MARK: - Data

extension NSData
{
    func asCodable<C:NSCoding>(type: C.Type) -> C?
    {
        return NSKeyedUnarchiver.unarchiveObjectWithData(self) as? C
    }
}


// MARK: - NSObject

internal extension NSCoding
{
    var archivableData : NSData { return NSKeyedArchiver.archivedDataWithRootObject(self) }
}


// MARK: - Optionals

internal extension NSKeyedArchiver
{
    class func archivedDataWithOptionalRootObject(rootObject: AnyObject?) -> NSData?
    {
        if let rootObject = rootObject
        {
            return archivedDataWithRootObject(rootObject)
        }
        
        return nil
    }
}
