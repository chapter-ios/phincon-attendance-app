//
//  HistoryVC.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/14/22.
//

import UIKit

class HistoryVC: UIViewController {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var filterCollView: UICollectionView!
    @IBOutlet var historyTableView: UITableView!

    var daysFilter = [String]()
    var historyLists: [History] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        daysFilter = ["Day","Week","Month","Year"]
        fetchDayLists()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.filterCollView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        historyTableView.register(HistoryTableViewCell.nib(), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.estimatedRowHeight = 72
        
        filterCollView.register(DayFilterCollViewCell.nib(), forCellWithReuseIdentifier: DayFilterCollViewCell.identifier)
        filterCollView.delegate = self
        filterCollView.dataSource = self
        
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func fetchWeekLists() {
        historyLists.removeAll()
        historyLists = [
            History(title: "PT. Phincon", desc: "Office. 88 @Kasablanka Office Tower 18th Floor", type: "Check In", time: "9:00 AM", image: #imageLiteral(resourceName: "dashboard-list-1")),
            History(title: "PT. Phincon", desc: "Office. 88 @Kasablanka Office Tower 18th Floor", type: "Check Out", time: "18:00 AM", image: #imageLiteral(resourceName: "dashboard-list-1")),
            History(title: "TSO", desc: "Jl. Jend. Gatot Subroto Kav. 52. Jakarta Selatan", type: "Check In", time: "9:00 AM", image: #imageLiteral(resourceName: "dashboard-list-2")),
            History(title: "TSO", desc: "Jl. Jend. Gatot Subroto Kav. 52. Jakarta Selatan", type: "Check Out", time: "20:00 AM", image: #imageLiteral(resourceName: "dashboard-list-2")),
            History(title: "PT. Phincon", desc: "Office. 88 @Kasablanka Office Tower 18th Floor", type: "Check In", time: "9:00 AM", image: #imageLiteral(resourceName: "dashboard-list-1")),
            History(title: "PT. Phincon", desc: "Office. 88 @Kasablanka Office Tower 18th Floor", type: "Check Out", time: "18:00 AM", image: #imageLiteral(resourceName: "dashboard-list-1")),
            History(title: "Telkomsel Smart Office", desc: "Jl. Jend. Gatot Subroto Kav. 52. Jakarta Selatan", type: "Check In", time: "9:00 AM", image: #imageLiteral(resourceName: "dashboard-list-2"))

        ]
        historyTableView.reloadData()
    }
    func fetchDayLists() {
        historyLists.removeAll()
        historyLists = [
            History(title: "PT. Phincon", desc: "Office. 88 @Kasablanka Office Tower 18th Floor", type: "Check In", time: "9:00 AM", image: #imageLiteral(resourceName: "dashboard-list-1")),
            History(title: "PT. Phincon", desc: "Office. 88 @Kasablanka Office Tower 18th Floor", type: "Check Out", time: "18:00 AM", image: #imageLiteral(resourceName: "dashboard-list-1")),
        ]
        historyTableView.reloadData()
    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        let historyObj = historyLists[indexPath.row]
        cell.setHistoryView(with: historyObj)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.frame.size.height / 6
        let heightRatio = UIScreen.main.bounds.height / 736
        return tableView.estimatedRowHeight * heightRatio
    }
}

extension HistoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayFilterCollViewCell", for: indexPath) as! DayFilterCollViewCell
        
        let filterDay = daysFilter[indexPath.row]
        cell.setView(filterDay)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            fetchDayLists()
        } else if indexPath.row == 1 {
            fetchWeekLists()
        } else {
            fetchWeekLists()
        }
    }
    
    //MARK:- FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.size.width
        let screenHeight = collectionView.frame.size.height
        return CGSize(width: screenWidth/4, height: screenHeight)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
