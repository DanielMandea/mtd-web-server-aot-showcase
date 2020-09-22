import Fluent
import FluentPostgresDriver
import Vapor
import Leaf

// configures your application

extension Application {
    static let databaseUrl = URL(string: "postgres://vapor_user:root@localhost:5432/todos")!
}


public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // Configure Leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    
    // Configure PGSQL
//    try app.databases.use(.postgres(url: Application.databaseUrl), as: .psql)
    
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? Application.databaseUrl.host!,
        username: Environment.get("DATABASE_USERNAME") ?? Application.databaseUrl.user!,
        password: Environment.get("DATABASE_PASSWORD") ?? Application.databaseUrl.password!,
        database: Environment.get("DATABASE_NAME") ?? "todos"
    ), as: .psql)
    
    // Configure migrations 
    app.migrations.add(CreateTodo())
    
    // Configure migrations
    app.migrations.add(CreateSmoothie())
    
    // register routes
    try routes(app)
}
