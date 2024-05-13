//
//  LoginViewController.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 11/05/24.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    private var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.loginViewObserver = { [weak self] state in
            switch state {
            case .showNextScreen:
                DispatchQueue.main.async {
                    let vc = DifficultyLevelViewController()
                    self?.show(vc, sender: self)
                }
            }
        }
    }

    @IBAction func handleLoginButtonTap(_ sender: Any) {
        Task {
            await viewModel.authenticate(username: usernameTextField.text, password: passwordTextField.text)
        }
    }
    
}
