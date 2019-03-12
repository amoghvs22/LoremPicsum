//
//  UserModel.swift
//  LoremPicsum
//
//  Created by Mac Mini on 11/03/19.
//

import Foundation

struct UserInfo: Codable {
    let results: [Info]
}

struct Info:Codable {
    let name: NameInfo
    let picture: PictureInfo
}

struct NameInfo:Codable {
    let first: String
    let last: String
}

struct PictureInfo:Codable {
    let medium: String
    let large: String
}

class UserModel:Codable {
    
    static func initializeModel(userData: Data) -> UserInfo? {
        do {
            return try JSONDecoder().decode(UserInfo.self, from: userData)
        }
        catch {
            print(error)
            return nil
        }
    }
}
