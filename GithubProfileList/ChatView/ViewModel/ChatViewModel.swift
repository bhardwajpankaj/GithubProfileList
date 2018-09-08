//
//  ChatViewModel.swift
//  GithubProfileList
//
//  Created by user on 06/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

// chat view model

class ChatViewModel: BaseViewModel {
    var userSelected : UserResponseDTO?
    var dataArray = [MessagesData]()
    var tempMsgArray = [Any]()
}

struct MessagesData {
    var message:String?
    var userType:String?
}
