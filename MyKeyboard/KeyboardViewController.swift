//
//  KeyboardViewController.swift
//  MyKeyboard
//
//  Created by β α on 2021/02/09.
//

import SwiftUI

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var inputButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let host = UIHostingController(rootView: KeyboardView(proxy: self.textDocumentProxy))
        host.setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
        host.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(host)
        self.view.addSubview(host.view)
        host.didMove(toParent: self)

        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        host.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        host.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        host.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.view.addSubview(self.nextKeyboardButton)
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }

    override func selectionWillChange(_ textInput: UITextInput?) {
        print("selectionWillChange", textInput)
    }

    override func selectionDidChange(_ textInput: UITextInput?) {
        print("selectionDidChange", textInput)
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
        print("textWillChange", textInput)
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        print("textDidChange", textInput)
    }

}
