//
//  APICaller.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
import RxSwift
import Alamofire

enum NetworkError: Error {
    case noInternet
    case failedRequest
    case decodingError
}
public protocol JsonEncadable {
    func encodeToJson() -> [String: Any]?
}

public class APICaller<T> where T : Decodable {
    
    static func makeRequest(url: String,page: Int, method: HTTPMethod, paramters: [String: Any], encoding: ParameterEncoding = URLEncoding.default) -> Observable<T> {
        return Observable<T>.create{ observer in
            if !Connectivity.isConnectedToInternet() {
                observer.on(.error(NetworkError.noInternet))
            }
            let request = AF.request(url, method: method,
                                     parameters: paramters,
                                     encoding: encoding,
                                     headers: nil,
                                     interceptor: nil, requestModifier: nil)
            request.response { httpResponse in
                if httpResponse.response?.statusCode == 200 {
                    request.responseJSON(completionHandler: { response in
                        do {
                            if let data = response.data {
                                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                                observer.on(.next(decodedResponse))
                            }
                            observer.on(.completed)
                        } catch {
                            observer.onError(NetworkError.decodingError)
                        }
                    })
                } else {
                    observer.onError(NetworkError.failedRequest)
                }
            }
            return AnonymousDisposable {
                request.cancel()
                
            }
        }
    }
    
}

class AnonymousDisposable : Disposable {
    private let disposeLogic :()->Void
    
    init(_ disposeLogic :@escaping ()->Void) {
        self.disposeLogic = disposeLogic
    }
    func dispose() {
        disposeLogic()
    }
}
