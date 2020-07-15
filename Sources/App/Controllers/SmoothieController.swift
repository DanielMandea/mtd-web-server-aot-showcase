//
//  File.swift
//  
//
//  Created by Daniel Mandea on 15/07/2020.
//

import Fluent
import Vapor

struct SmoothieController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("smoothie")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":smoothieID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Smoothie]> {
        return Smoothie.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Smoothie> {
        let smoothie = try req.content.decode(Smoothie.self)
        return smoothie.save(on: req.db).map { smoothie }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Smoothie.find(req.parameters.get("smoothieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}

