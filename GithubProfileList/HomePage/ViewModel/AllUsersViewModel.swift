//
//  AllUsersViewModel.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 04/08/18.
//  Copyright © 2018 Pankaj Bhardwaj. All rights reserved.
//

class AllUsersViewModel: BaseViewModel {
    
    private var currentPage : Int = 0
    private var pageSize : Int = 30
    private var requestUseCase :AllUsersRequestUseCase?
    var boolLoading : Bool = false
    var boolMoreDataAvailable : Bool = true
    var arrUserData : [UserResponseDTO]?
    
    func getUserInfoFromStarting(completionHandler :@escaping (String?)->Void,useCase : AllUsersRequestUseCase = AllUsersRequestUseCase()) {
        currentPage = 0
        pageSize = 30
        boolMoreDataAvailable = true
        getUserInfo(pageNo: currentPage, pageSize: pageSize, completionHandler: completionHandler,useCase: useCase)
    }
    func getNextUserInfo(completionHandler :@escaping (String?)->Void,useCase : AllUsersRequestUseCase = AllUsersRequestUseCase()) {
        getUserInfo(pageNo: currentPage, pageSize: pageSize, completionHandler: completionHandler,useCase: useCase)
    }
    
    private func getUserInfo(pageNo : Int , pageSize : Int ,  completionHandler : @escaping(String?)->Void ,useCase : AllUsersRequestUseCase = AllUsersRequestUseCase() ) {
        boolLoading = true;
        let requestDTO = UserRequestDTO(pageSize: pageSize, page: pageNo)
        requestUseCase = useCase
        requestUseCase?.initialize(requestDTO: requestDTO, completionHandler: { (responseDTO,limitReached, error) in
            self.boolLoading = false
            if(error != nil)
            {
                completionHandler(error.debugDescription)
            }else
            {
                if self.pageSize == 30 {
                    self.arrUserData = responseDTO
                }else {
                    self.arrUserData? += responseDTO!
                }
                self.pageSize = self.pageSize + 30
                completionHandler(limitReached?.message)
            }
        })
    }
    
}
