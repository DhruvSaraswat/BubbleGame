//
//  BubbleView.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import UIKit

final class BubbleView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    weak var viewModel: BubbleViewModel?

    override class var requiresConstraintBasedLayout: Bool {
        true
    }

    private func setupView() {
        backgroundColor = .white.withAlphaComponent(0.7)
        addSubview(label)
        addConstraints()
        setupActions()
        makeCircular()
    }

    private func addConstraints() {
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.isHidden = true
    }

    private func setupActions() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetCounter))
        addGestureRecognizer(gestureRecognizer)
    }

    private func makeCircular() {
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2
    }

    func setupObserver() {
        viewModel?.updateLabelObserver = { [unowned self] state in
            switch state {
            case .updateBubbleLabel(let value):
                DispatchQueue.main.async { [unowned self] in
                    if label.isHidden {
                        label.isHidden = false
                    }
                    label.text = value
                }
            }
        }
    }

    @objc private func resetCounter() {
        viewModel?.resetTimer()
    }
}
