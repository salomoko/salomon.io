//
//  ContactController.swift
//  salomon_io
//
//  Created by Salomon Valverde on 11/23/16.
//
//
import Vapor
import HTTP
import SMTP
import Transport

final class ContactController {
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func show(_ request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("contact")
    }
    
    func send(_ request: Request) throws -> ResponseRepresentable {
        
        guard let name = request.data["name"]?.string else {
            throw Abort.badRequest
        }
        
        guard let emailAddress = request.data["email"]?.string else {
            throw Abort.badRequest
        }
        
        guard let subject = request.data["subject"]?.string else {
            throw Abort.badRequest
        }
        guard let message = request.data["message"]?.string else {
            throw Abort.badRequest
        }
        
        let credentials = SMTPCredentials(
            user: drop.config["smtp", "sendgrid", "username"]?.string ?? "",
            pass: drop.config["smtp", "sendgrid", "password"]?.string ?? ""
        )
        
        let from = EmailAddress(name: name,
                                address: emailAddress
        )
        let to = "salomon.valverde@gmail.com"
        let email = Email(from: from,
                          to: to,
                          subject: "Message from salomon.io — \(subject)",
                          body: message
        )
        
        let client = try SMTPClient<TCPClientStream>.makeSendGridClient()
        let (code, greeting) = try client.send(email, using: credentials)
        
        return "Successfully sent email: \(code) \(greeting)"
    }
}
