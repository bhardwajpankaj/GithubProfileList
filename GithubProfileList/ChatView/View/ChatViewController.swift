//
//  ChatViewController.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 04/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit
import CoreData

// Enum for distinguish message is typed by user or System
enum MessageOwner :String{
    case User
    case System
}
fileprivate let textViewSize = 50
fileprivate let placeholdertext = "Type your message"
class ChatViewController: BaseViewController{
    
    var viewModel: ChatViewModel?
    @IBOutlet weak var chatInputTextView: UITextView!
    @IBOutlet var keyboardBottomLayoutConstraint: NSLayoutConstraint?
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeChatElements()
    NotificationCenter.default.addObserver(self,selector:#selector(self.keyboardNotification(notification:)),name:NSNotification.Name.UIKeyboardWillChangeFrame,object: nil)
    }

    deinit {
        viewModel?.tempMsgArray = []
        viewModel?.dataArray = []
        // Removing observer when class deinit
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardBottomLayoutConstraint?.constant = 16.0
            } else {
                self.keyboardBottomLayoutConstraint?.constant = (endFrame?.size.height ?? 0.0) + 16.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    private func initializeChatElements(){
        self.navigationController?.navigationBar.topItem?.title = "";
        self.navigationItem.title = "@\(viewModel?.userSelected?.login ?? "")"
        
        // Set placholder text for User input
        chatInputTextView.text = placeholdertext
        chatInputTextView.textColor = UIColor.lightGray
        
        // Registering cell to the table view
        tableView?.register(cell: RightMessageTableViewCell.self)
        tableView?.register(cell: LeftMessageTableViewCell.self)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let tappedString = chatInputTextView.text, (chatInputTextView.text?.count ?? 0) > 0 ,!tappedString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else{
            return
        }
        keyboardHeightLayoutConstraint?.constant = CGFloat(textViewSize)
        viewModel?.tempMsgArray.append(tappedString)
        chatInputTextView.text = ""
        let msg = MessagesData(message: tappedString, userType: MessageOwner.User.rawValue)
        updateDataSource(msg: msg)
        
        // 1 second delay to automate the System Message
        Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ChatViewController.systemMsgUpdate)), userInfo: nil, repeats: false)
    }
    
    // this method prints System message enterred by the user
    @objc func systemMsgUpdate()
    {
        guard let chatArray = viewModel?.tempMsgArray else { return }
        for (_,num) in chatArray.enumerated() {
            let msg = MessagesData(message: "\(num ) \(num )", userType: MessageOwner.System.rawValue)
            updateDataSource(msg:msg)
        }
        viewModel?.tempMsgArray = []
    }
    
    // this method reloads and scroll for last mesage
    func updateDataSource(msg:MessagesData)
    {
        viewModel?.dataArray.append(msg)
        tableView?.reloadData()
        
        // To scroll on latest message
        let pathToLastRow = IndexPath(row: (viewModel?.dataArray.count ?? 0) - 1, section: 0)
        tableView?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableViewScrollPosition.none, animated: true)
    }
}
//Tableview Datasource
extension ChatViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataArray.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel?.dataArray[indexPath.row]
        // Cell which shows user typed message
        if ((message?.userType ?? "") == MessageOwner.User.rawValue) {
            let cell:RightMessageTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.changeImage(Constants.rightImage,message: message?.message ?? "")
            return cell
        }else
        {   // Cell which shows System message
            let cell:LeftMessageTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.changeImage(Constants.leftImage,message: message?.message ?? "")
            return cell
        }
    }
}
//Extension to hide keyboard
extension ChatViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" &&  textView.text.count == 0{
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        if (newSize.height > CGFloat(textViewSize) && newSize.height < CGFloat(textViewSize * 2)) {
            keyboardHeightLayoutConstraint?.constant = newSize.height
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholdertext
            textView.textColor = UIColor.lightGray
        }
    }
}
