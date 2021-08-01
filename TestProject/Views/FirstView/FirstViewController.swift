//
//  ViewController.swift
//  TestProject
//
//  Created by Jaafar on 08/07/2021.
//

import UIKit
import Combine

protocol FirstViewCoordinatorDelegate: AnyObject {
    func navigateToSecondView()
}

class FirstViewController: UIViewController {
    
    var coordinator: FirstViewCoordinatorDelegate?
    
    weak var changeTextButton: UIButton!
    weak var navigateToNextPageButton: UIButton!
    weak var pageIndicatorLabel: UILabel!
    weak var textContainerLabel: UILabel!
    
    private let viewModel: FirstViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: FirstViewModel = FirstViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCoordinator(coordinator: FirstViewCoordinatorDelegate) {
        self.coordinator = coordinator
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
        self.pageIndicatorLabel = LayoutFactory.getLabel(text: "First View", parentView: self.view)
    }
    
    private func initializeTextContainerLabel() {
        self.textContainerLabel = LayoutFactory.getLabel(text: "", parentView: self.view)
    }
    
    private func initializeButtons() {
        self.changeTextButton = LayoutFactory.getButton(title: "Change Text", parentView: self.view)
        self.changeTextButton.addTarget(self, action: #selector(changeTextCommand(_:)), for: .touchUpInside)
        
        self.navigateToNextPageButton = LayoutFactory.getButton(title: "Navigate to second view", parentView: self.view)
        self.navigateToNextPageButton.addTarget(self, action: #selector(nextPageCommand(_:)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        viewModel.$text
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.textContainerLabel)
//            .sink(receiveValue: { text in
//                self.textContainerLabel.text = text
//            })
            .store(in: &bindings)
    }
    
    @objc func changeTextCommand(_ sender: UIButton) {
        viewModel.changeText()
    }
    
    @objc func nextPageCommand(_ sender: UIButton) {
        coordinator?.navigateToSecondView()
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

