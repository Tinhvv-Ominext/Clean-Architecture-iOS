//
//  Observable.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

/// Common network error
enum NetworkError : Swift.Error {
         // parsing failed
    case ParseJSONError
         // The network request has an error
    case RequestFailed
         // Received no data
    case NoResponse
         // The server returned an error code
    case UnexpectedResult(resultCode: Int?, resultMsg: String?)
}

/// Define common status code
enum RequestStatus: Int {
    case requestSuccess = 200
    case requestError
}

/// Base response key
let RESULT_CODE = "code"
let RESULT_MSG = "message"
let RESULT_DATA = "data"

extension Observable {
    
    /// map response object to ObjectMapper model
    /// - Parameter type: model type
    func mapResponseToObject<T: BaseMappable>(type: T.Type) -> Observable<T> {
        return map { response in
            
            // get Moya.Response
            guard let response = response as? Moya.Response else {
                throw NetworkError.NoResponse
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw NetworkError.RequestFailed
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
                throw NetworkError.NoResponse
            }
            
            
            if let code = json[RESULT_CODE] as? Int {
                if code == RequestStatus.requestSuccess.rawValue {
                    let data =  json[RESULT_DATA]
                    if let data = data as? [String: Any] {
                        let object = Mapper<T>().map(JSON: data)!
                        return object
                    }else {
                        throw NetworkError.ParseJSONError
                    }
                } else {
                    throw NetworkError.UnexpectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
                }
            } else {
                throw NetworkError.ParseJSONError
            }
            
        }
    }
    
    /// map response object to array of ObjectMapper model
    /// - Parameter type: model type
    func mapResponseToObjectArray<T: BaseMappable>(type: T.Type) -> Observable<[T]> {
        return map { response in
            
            // get Moya.Response
            guard let response = response as? Moya.Response else {
                throw NetworkError.NoResponse
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw NetworkError.RequestFailed
            }
 
            guard let json = try? (JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String: Any])  else {
                throw NetworkError.NoResponse
            }
            
            
            if let code = json[RESULT_CODE] as? Int {
                if code == RequestStatus.requestSuccess.rawValue {
                    var objects = [T]()
                    guard let objectsArrays = json[RESULT_DATA] as? [Any] else {
                        throw NetworkError.ParseJSONError
                    }
                    for object in objectsArrays {
                        if let data = object as? [String: Any] {
                            let object = Mapper<T>().map(JSON: data)!
                            objects.append(object)
                        }
                    }
                    return objects
 
                } else {
                    throw NetworkError.UnexpectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
 
                }
            } else {
                throw NetworkError.ParseJSONError
            }
        }
    }
}
