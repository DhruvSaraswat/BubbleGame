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
    private let viewModel = DifficultyLevelViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }

    private func setupButton() {
        dropdownMenuButton.showsMenuAsPrimaryAction = true
        dropdownMenuButton.changesSelectionAsPrimaryAction = true
        optionClosure = { (action: UIAction) in
            if self.viewModel.getDropdownTitles().contains(action.title) {
                self.viewModel.getRate(forLevel: action.title)
            }
        }
        guard let optionClosure else { return }
        let uiActions: [UIAction] = viewModel.getDropdownTitles().map { UIAction(title: $0, handler: optionClosure) }
        dropdownMenuButton.menu = UIMenu(children: uiActions)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
