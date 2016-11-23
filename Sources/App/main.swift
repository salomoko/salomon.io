
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

drop.get("login") { request in
    return try drop.view.make("login")
}
extension Request {
    var baseUrl: String? {
        guard let host = headers["Host"]?.finished(with: "/") else { return nil }
        return "\(uri.scheme)://\(host)"
    }
}

drop.run()
