import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get("hello", "vapor") { req -> String in
        return "Hello Vapor!"
    }
    // 1
    router.get("api", "user") { req -> Future<[SeverModel]> in
        // 2
        return SeverModel.query(on: req).all()
    }
    
    //update
    // 1
    router.put("api", "user", SeverModel.parameter) {
        req -> Future<SeverModel> in
        // 2r
        return try flatMap(to: SeverModel.self,
                           req.parameters.next(SeverModel.self),
                           req.content.decode(SeverModel.self)) {
                            acronym, updatedAcronym in
                            // 3
                        
                            acronym.myaccount = updatedAcronym.myaccount
                            acronym.inUsed = updatedAcronym.inUsed
                            acronym.mypassword = updatedAcronym.mypassword
                            // 4
                            return acronym.save(on: req)
        }
    }
    
    
    // 1
    router.post("api", "user") { req -> Future<SeverModel> in
        // 2
        return try req.content.decode(SeverModel.self)
            .flatMap(to: SeverModel.self) { acronym in
                // 3
                return acronym.save(on: req)
        } }
}
