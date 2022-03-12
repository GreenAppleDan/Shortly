//
//  Result.swift
//  Shortly
//
//  Created by Denis on 12.03.2022.
//

import Foundation

/// Result of asynchronous execution
///
/// - Note: Added to not be confused with`Alamofire.Result`.
typealias AsyncResult<Value> = Swift.Result<Value, Swift.Error>

/// Result Handler.
typealias ResultHandler<Value> = (AsyncResult<Value>) -> Void
