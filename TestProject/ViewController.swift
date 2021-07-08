//
//  ViewController.swift
//  TestProject
//
//  Created by Jaafar on 08/07/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var addButton: UIButton!
    weak var removeButton: UIButton!
    weak var tableView: UITableView!
    weak var headerView: UIView!
    
    let strings: [String] = ["Test 1", "Test 2", "Test 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTableView()
        initializeButtons()
        setupConstraints()
    }
    
    private func initializeTableView() {
        self.tableView = LayoutFactory.getTableView(cellType: TwoSidedTextCell.self, cellIdentifier: TwoSidedTextCell.identifier, parentView: self.view)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func initializeButtons() {
        self.addButton = LayoutFactory.getButton(title: "Add", parentView: self.view)
        self.addButton.addTarget(self, action: #selector(addCommand(_:)), for: .touchUpInside)
        
        self.removeButton = LayoutFactory.getButton(title: "Remove", parentView: self.view)
        self.removeButton.addTarget(self, action: #selector(removeCommand(_:)), for: .touchUpInside)
    }
    
    @objc func addCommand(_ sender: UIButton) {
        let openFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250)
        let closedFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
        
        // Start by havinig it closed
        let headerView = UIView(frame: closedFrame)
        headerView.backgroundColor = UIColor.red
        
        // Set the view
        self.tableView.tableHeaderView = headerView;
        
        UIView.animate(withDuration: 0.3) {
            headerView.frame = openFrame
            self.tableView.layoutIfNeeded()
        }
    }
    
    @objc func removeCommand(_ sender: UIButton) {
        let uiVIew = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        self.tableView.tableHeaderView = uiVIew
    }
    
    private func setupConstraints() {
        Layout.addTopConstraint(on: self.tableView, to: self.view.topAnchor)
        Layout.addLeadingConstraint(on: self.tableView, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.tableView, to: self.view.trailingAnchor)
        Layout.addBottomConstraint(on: self.tableView, to: self.removeButton.topAnchor, by: Constants.standardOffset)
        
        Layout.addBottomConstraint(on: self.removeButton, to: self.addButton.topAnchor, by: Constants.standardOffset)
        Layout.addLeadingConstraint(on: self.removeButton, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.removeButton, to: self.view.trailingAnchor)
        
        Layout.addBottomConstraint(on: self.addButton, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constants.standardOffset)
        Layout.addLeadingConstraint(on: self.addButton, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.addButton, to: self.view.trailingAnchor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: TwoSidedTextCell.identifier, for: indexPath) as? TwoSidedTextCell else {
            fatalError("cannot dequeue")
        }
        
        cell.leftLabel.text = self.strings[indexPath.row]
        
        return cell
    }
    
}

