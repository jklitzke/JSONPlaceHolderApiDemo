//
//  JsonPlaceHolderServices.swift
//  JSONPlaceHolderApiDemo
//
//  Created by James Klitzke on 1/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import Foundation

typealias FailureClosure = (_ serviceError: Error, _ response: URLResponse) -> Void
typealias ListOfUsersClosure = (_ users : [User]) -> Void

protocol JSONPlaceHolderServicesProtocol {
    
    func getListOfUsers(success : @escaping ListOfUsersClosure, failure: @escaping FailureClosure)
    
}

class JSONPlaceHolderServices : JSONPlaceHolderServicesProtocol {
    
    static let sharedInstnace = JSONPlaceHolderServices()
    
    let listOfUsersURL = URL(string: "https://jsonplaceholder.typicode.com/users")
    let defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionTask!
    
    enum CityOfChicagoServiceErrors : Error {
        case ParsingError(String)
    }
    
    func getListOfUsers(success : @escaping ListOfUsersClosure, failure: @escaping FailureClosure) {
        dataTask = defaultSession.dataTask(with: listOfUsersURL!) {
            data, response, error in
            
            guard let unWrapedResponse = response,
                let urlResponse = unWrapedResponse as? HTTPURLResponse else {
                    failure(error!, response!)
                    return
            }
            
            guard urlResponse.statusCode == 200 else {
                failure(error!, urlResponse)
                return
            }
            
            do {
                if let parssedData = data,
                    let arrayResponse = try JSONSerialization.jsonObject(with: parssedData as Data, options: []) as? [Any] {
                    
                    let users = arrayResponse.map { User(data: $0) }
                    success(users)
                    
                }
                else {
                    success([User]())
                }
            }
            catch {
                failure(error, urlResponse)
            }
        }
        
        dataTask.resume()
    }
}


//Mocking class for unit testing purpsoes
class JSONPlaceHolderServicesMock : JSONPlaceHolderServicesProtocol {
    
    func getListOfUsers(success : @escaping ListOfUsersClosure, failure: @escaping FailureClosure) {

        success([JSONPlaceHolderServicesMock.mockUser()])
        
    }
    
    static func mockUser() -> User {
        let user = User(data: nil)
        user.id = 1
        user.email = "user@somehwere.net"
        user.name = "Jane Doe"
        user.username = "jdoe153"
        user.phone = "555-1235"
        user.website = "www.something.com"
        
        let company = Company(data: nil)
        company.name = "Something Inc."
        company.catchPhrase = "Got it down!"
        company.bs = "real time something or another"
        
        let address = Address(data: nil)
        address.street = "1234 Main St."
        address.city = "Racine"
        address.zipcode = "53402"
        
        let geo = Geo(data: nil)
        geo.lat = "-37.123523"
        geo.lng = "80.1235"
        
        address.geo = geo
        
        user.company = company
        user.address = address
        
        return user

    }
}
