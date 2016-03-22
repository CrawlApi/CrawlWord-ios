//
//  SearchViewController.swift
//  Word
//
//  Created by marquis on 16/3/18.
//  Copyright © 2016年 marquis. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import Cosmos

class SearchViewController: UIViewController, ENSideMenuDelegate, SWTableViewCellDelegate {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var wordNameLabel: UILabel!
    @IBOutlet weak var rateStar: CosmosView!
    @IBOutlet weak var searchBtn: UIButton!
    
    var wordDataService: WordDataService!
    var wordModel: Word = Word()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sideMenuController()?.sideMenu?.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "MenuOpen") , style: UIBarButtonItemStyle.Plain, target: self, action: "menu")
    }
    
    @IBAction func SearchButton(sender: AnyObject) {
        if let word = searchBar.text{
            searchBtn.enabled = false
            self.view.makeToastActivity(.Center)
            wordDataService = WordDataService(delegate: self, word: word)
            wordDataService.getWordData()
        }else{
            self.view.makeToast("Not Empty")
        }
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

extension SearchViewController: WordDataDelegate{
    func showInSearch(searchViewModel: SearchViewModel) {
        wordNameLabel.text = searchViewModel.wordModel.word
        rateStar.rating = searchViewModel.wordModel.rate
    }
    
    func loadingDialog(isShow:Bool, msg: String) {
        if isShow {
            self.view.hideToastActivity()
        }else{
            self.view.hideToastActivity()
            self.view.makeToast("\(msg)", duration: 3.0, position: .Bottom)
        }
        searchBtn.enabled = true
    }
}
