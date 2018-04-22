//
//  Task.swift
//  Task
//
//  Created by Yoshikuni Kato on 4/22/18.
//  Copyright © 2018 Yoshikuni Kato. All rights reserved.
//

import Foundation
import Result

typealias Completion<Value, Error: Swift.Error> = (Result<Value, Error>) -> Void
typealias TaskHandler<Value, Error: Swift.Error> = (@escaping Completion<Value, Error>) -> Void

struct Task<Value, Error: Swift.Error> {
    private let handler: TaskHandler<Value, Error>
    
    init(_ handler: @escaping TaskHandler<Value, Error>) {
        self.handler = handler
    }
    
    func start(_ completion: @escaping Completion<Value, Error>) {
        handler(completion)
    }
    
    func then<NewValue>(_ transform: @escaping (Value) -> Task<NewValue, Error>) -> Task<NewValue, Error> {
        return .init { completion in
            self.start { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let value):
                    transform(value).start(completion)
                }
            }
        }
    }
}
