
import Vapor
import HTTP
import JSON
import SMTP
import Transport

let drop = Droplet()

// MARK: Landing Pages

drop.get { _ in return try drop.view.make("welcome") }

// MARK: Contact

let contactController = ContactController(droplet: drop)
drop.get("contact", handler: contactController.show)

drop.post("contact/create") { request in
    guard let name = request.data["name"]?.string else {
        throw Abort.badRequest
    }
    guard let message = request.data["message"]?.string else {
        throw Abort.badRequest
    }
    
    let credentials = SMTPCredentials(
        user: "salomon_io",
        pass: "nopassworD84"
    )
    
    let from = EmailAddress(name: "Vapor Email",
                            address: "noreply@salomon.io"
    )
    let to = "salomon.valverde@gmail.com"
    let email = Email(from: from,
                      to: to,
                      subject: "Hello from Vapor SMTP 👋",
                      body: message
    )
    
    let client = try SMTPClient<TCPClientStream>.makeSendGridClient()
    let (code, reply) = try client.send(email, using: credentials)
    
    return "Successfully sent email: \(code) \(reply)"
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
