import Vapor
import HTTP

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome")
}

drop.get("contact") { req in
    return try drop.view.make("contact")
}

drop.run()

extension Request {
    // Base URL returns the hostname, scheme, and port in a URL string form.
    var baseURL: String {
        return uri.scheme + "://" + uri.host + (uri.port == nil ? "" : ":\(uri.port!)")
    }
}
