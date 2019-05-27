//
//  SchoolsViewController.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/25/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class SchoolsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var schools = [School]()
    var isFetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.fetchSchools), for: .valueChanged)
        
        self.fetchSchools()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isFetching {
            self.tableView.refreshControl?.beginRefreshing()
        }
    }
    
    @objc
    func fetchSchools() {
        
        self.isFetching = true
        
        let request = APIRequest.schools
        request.get([School].self) { (schools, error) in
            
            defer {
                self.tableView.refreshControl?.endRefreshing()
                self.isFetching = false
            }
            
            if let error = error {
                self.showAlert(with: error)
                return
            }
            
            self.schools = schools ?? []
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "score" {
            let vc = segue.destination as! ScoreSchoolViewController
            let index = self.tableView.indexPathForSelectedRow!
            vc.school = self.schools[index.item]
        }
        
    }

}

// MARK: - UITableView Delegate & DataSource

extension SchoolsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SchoolTableViewCell
        cell.school = self.schools[indexPath.item]
        return cell
    }
    
}
