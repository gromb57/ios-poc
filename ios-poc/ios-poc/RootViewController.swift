//
//  RootViewController.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import UIKit

final class RootViewController: UITableViewController {
    struct Section {
        var title: String
        var rows: [Row] = []
    }

    struct Row {
        var title: String
        var controller: UIViewController.Type
    }

    static let cellId = "UITableViewCell"

    let dataSource: [Section] = [
        Section(title: "Neumorphism", rows: [
            Row(title: "GUI", controller: NeuVC.self)
        ]),
        Section(title: "Core Graphics", rows: [
            Row(title: "Trigonometric circle", controller: TrigoCircleVC.self)
        ]),
        Section(title: "Examples", rows: [
            Row(title: "Card", controller: CardVC.self),
            Row(title: "Calculator", controller: CalculatorVC.self),
            Row(title: "Clock", controller: ClockVC.self),
            Row(title: "Music Player", controller: MusicPlayerVC.self),
            Row(title: "Confetti", controller: ConfettiVC.self),
            Row(title: "Chat", controller: ChatVC.self),
            Row(title: "Firework", controller: FireworkVC.self),
            Row(title: "Login", controller: LoginVC.self),
            Row(title: "Settings", controller: SettingsVC.self),
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initUI()
    }

    private func initUI() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: type(of: self).cellId)
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellId) ?? UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: type(of: self).cellId)

        cell.textLabel?.text = self.dataSource[indexPath.section].rows[indexPath.row].title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  self.dataSource[section].title
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.dataSource[indexPath.section].rows[indexPath.row].controller.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
