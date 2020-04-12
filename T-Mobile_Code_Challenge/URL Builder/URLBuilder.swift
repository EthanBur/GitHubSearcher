//
//  URLBuilder.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import Foundation

class URLBuilder {
    
    private var url: String = ""
    
    init(_ url: String) {
        self.url = url
    }
    
    private func build() -> URLComponents? {
        return URLComponents(string: url)
    }
    
    static func buildURLString(scheme: String, host: String, path: String, queries: [URLQueryItem]) -> String {
        guard let url = self.buildURL(scheme: scheme, host: host, path: path, queries: queries) else {
            return ""
        }
        return url.absoluteString
    }
    
    static func buildURL(scheme: String, host: String, path: String, queries: [URLQueryItem]) -> URL? {
        var component = URLComponents()
        component.host = host
        component.scheme = scheme
        component.path = path
        component.queryItems = queries
        return URL(string: component.string ?? "")
    }
    
    var api: String {
        return "\(scheme)://\(host)\(path)"
    }
    
    var scheme: String {
        return build()?.scheme ?? ""
    }
    
    var host: String {
        return build()?.host ?? ""
    }
    
    var path: String {
        return build()?.path ?? ""
    }
    
    var query: String {
        return build()?.query ?? ""
    }
    
    var queryItems: [URLQueryItem] {
        return build()?.queryItems ?? [URLQueryItem]()
    }
    
    var queryNames: [String] {
        return queryItems.map { $0.name }
    }
    
    var queryValues: [String] {
        return queryItems.map { $0.value ?? "" }
    }
}
