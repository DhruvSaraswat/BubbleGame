//
//  LoginViewController.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 11/05/24.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func handleLoginButtonTap(_ sender: Any) {
        Task {
            await viewModel.authenticate(username: usernameTextField.text, password: passwordTextField.text)
        }
    }
    
}
