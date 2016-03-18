//
//  MenuTableViewController.swift
//  Word
//
//  Created by marquis on 16/3/18.
//  Copyright © 2016年 marquis. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class MenuTableViewController: UITableViewController {
    var selectedMenuItem: Int = 1
    
    var cellName = ["搜寻", "单词簿", "生词簿"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自定义table外观
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        //设定选择cell后不高亮
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Table view data source
     
     - parameter tableView: tableView description
     
     - returns: return value description
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     Description
     
     - parameter tableView: tableView description
     - parameter section:   section description
     
     - returns: return value description
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = cellName[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //按下，显示新的page
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var destViewController: UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("search")
            break;
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("word")
            break;
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("unfamiliar word")
            break;
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("word")
            break;
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    
}


