//
//  AllUsersRequestUseCase.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 04/08/18.
//  Copyright © 2018 Pankaj Bhardwaj. All rights reserved.
//

import UIKit

struct UserRequestDTO : BaseRequestDTO {
    var pageSize : Int?
    var page : Int?
    func createGetRequestUrl(url:String)-> URL?{
        //TODO : create
        return URL(string: url + "\(pageSize ?? 0)")
    }
    
}
struct UserResponseDTO : BaseResponseDTO ,Decodable{
    var login: String?
    var id: Int?
    var avatar_url: String?
}

class AllUsersRequestUseCase: BaseRequestUseCase<UserRequestDTO,UserResponseDTO > {
    
    var sessionTask : URLSessionTask?
    
    func initialize(requestDTO : UserRequestDTO,completionHandler:@escaping([UserResponseDTO]?,LimitExceeds?,Error?)->Void) {
        let baseUrl = Constants.gitAllUsersUrl
        let url = requestDTO.createGetRequestUrl(url: baseUrl)
        sessionTask?.cancel()
        sessionTask = super.getDataFromServerUsingGet(url: url!, requestDto: requestDTO, completionHandler: completionHandler)
    }
    override func decode(data: Data) throws -> ([UserResponseDTO]?, LimitExceeds?) {
        let decoder = JSONDecoder()
        
        do {
            return try (decoder.decode([UserResponseDTO].self, from: data),nil)
        }
        catch {
            return try (nil,decoder.decode(LimitExceeds.self, from: data))
        }
    }
}

