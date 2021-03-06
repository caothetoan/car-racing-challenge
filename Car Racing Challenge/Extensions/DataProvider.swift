//
//  DataProvider.swift
//  Car Racing Challenge
//
//  Created by Alex Ongarato on 3/20/15.
//  Copyright (c) 2015 Alex Ongarato. All rights reserved.
//

import Foundation
import CoreData

private var _private_nsuser_defaults    : UserDefaults!;
private var _private_domain             : String = ".cacheDomain";
class DataProvider
{
    class func didFinishLaunchingWithOptions()
    {
        
        if let bundle = Bundle.main.bundleIdentifier
        {
            _private_domain = "\(bundle)\(_private_domain)";
        }
        
        if(_private_nsuser_defaults == nil)
        {
            _private_nsuser_defaults = UserDefaults(suiteName: _private_domain);
            
            print("DataProvider -> initialized \(_private_domain)");
        }
    }
    
    class func createKey(_ suiteName:NSString, key:NSString) -> String
    {
        return "\(suiteName)-\(key)";
    }
    
    //################## USER DEFAULTS #####################
    class func getString(_ suiteName:String, key:String) -> String
    {
        var temp:String = "";
        
        if let str = getData(suiteName, key:key) as? String
        {
            temp  = str;
        }
        
        return temp;
    }
    
    class func getInteger(_ suiteName:String, key:String) -> Int
    {
        var temp:Int = -1;
        
        if let str = getData(suiteName, key:key) as? Int
        {
            temp  = str;
        }
        
        return temp;
    }
    
    class func getData(_ suiteName:String, key:String) -> AnyObject!
    {
        if let object: AnyObject = _private_nsuser_defaults.object(forKey: createKey(suiteName as NSString, key:key as NSString)) as AnyObject?
        {
            return object;
        }
        else
        {
            return nil;
        }
    }
    
    class func getBoolData(_ suiteName:String, key:String) -> Bool
    {
        let object: Bool = _private_nsuser_defaults.bool(forKey: createKey(suiteName as NSString, key:key as NSString))
        return object;
    }
    
    class func saveData(_ suiteName:String, key:String, object:AnyObject!) -> Bool
    {
        if(object == nil)
        {
            return false;
        }
        
        _private_nsuser_defaults.set(object, forKey: createKey(suiteName as NSString, key:key as NSString));
        _private_nsuser_defaults.synchronize();
        
        return true;
    }
    
    class func saveData(_ suiteName:String, key:String, string:NSString!) -> Bool
    {
        if(string == nil)
        {
            return false;
        }
        
        _private_nsuser_defaults.setValue(string, forKey: createKey(suiteName as NSString, key:key as NSString));
        _private_nsuser_defaults.synchronize();
        
        return true;
    }
    
    class func saveData(_ suiteName:String, key:String, value:Int)
    {
        _private_nsuser_defaults.set(value, forKey: createKey(suiteName as NSString, key:key as NSString));
        _private_nsuser_defaults.synchronize();
    }
    
    class func saveData(_ suiteName:String, key:String, value:Bool)
    {
        _private_nsuser_defaults.set(value, forKey: createKey(suiteName as NSString, key:key as NSString));
        _private_nsuser_defaults.synchronize();
    }
    
    fileprivate class func emptySpaceForName(_ suiteName:String)
    {
        let keys:NSArray = NSDictionary(dictionary: _private_nsuser_defaults.dictionaryRepresentation()).allKeys as NSArray;

        for i in 0 ..< keys.count
        {

            let key:String = keys[i] as! String;
            if(key.hasPrefix(suiteName))
            {
                print("removing[\(i)]: \(key)");
                _private_nsuser_defaults.removeObject(forKey: key);
            }
        }
        
        _private_nsuser_defaults.synchronize();
        print("DataProvider -> Cache cleaned.");
    }
}

struct SuiteNames
{
    static var SuiteBestScore   : String = "game_score_suite";
    static var KeyBestScore     : String = "game_score_key";
    
    static var SuiteConfigs     : String = "game_configs_suite";
    static var KeySound         : String = "game_sound_key";
    static var KeyAds           : String = "game_ads_key";
    static var KeyFirstTime     : String = "game_first_time_key";
}
