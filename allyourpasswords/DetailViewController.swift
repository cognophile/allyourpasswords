//
//  DetailViewController.swift
//  allyourpasswords
//
//  Created by Sean Walker on 1/18/19.
//  Copyright © 2019 Sean Walker. All rights reserved.
//

import Cocoa
import SQLite

class DetailViewController : NSViewController {

    var row : Row?
    let login = Login()
    var tableViewController : TableViewController?
    @IBOutlet weak var nameOrUrl: NSTextField!
    @IBOutlet weak var favicon: NSImageView!
    @IBOutlet weak var email: NSTextField!
    @IBOutlet weak var username: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!
    @IBOutlet weak var toolbarView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.stringValue = row?[login.email] ?? "Click to add an email"
        username.stringValue = row?[login.username] ?? "Click to add a username"
        nameOrUrl.stringValue = row?[login.name] ?? row?[login.url] ?? "Login"
        password.stringValue = row?[login.password] ?? "Click to add a password"

        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/"
        let str = "\(path)/\(row?[login.id] ?? 0).png"
        let image = NSImage(contentsOfFile: str)
        favicon.image = image
    }

    @IBAction func editButtonClicked(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
        let vc = storyboard.instantiateController(withIdentifier: "EditViewController") as! EditViewController
        vc.row = row

        let container = self.parent as! ContainerViewController

        for sView in container.containerView.subviews {
            sView.removeFromSuperview()
        }

        container.addChild(vc)
        vc.view.frame = container.containerView.bounds
        container.containerView.addSubview(vc.view)
    }

    @IBAction func copyEmailClicked(_ sender: NSButton) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(email.stringValue, forType: .string)
    }

    @IBAction func copyPasswordClicked(_ sender: NSButton) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(password.stringValue, forType: .string)
    }
    
    @IBAction func copyUsernameClicked(_ sender: NSButton) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(username.stringValue, forType: .string)
    }
}
