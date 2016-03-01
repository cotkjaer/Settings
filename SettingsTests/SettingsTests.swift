//
//  SettingsTests.swift
//  SettingsTests
//
//  Created by Christian Otkjær on 26/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Settings

let settings = NSUserDefaults.standardUserDefaults()

class Codable: NSObject, NSCoding
{
    let bar: String
    
    init(bar: String)
    {
        self.bar = bar;
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(bar, forKey: "bar")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        bar = aDecoder.decodeObjectForKey("bar") as! String
        super.init()
    }
}


//MARK: - Equatable

extension Codable {
    
    override func isEqual(object: AnyObject?) -> Bool
    {
        guard object is Codable else { return false }
        
        if let codable = object as? Codable
        {
            return codable.bar == bar
        }
        
        return false
    }
}

func == (lhs: Codable, rhs:Codable) -> Bool
{
    return lhs.bar == rhs.bar
}


class SettingsTests: XCTestCase
{
    func test_Array_strings()
    {
        var strings: Array<String>?
        
        settings.setArray(strings, forKey: "strings")

        settings.synchronize()
        
//        XCTAssertNil(settings.arrayForKey("strings"))

        strings = ["a", "b", "c", "æblegrød"]

        XCTAssertEqual(strings!, settings.arrayForKey("strings", defaultArray: strings)!)

        settings.setArray(strings, forKey: "strings")
        
        XCTAssertEqual(strings!, settings.arrayForKey("strings") as! [String])
    }
    
    func test_Codable()
    {
        let c = Codable(bar: "baz")
        
        settings.setCodable(c, forKey: "c")
        
        let c2 : Codable? = settings.codableForKey("c")
        
        XCTAssertNotNil(c2)
        
        XCTAssertEqual(c, c2!)
    }
}
 