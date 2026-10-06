//
//  Model.swift
//  APIapp
//
//  Created by Mac on 01.10.2026.
//

import Foundation

struct Character: Identifiable, Codable{
    let id: Int
    let name: String
    let image: String
    
    
}

struct APIresponse: Codable{
    let results: [Character]
    
}
