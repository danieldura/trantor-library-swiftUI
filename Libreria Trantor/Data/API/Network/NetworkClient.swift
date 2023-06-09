//
//  NetworkClient.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation


protocol NetworkClientProtocol {
    func doRequest<T:Decodable>(request:APIRequestable) async throws -> T
}

final class NetworkClient:NetworkClientProtocol {
    func doRequest<T:Decodable>(request: APIRequestable) async throws -> T {
        try await fetch(apiRequest: request)
    }
    
    func fetch<T:Decodable>(apiRequest:APIRequestable) async throws -> T {
        do {
            let networkRequest = APIRequest(apiRequest: apiRequest)
            print(networkRequest.request)
            let (data,response) = try await URLSession.shared.data(for: networkRequest.request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            if (200...299).contains(httpResponse.statusCode) {
                if data.isEmpty {
                    return EmptyResponse() as! T
                }
                do {
                    let decodedData = try decodeResponse(data: data, dataType: T.self)
                    return decodedData
                } catch let error {
                    print("Error de decodificación: \(error)")
                    throw NetworkError.encodingError
                }
            }else{
                if let apiError = try? decodeResponse(data: data, dataType: APIErrorResponse.self) {
                    throw NetworkError.apiError(apiError)
                } else {
                    throw NetworkError.status(httpResponse.statusCode)
                }
            }
        } catch let error as NetworkError {
            print("General error\(error)")
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
    func decodeResponse<T: Decodable>(data: Data, dataType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
}


