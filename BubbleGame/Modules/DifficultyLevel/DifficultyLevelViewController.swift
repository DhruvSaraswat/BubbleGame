//
//  DifficultyLevelViewController.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 13/05/24.
//

import UIKit

final class DifficultyLevelViewController: UIViewController {
    @IBOutlet private weak var dropdownMenuButton: UIButton!

    private var optionClosure: ((UIAction) -> Void)?
    private var viewModel = DifficultyLevelViewModel()
    private var selectedLevel: String = "1"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        viewModel.difficultyLevelViewObserver = { [unowned self] state in
            switch state {
            case .showNextScreen:
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "BubblesViewController") as! BubblesViewController
                    vc.modalPresentationStyle = .custom
                    vc.transitioningDelegate = self
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }

    private func setupButton() {
        dropdownMenuButton.showsMenuAsPrimaryAction = true
        dropdownMenuButton.changesSelectionAsPrimaryAction = true
        optionClosure = { [unowned self] (action: UIAction) in
            self.selectedLevel = action.title
        }
        guard let optionClosure else { return }
        let uiActions: [UIAction] = viewModel.getDropdownTitles().map { UIAction(title: $0, handler: optionClosure) }
        dropdownMenuButton.menu = UIMenu(children: uiActions)
    }

    @IBAction func handlePlayButtonTap(_ sender: Any) {
        Task {
            await viewModel.getRate(forLevel: selectedLevel)
        }
    }
}

extension DifficultyLevelViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        PresentAnimation()
    }
}
