//
//  PlistUtil.swift
//  pipiatum_core
//
//  Created by KC Leung on 3/11/2017.
//  Copyright © 2017 Trumptech. All rights reserved.
//

import UIKit

class PlistUtil {
    
    /**
     Extract NSDictionary from plist file.
     
     @param named Name of the plist file.
     @param subdirectory Path of the plist file.
     
     @return Extracted NSDictionary from plist file.
     */
    static func load(named: String, subdirectory: String? = nil) -> NSDictionary? {
        var plist: NSDictionary?
        if let URL = Bundle.main.url(forResource: named, withExtension: "plist", subdirectory: subdirectory) {
            plist = NSDictionary(contentsOf: URL)
        }
        return plist
    }
    
    /**
     Read CGSize from NSDictionary.
     
     @param data The NSDictionary that contained the CGSize data.
     
     @return The CGSize from NSDictionary.
     */
    static func readSize(data: NSDictionary) -> CGSize? {
        if
            let w = data.value(forKey: "Width") as? Int,
            let h = data.value(forKey: "Height") as? Int
        {
            return CGSize.init(width: w, height: h)
        } else {
            return nil
        }
    }
    
    /**
     Collect CGSize from NSDictionary list.
     
     @param data The list of NSDictionary that contained the CGSize data.
     
     @return The list of CGSize.
     */
    static func readSizes(data: [NSDictionary]) -> [CGSize]? {
        var sizes:[CGSize] = Array()
        for d in data {
            if let size = readSize(data: d) {
                sizes.append(size)
            }
        }
        return sizes
    }
    
}
