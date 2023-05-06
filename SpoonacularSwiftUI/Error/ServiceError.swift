//
//  ServiceError.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 06/05/23.
//

import Foundation

struct ServiceError: Error {
  let code: String?
  let message: String?
}
