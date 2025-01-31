//
//  SchoolViewController.swift
//  SchoolDirectory
//
//  Created by Anand Upadhyay on 31/01/25.
//

import Foundation
import UIKit

// MARK: - Data Models
enum Section: CaseIterable {
    case students
    case teachers
}

enum PersonItem: Hashable {
    case student(name: String)
    case teacher(name: String)
}

// MARK: - View Controller
class PeopleViewController: UIViewController {
    
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, PersonItem>!
    
    // Sample Data
    private var students = ["Alice", "Bob", "Charlie"]
    private let teachers = ["Mr. Smith", "Ms. Johnson"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        applyInitialSnapshot()
    }
    
    private func setupUI() {
        title = "School Directory"
        view.backgroundColor = .white
        setupTableView()
        setupNavBar()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewStudent)
        )
    }
    
    @objc private func addNewStudent() {
        let newName = "Student \(students.count + 1)"
        students.append(newName)
        
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([.student(name: newName)], toSection: .students)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Diffable Data Source
extension PeopleViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) {
            tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            switch item {
            case .student(let name):
                cell.textLabel?.text = "🎓 \(name)"
                cell.imageView?.image = UIImage(systemName: "person.fill")
            case .teacher(let name):
                cell.textLabel?.text = "👩🏫 \(name"
                cell.imageView?.image = UIImage(systemName: "person.fill.checkmark")
            }
            
            return cell
        }
        
        dataSource.defaultRowAnimation = .automatic
    }
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PersonItem>()
        snapshot.appendSections([.students, .teachers])
        
        snapshot.appendItems(students.map { .student(name: $0) }, toSection: .students)
        snapshot.appendItems(teachers.map { .teacher(name: $0) }, toSection: .teachers)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
