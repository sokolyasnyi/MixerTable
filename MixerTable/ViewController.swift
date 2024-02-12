//
//  ViewController.swift
//  MixerTable
//
//  Created by Станислав Соколов on 10.02.2024.
//

import UIKit

class ViewController: UIViewController {
        
    lazy private var mixerTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var numbers = [Int](1...30)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        let barButton = UIBarButtonItem(title: "shuffle", style: .plain, target: self, action: #selector(pressShuffle))
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.title = "Task 4"

        
        mixerTableView.dataSource = self
        mixerTableView.delegate = self
        
    }
    
    func setupViews() {
        view.addSubview(mixerTableView)
        mixerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        navigationController?.navigationBar.backgroundColor = .white
        
    }
    
    func setupConstraints() {
        mixerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mixerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mixerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mixerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    @objc func pressShuffle(_ sender: UIBarButtonItem) {
        numbers = numbers.shuffled()

        var indexPaths = [IndexPath]()
        for (index, _) in numbers.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        
        mixerTableView.beginUpdates()
        mixerTableView.deleteRows(at: indexPaths, with: .bottom)
        mixerTableView.insertRows(at: indexPaths, with: .top)
        mixerTableView.endUpdates()

    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.selectionStyle = .blue
        cell.textLabel?.text = "\(numbers[indexPath.row])"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        }
    }
    
}


