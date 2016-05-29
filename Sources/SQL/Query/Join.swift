//
//  Parameter.swift
//  SQL
//
//  Created by David Ask on 23/05/16.
//
//

public struct Join {
    public enum `Type` {
        case inner(String)
        case outer(String)
    }
    
    public let leftKey: QualifiedField
    public let rightKey: QualifiedField
    public let type: Type
    
    public init(type: `Type`, leftKey: QualifiedField, rightKey: QualifiedField) {
        self.type = type
        self.leftKey = leftKey
        self.rightKey = rightKey
    }
}

extension Join: SQLStatementStringConvertible {
    public var sqlString: String {
        return "\(type.sqlString) ON \(leftKey.qualifiedName) = \(rightKey.qualifiedName)"
    }
}

extension Join.`Type`: SQLStatementStringConvertible {
    public var sqlString: String {
        switch self {
        case .inner(let table):
            return "INNER JOIN \(table)"
        case .outer(let table):
            return "OUTER JOIN \(table)"
        }
    }
}