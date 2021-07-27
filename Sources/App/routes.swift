import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!!!!!!"
    }
    
    let tasks = app.grouped("tasks")
    tasks.get { req in
        Task.query(on: req.db).all()
    }
    
    tasks.post(use: create)
}

func create(req: Request) throws -> EventLoopFuture<Task> {
    let task = try req.content.decode(Task.self)
    return task.create(on: req.db).map { task }
}

func read() {
}

func update() {
}

func delete() {
}
