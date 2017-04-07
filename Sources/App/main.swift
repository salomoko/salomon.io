
import Vapor
import HTTP

let drop = Droplet()

// MARK: Landing Pages

drop.get { _ in return try drop.view.make("welcome") }

// MARK: Contact

let contactController = ContactController(droplet: drop)
drop.get("contact", handler: contactController.show)

drop.post("contact", "send") { request in
    try contactController.send(request)
}

// MARK: Contact

drop.get("login") { request in
    return try drop.view.make("login")
}

drop.run()
