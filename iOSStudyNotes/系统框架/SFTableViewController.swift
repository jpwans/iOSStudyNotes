//
//  SFTableViewController.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/22.
//

import UIKit

class SFTableViewController: UITableViewController {
    
    fileprivate var nums = [Int]()
    fileprivate let numOfRows = 10
    fileprivate let maxNum = 100
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
     
        tableView.refreshControl?.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
//        tableView.addSubview(refreshControl!)
        configureTableViewDataSource()
    }
    
   @objc func handleRefresh() {
        configureTableViewDataSource()
       tableView.refreshControl?.endRefreshing()
    }

    
    func configureTableViewDataSource()  {
        generateRandomNums()
        tableView.reloadData()
    }
    
    func generateRandomNums (){
        nums.removeAll()
        
        for _ in 0..<numOfRows {
            nums.append(Int(arc4random_uniform(UInt32(maxNum))))
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseIdentifier"
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
//        if(cell == nil) {
//            cell = UITableViewCell.init(style: .value1, reuseIdentifier: reuseIdentifier)
            cell.textLabel?.text = "\(nums[indexPath.row])"
//        }
        // Configure the cell...
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveNum = nums[sourceIndexPath.row]
        nums.remove(at: sourceIndexPath.row)
        nums.insert(moveNum, at: destinationIndexPath.row)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            nums.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
  

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.y + scrollView.frame.size.height
        let total = scrollView.contentSize.height
        let ratio = current / total
//        let needRead =cellsPerPage * threshold + currentPage * cellsPerPage
//        let totalCells = cellsPerPage * (currentPage + 1)
//        let newThreshold = needRead/totalCells
        
        
        
        if ratio >= 0.7 {
//            if ratio >=  threshold{
//            currentPage += 1
//            requestNewPage()
        }
    }
    
}

