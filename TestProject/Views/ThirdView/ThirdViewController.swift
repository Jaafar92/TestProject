//
//  ThirdViewController.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import UIKit
import Combine

class ThirdViewController : UIViewController {
    
    weak var changeTextButton: UIButton!
    weak var navigateToNextPageButton: UIButton!
    weak var pageIndicatorLabel: UILabel!
    weak var textContainerLabel: UILabel!
    
    private let viewModel: ThirdViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ThirdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        initializePageIndicatorLabel()
        initializeTextContainerLabel()
        initializeButtons()
        
        setUpBindings()
        setupConstraints()
    }
    
    private func initializePageIndicatorLabel() {
        self.pageIndicatorLabel = LayoutFactory.getLabel(text: "Third View", parentView: self.view)
    }
    
    private func initializeTextContainerLabel() {
        self.textContainerLabel = LayoutFactory.getLabel(text: "", parentView: self.view)
    }
    
    private func initializeButtons() {
        self.changeTextButton = LayoutFactory.getButton(title: "Go 1 back", parentView: self.view)
        self.changeTextButton.addTarget(self, action: #selector(goOneBack(_:)), for: .touchUpInside)
        
        self.navigateToNextPageButton = LayoutFactory.getButton(title: "Back with no history", parentView: self.view)
        self.navigateToNextPageButton.addTarget(self, action: #selector(backNoHistory(_:)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        viewModel.$text
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.textContainerLabel)
            .store(in: &bindings)
    }
    
    @objc func goOneBack(_ sender: UIButton) {
        viewModel.navigateOneBack()
    }
    
    @objc func backNoHistory(_ sender: UIButton) {
        viewModel.navigateBackNoHistory()
    }
    
    private func setupConstraints() {
        Layout.addTopConstraint(on: self.pageIndicatorLabel, to: self.textContainerLabel.bottomAnchor, by: Constants.hugeOffset)
        Layout.centerHorizontally(on: self.pageIndicatorLabel, withParent: self.view)
        
        Layout.centerHorizontally(on: self.textContainerLabel, withParent: self.view)
        Layout.centerVertically(on: self.textContainerLabel, withParent: self.view)
        
        Layout.addBottomConstraint(on: self.navigateToNextPageButton, to: self.changeTextButton.topAnchor, by: Constants.standardOffset)
        Layout.addLeadingConstraint(on: self.navigateToNextPageButton, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.navigateToNextPageButton, to: self.view.trailingAnchor)
        
        Layout.addBottomConstraint(on: self.changeTextButton, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constants.standardOffset)
        Layout.addLeadingConstraint(on: self.changeTextButton, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.changeTextButton, to: self.view.trailingAnchor)
    }
}
