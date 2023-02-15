//
//  NetworkClient.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

final class NetworkClient {
    func fetch<T:Decodable>(request:URLRequest) async throws -> T {
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.responseError}
            if (200...299).contains(httpResponse.statusCode) {
                guard let decodedData = try? JSONDecoder().decode(T.self, from:data) else {
                    throw NetworkError.encodingError
                }
                return decodedData
            }else{
                throw NetworkError.status(httpResponse.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
}
