import UIKit
import SwiftUI


// Sample Data Model
struct User {
    let name: String
    let imageName: String
}

class NewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    
    // Sample Data
    let users: [User] = [
        User(name: "Alice", imageName: "person.circle"),
        User(name: "Bob", imageName: "person.circle.fill"),
        User(name: "Charlie", imageName: "star.fill"),
        User(name: "David", imageName: "heart.fill")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        
        // Embedding SwiftUI inside UITableViewCell
        cell.contentConfiguration = UIHostingConfiguration {
            HStack {
                Image(systemName: user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                
                Text(user.name)
                    .font(.title3)
                    .bold()
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding()
        }
        
        return cell
    }
}
