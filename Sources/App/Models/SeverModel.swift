//
//  SeverModel.swift
//  App
//
//  Created by 徐兆陽 on 2018/12/29.
//
import Vapor
import FluentMySQL
import FluentPostgreSQL
final class SeverModel: Codable {
    var id: Int?
    var myaccount: String
    var mypassword: String
    var inUsed:String
    init(myaccount: String, mypassword: String,inUsed:String) {
        self.myaccount = myaccount
        self.mypassword = mypassword
        self.inUsed = "0"
    }
}
//extension SeverModel: MySQLModel {}
extension SeverModel: Migration {}
extension SeverModel: Content {}
extension SeverModel: Parameter {}
extension SeverModel: PostgreSQLModel {}
