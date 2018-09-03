//
//  File.swift
//  whosMyRep
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


struct ResultForGivenState: Codable {
    
    let result : [Representative]
    
}


struct Representative: Codable {
    
    let district: String
    let link    : String
    let name    : String
    let office  : String
    let party   : String
    let phone   : String
    let state   : String
    
}
