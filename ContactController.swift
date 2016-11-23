//
//  ContactController.swift
//  salomon_io
//
//  Created by Salomon Valverde on 11/23/16.
//
//
import Vapor
import HTTP

final class ContactController {
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func show(_ request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("contact")
    }
}
