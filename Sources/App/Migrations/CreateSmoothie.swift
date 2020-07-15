//
//  File.swift
//  
//
//  Created by Daniel Mandea on 15/07/2020.
//

import Fluent

struct CreateSmoothie: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("smoothie")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("ingredinets", .string, .required)
            .field("calories", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("smoothie").delete()
    }
}
