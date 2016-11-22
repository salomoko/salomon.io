//
//  Request+Utilities.swift
//  salomon_io
//
//  Created by Salomon Valverde on 11/22/16.
//
//

import HTTP
import JSON


extension Request {
    var baseUrl: String? {
        guard let host = headers["Host"]?.finished(with: "/") else { return nil }
        return "\(uri.scheme)://\(host)"
    }
}
