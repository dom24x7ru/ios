//
//  RecomendationObject.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 13.05.2021.
//

import Foundation

struct RecomendationObject: Codable {
    
    public var id: Int
    
    public var title: String
    
    public var body: String
    
    public var extra: RecommendationExtraObject
    
    public var category: RecomendationCategoryObject

    public var person: PersonMinObject
    
}
