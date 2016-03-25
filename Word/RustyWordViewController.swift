//
//  RustyWordViewController.swift
//  Word
//
//  Created by marquis on 16/3/21.
//  Copyright © 2016年 marquis. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import SWTableViewCell

class RustyWordViewController: UIViewController, ENSideMenuDelegate {
    
    var wordItems = [Word]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        for word in DBUtil.findByIsRusty(true){
            wordItems.append(word)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sideMenuController()?.sideMenu?.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "MenuOpen") , style: UIBarButtonItemStyle.Plain, target: self, action: "menu")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.tableFooterView = UIView(frame: CGRect.init())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menu(){
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "MenuClose")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "MenuOpen")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }

}

extension RustyWordViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return wordItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("WordCell", forIndexPath: indexPath) as! WordCell
        
        let wordItem = wordItems[indexPath.row]
        cell.wordNameLabel.text = wordItem.word
        cell.rateStar.rating = wordItem.rate
        cell.rateStar.settings.updateOnTouch = false
        
        //action
        cell.rightUtilityButtons = rightActionCells()
        cell.delegate = self
        
        return cell
    }
    
    func rightActionCells() -> [AnyObject] {
        let actions: NSMutableArray = NSMutableArray()
        let addRustyButtonColor: UIColor = UIColor(colorLiteralRed: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
        let removeButtonColor: UIColor = UIColor(colorLiteralRed: 1.0, green: 0.231, blue: 0.188, alpha: 1.0)
        actions.sw_addUtilityButtonWithColor(addRustyButtonColor, title: "添加到单词薄")
        actions.sw_addUtilityButtonWithColor(removeButtonColor, title: "删除")
        
        return actions as Array
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("RustyWordToDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RustyWordToDetail" {
            let viewController: DetailViewController = segue.destinationViewController as! DetailViewController
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            
            viewController.wordItem = wordItems[indexPath.row]
        }
    }
}

extension RustyWordViewController: SWTableViewCellDelegate{
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        let wordCell = cell.viewWithTag(0) as! WordCell
        let word = wordCell.wordNameLabel.text!
        switch (index) {
        case 0:
            if DBUtil.update(word, isRusty: false) {
                let indexPath: NSIndexPath = self.tableView.indexPathForCell(cell)!
                self.wordItems.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                self.view.makeToast("成功添加到单词薄", duration: 3.0, position: .Bottom)
            }else{
                self.view.makeToast("未能添加到单词薄", duration: 3.0, position: .Bottom)
            }
            break
        case 1:
            self.view.makeToast("成功删除", duration: 3.0, position: .Bottom)
            break
        default:
            break
        }
    }
}
