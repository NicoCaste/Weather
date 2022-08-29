//
//  WebServiceProtocol.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation
enum HttpMethod: String {
    case get
    case post
}

protocol WebService {
    func post(_ urlString: String, parameters:  Parameters, completion: @escaping(Result<Data, Error>) -> Void)
    func get(_ urlString: String, parameters:  Parameters, completion: @escaping(Result<Data, Error>) -> Void)
}
