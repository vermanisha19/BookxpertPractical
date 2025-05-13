//
//  APIHelper.swift
//  BookxpertPractical
//
//  Created by MACM13 on 15/04/25.
//


import Alamofire
import Foundation

class APIHelper {
    
    static let shared = APIHelper()
    private init() {}
    
    func fetchAPIData<T: Decodable>(url: String) async throws -> T {
        let response = await AF.request(url)
            .serializingDecodable(T.self)
            .response
        
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
