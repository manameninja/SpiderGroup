//
//  Loc.swift
//
//  Created by Даниил Павленко on 19.08.2024.
//

import Foundation

public func loc(_ string: String) -> String {
    let result = NSLocalizedString(string, tableName: nil, bundle: .main, value: "", comment: "")
    return result == string ? "" : result
}
