//
//  Session.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 24/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation

enum SessionDataType: String {
    case bool
    case string
    case object
}

enum SessionData: String {
    
    case marketId
    
    var type: SessionDataType {
        switch self {
        case .marketId:
            return .string
        }
    }
    
}

final class Session {
    
    public static var shared = Session()
    
    var marketId: String {
        set {
            update(.marketId, value: newValue)
        }
        get {
            guard let marketId = load(.marketId) as? String else { return "" }
            return marketId
        }
    }
    
    
    private func update(_ data: SessionData, value: Any?) {
        switch data.type {
        case .object:
            guard let value = value else {
                UserDefaults.standard.set(nil, forKey: data.rawValue)
                UserDefaults.standard.synchronize()
                
                return
            }
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: value)
            UserDefaults.standard.set(encodedData, forKey: data.rawValue)
            UserDefaults.standard.synchronize()
        default:
            UserDefaults.standard.set(value, forKey: data.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    private func load(_ data: SessionData) -> Any? {
        switch data.type {
        case .string:
            return UserDefaults.standard.string(forKey: data.rawValue)
        case .bool:
            return UserDefaults.standard.bool(forKey: data.rawValue)
        case .object:
            guard let decoded = UserDefaults.standard.object(forKey: data.rawValue) as? Data else {
                return nil
            }
            return NSKeyedUnarchiver.unarchiveObject(with: decoded)
        }
    }
    
    private func updateObject<T>(_ data: SessionData, value: T?) where T: Encodable {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: data.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func loadObject<T>(_ data: SessionData) -> T? where T: Decodable {
        guard let decoded = UserDefaults.standard.object(forKey: data.rawValue) as? Data else {
            return nil
        }
        return try? PropertyListDecoder().decode(T.self, from: decoded)
    }
}
