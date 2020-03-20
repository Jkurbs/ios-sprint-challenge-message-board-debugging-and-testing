//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = messageThread?.title
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "MessageThreadDetailTableViewController.addButton"
        
        tableView.accessibilityIdentifier = "MessagesTableView"
        
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! LabelCell
        
         cell.accessibilityIdentifier = "messageCell\(indexPath.row)"

        let message = messageThread?.messages[indexPath.row]
        cell.messageText = message?.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message =  messageThread?.messages[indexPath.row]
        let height = LabelCell.textHeight(message?.text ?? "", width: tableView.frame.width)
        return height

    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessage" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            
            DispatchQueue.main.async {
                destinationVC.messageThreadController = self.messageThreadController
                destinationVC.messageThread = self.messageThread
            }
        }
    }
    
    // MARK: - Properties

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
