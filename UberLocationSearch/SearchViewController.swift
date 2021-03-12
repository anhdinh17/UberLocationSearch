//
//  SearchViewController.swift
//  UberLocationSearch
//
//  Created by Anh Dinh on 3/11/21.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

// UILabel
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Where to??"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

// UITextField
    private let field: UITextField = {
       let field = UITextField()
        field.placeholder = "Enter Destination"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 10,
                                              height: 50))
        field.leftViewMode = .always
        return field
    }()

//UITableView
    private let tableView: UITableView = {
        let table = UITableView()
        //create the cell and give it identifier
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        // add subviews
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        field.delegate = self
        
        tableView.backgroundColor = .secondarySystemBackground
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        // add frame
        label.frame = CGRect(x: 10,
                             y: 10,
                             width: label.frame.size.width,
                             height: label.frame.size.height)
        
        field.frame = CGRect(x: 10,
                             y: label.frame.size.height + 20,
                             width: label.frame.size.width - 20,
                             height: 50)
        
        let tableY: CGFloat = field.frame.origin.y + field.frame.size.height + 5
        tableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height - tableY)
    }
   
//MARK: - textField Delegate
    // what happens when users click on return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder() // close the keyboard when hitting return button
        
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
            }
        }

        return true
    }
//MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0 // line wrap
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
//MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Notify map controller to show pin at selected place
        let coordinate = locations[indexPath.row].coordinates
        
        
        
    }
    
    
}
