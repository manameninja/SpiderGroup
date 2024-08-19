//
//  DataService.swift
//
//  Created by Даниил Павленко on 18.08.2024.
//

// MARK: - DataService

public protocol DataService {
    
    func obtainOptions() async -> Result<[Option], Error>
}
