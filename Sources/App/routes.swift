import Fluent
import Vapor

struct Index: Codable {
    var title: String
    var description: String
}

struct Page: Codable {
    var content: String
}

func routes(_ app: Application) throws {
    
    app.get { req -> EventLoopFuture<View> in
        struct Context: Codable {
            var items: [Smoothie]
        }
        return Smoothie.query(on: req.db).all().flatMap { todos -> EventLoopFuture<View> in
            req.view.render("page", Context(items: todos))
        }
    }
    
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    try app.register(collection: TodoController())
    try app.register(collection: SmoothieController())
}
