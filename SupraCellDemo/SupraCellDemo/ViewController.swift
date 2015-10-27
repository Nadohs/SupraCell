//
//  ViewController.swift
//  SupraCellDemo
//
//  Created by Richard Fox on 10/26/15.
//  Copyright © 2015 NadohsInc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: - tableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cname = "FirstSupraCell"
        
        switch indexPath.row{
        case 0:
            cname = "FirstSupraCell"
        case 1:
            cname = "SecondSupraCell"
        case 2:
            cname = "ThirdSupraCell"
        default:
            cname = "ThirdSupraCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cname)
        
        return cell!
    }
    
    //MARK: - Default Setup -
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.useCell("FirstSupraCell")
        tableView.useCell("SecondSupraCell")
        tableView.useCell("ThirdSupraCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

