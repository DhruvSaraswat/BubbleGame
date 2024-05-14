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
        viewModel.loginViewObserver = { [unowned self] state in
            switch state {
            case .showNextScreen:
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DifficultyLevelViewController") as! DifficultyLevelViewController
                    vc.modalPresentationStyle = .custom
                    vc.transitioningDelegate = self
                    self.present(vc, animated: true, completion: nil)
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

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        PresentTransition()
    }
}
