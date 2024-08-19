//
//  DataServiceImplementation.swift
//
//  Created by Даниил Павленко on 18.08.2024.
//

import Foundation

// MARK: - DataServiceImplementation

public final class DataServiceImplementation {
    
    // MARK: - Initializer
    
    public init() {
    }
}

// MARK: - DataService

extension DataServiceImplementation: DataService {
    
    public func obtainOptions() async -> Result<[Option], Error> {
        guard let url = Bundle.main.url(forResource: "options", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let options = try? JSONDecoder().decode([Option].self, from: data) else {
            // TODO: Log error if needed and add custom error type.
            print("Error loading or parsing JSON")
            return .failure(NSError())
        }
        return .success(options)
    }
}
