// 1
import FluentPostgreSQL
import Vapor
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws { // 2
    try services.register(FluentPostgreSQLProvider())
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)
    // Configure a database
    // 1
    var databases = DatabasesConfig()
    // 2
    
    let databaseConfig: PostgreSQLDatabaseConfig
    if let url = Environment.get("DATABASE_URL") {
        databaseConfig = PostgreSQLDatabaseConfig(url: url)!
    }
    else {
        let hostname = Environment.get("DATABASE_HOSTNAME")
            ?? "localhost"
        let username = Environment.get("DATABASE_USER") ?? "vapor"
        let databaseName = Environment.get("DATABASE_DB") ?? "vapor"
        let password = Environment.get("DATABASE_PASSWORD")
            ?? "password"
        // 3
         databaseConfig = PostgreSQLDatabaseConfig(
            hostname: hostname,
            username: username,
            database: databaseName,
            password: password)
    }
    // 4
    
    let database = PostgreSQLDatabase(config: databaseConfig)
    // 5
    databases.add(database: database, as: .psql)
    // 6
    services.register(databases)
}
