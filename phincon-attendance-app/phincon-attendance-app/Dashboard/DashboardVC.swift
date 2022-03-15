//
//  DashboardVC.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/14/22.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet var dashboardTableView: UITableView!
    @IBOutlet var checkInBtn: UIButton!
    @IBOutlet var notifBtn: UIButton!

    @IBOutlet var topCardView: UIView!
    
    var isCheckOut = false
    var checkInLists: [DashboardModels] = []
    var checkOutLists: [DashboardModels] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    func setupUI() {
        dashboardTableView.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        dashboardTableView.separatorStyle = .none
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
        
        checkInBtn.layer.cornerRadius = checkInBtn.frame.width / 2
//        checkInBtn.layer.masksToBounds = true
        checkInBtn.titleEdgeInsets = UIEdgeInsets(top: 8,left: 8,bottom: 8,right: 8)
        checkInBtn.layer.shadowColor = UIColor.darkGray.cgColor
        checkInBtn.layer.shadowOffset = CGSize.zero
        checkInBtn.layer.shadowOpacity = 0.4
        checkInBtn.layer.shadowRadius = 10.0
        
        topCardView.layer.cornerRadius = 20
        topCardView.layer.shadowColor = UIColor.lightGray.cgColor
        topCardView.layer.shadowOffset = CGSize.zero
        topCardView.layer.shadowOpacity = 0.2
        topCardView.layer.shadowRadius = 3.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkInLists = [
            DashboardModels(title: "PT. Phincon",
                            description: "Office. 88 @Kasablanka Office Tower 18th Floor", image: #imageLiteral(resourceName: "dashboard-list-1")),
            DashboardModels(title: "Telkomsel Smart Office", description: "Jl. Jend. Gatot Subroto Kav. 52. Jakarta Selatan", image: #imageLiteral(resourceName: "dashboard-list-2")),
            DashboardModels(title: "Rumah", description: "Jakarta", image: #imageLiteral(resourceName: "dashboard-list-3"))
        ]
        checkOutLists = [
            DashboardModels(title: "PT. Phincon",
                            description: "Office. 88 @Kasablanka Office Tower 18th Floor", image: #imageLiteral(resourceName: "dashboard-list-1"))
        ]
    }
    
    @IBAction func btnCheckPressed(_ sender: Any) {
        if isCheckOut {
            isCheckOut = false
            checkInBtn.setTitle("CHECK IN", for: .normal)
            checkInBtn.backgroundColor = UIColor(red: 0.066, green: 0.752, blue: 0.302, alpha: 1)
            dashboardTableView.reloadData()
        } else {
            isCheckOut = true
            checkInBtn.setTitle("CHECK OUT", for: .normal)
            checkInBtn.backgroundColor = UIColor(red: 0.969, green: 0.71, blue: 0, alpha: 1)
            dashboardTableView.reloadData()
        }
    }

}


extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCheckOut {
            return checkOutLists.count
        } else {
            return checkInLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableCell", for: indexPath) as! DashboardTableCell
        
        if isCheckOut {
            let listObj = checkOutLists[indexPath.row]
            cell.setDashboardCellView(listObj)
            
            return cell
        } else {
            let listObj = checkInLists[indexPath.row]
            cell.setDashboardCellView(listObj)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.frame.size.height
        return tableViewHeight / 3.5
    }
}
