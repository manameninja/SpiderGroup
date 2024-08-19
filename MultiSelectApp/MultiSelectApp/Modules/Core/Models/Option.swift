//
//  Option.swift
//
//  Created by Даниил Павленко on 18.08.2024.
//

import Foundation

// MARK: - Option

public struct Option: Identifiable, Decodable {
    
    // MARK: - Proprties
    
    public let id: Int
    public let title: String
    public let required: Bool
    public let tappedOnSelectAll: Bool
    public var isSelected: Bool = false
    
    // MARK: - Initializer
    
    public init(id: Int, title: String, required: Bool, tappedOnSelectAll: Bool, isSelected: Bool) {
        self.id = id
        self.title = title
        self.required = required
        self.tappedOnSelectAll = tappedOnSelectAll
        self.isSelected = isSelected
    }
}
