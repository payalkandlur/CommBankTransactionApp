//
//  NetworkLayer.swift
//  CommBankAssignmentSkeleton
//
//  Created by Payal Kandlur on 1/31/24.
//

import Foundation

protocol NetworkServiceProtocol {
//    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func fetchDataFromJson<T: Decodable>(from fileName: String, type: T.Type) -> T?
}

class NetworkService: NetworkServiceProtocol {
    
//    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                let error = NSError(domain: "Data not received", code: 0, userInfo: nil)
//                completion(.failure(error))
//                return
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(decodedData))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
    
    // Fetch data from local JSON
    func fetchDataFromJson<T: Decodable>(from fileName: String, type: T.Type) -> T? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("File not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch let error as DecodingError {
            print("Decoding error: \(error.localizedDescription)")
        } catch let error as NSError {
            print("Error reading data: \(error.localizedDescription)")
        } catch {
            print("Unknown error occurred.")
        }
        
        return nil
    }
}
