//
//  PlaceHolderModels.swift
//  JSONPlaceHolderApiDemo
//
//  Created by James Klitzke on 1/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

class JSONModel : NSObject {
    
    init(data: Any?) {
        super.init()
        if let jsonDictionary = data as? [String : Any] {
            setValuesForKeys(jsonDictionary)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("WARNING: Tried to set value for undfined key = \(key)")
    }
}

class User : JSONModel {
    
    
    var id : Int?
    var name : String?
    var username : String?
    var email : String?
    var phone : String?
    var website : String?
    var address : Address?
    var company : Company?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "id" {
            id = value as? NSNumber as Int?
        }
        else if key == "address" {
            address = Address(data: value)
        }
        else if key == "company" {
            company = Company(data: value)
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}

class Address : JSONModel {
    var street : String?
    var suite : String?
    var city : String?
    var zipcode : String?
    var geo : Geo?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "geo" {
            geo = Geo(data: value)
        }
        else {
            super.setValue(value, forKey: key)
        }
    }


}

class Geo : JSONModel {
    var lat : String?
    var lng : String?
}

class Company : JSONModel {
    var name : String?
    var catchPhrase : String?
    var bs : String?
    
}
