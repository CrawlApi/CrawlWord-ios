//
//  SearchViewController.swift
//  Word
//
//  Created by marquis on 16/3/18.
//  Copyright © 2016年 marquis. All rights reserved.
//

import UIKit
import Cosmos
import ENSwiftSideMenu

class SearchViewController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var wordNameLabel: UILabel!
    @IBOutlet weak var rateStar: CosmosView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var addWordBtn: UIButton!
    @IBOutlet weak var addRustyWordBtn: UIButton!
    
    var wordDataService: WordDataService!
    var wordModel: Word = Word()
    var searchViewModel: SearchViewModel!
    
    var internetReachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sideMenuController()?.sideMenu?.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "MenuOpen") , style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchViewController.menu))
        //star do not touch
        rateStar.settings.updateOnTouch = false
        addWordBtn.enabled = false
        addRustyWordBtn.enabled = false
        //获取联网状态
        self.internetReachability = Reachability.reachabilityForInternetConnection()
    }
    
    @IBAction func SearchButton(sender: AnyObject) {
        searchBar.resignFirstResponder()
        let word = searchBar.text
        print(self.internetReachability.currentReachabilityStatus().rawValue)
        if self.internetReachability.currentReachabilityStatus().rawValue != 0 {
            if word != "" {
                searchBtn.enabled = false
                addWordBtn.enabled = false
                addRustyWordBtn.enabled = false
                self.view.makeToastActivity(.Center)
                wordDataService = WordDataService(delegate: self, word: word!)
                wordDataService.getWordData()
            }else{
                self.view.makeToast("Not Empty")
            }
        }else{
             self.view.makeToast("网络状态：Disconnection")
        }
    }
    
    @IBAction func AddWordButton(sender: AnyObject) {
        //判断是否已经存入数据库
        let word = DBUtil.wordDataByWord(searchViewModel.wordModel.word)
        if word.isEmpty {
            if DBUtil.inset(searchViewModel.wordModel) {
                self.view.makeToast("成功添加进单词薄", duration: 3.0, position: .Bottom)
            }
        }else{
            if word[0].isRusty {
                self.view.makeToast("生词薄里已存在", duration: 3.0, position: .Bottom)
            }else{
                self.view.makeToast("单词薄里已存在", duration: 3.0, position: .Bottom)
            }
        }
    }
    
    @IBAction func AddRustyWordButton(sender: AnyObject) {
        //判断是否已经存入数据库
        let word = DBUtil.wordDataByWord(searchViewModel.wordModel.word)
        if word.isEmpty {
            //slug为生词薄
            searchViewModel.wordModel.isRusty = true
            if DBUtil.inset(searchViewModel.wordModel) {
                self.view.makeToast("成功添加进单词薄", duration: 3.0, position: .Bottom)
            }
        }else{
            if word[0].isRusty {
                self.view.makeToast("生词薄里已存在", duration: 3.0, position: .Bottom)
            }else{
                self.view.makeToast("单词薄里已存在", duration: 3.0, position: .Bottom)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
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
        self.searchViewModel = searchViewModel
    }
    
    func loadingDialog(isShow:Bool, msg: String) {
        if isShow {
            self.view.hideToastActivity()
            addWordBtn.enabled = true
            addRustyWordBtn.enabled = true
        }else{
            self.view.hideToastActivity()
            self.view.makeToast("\(msg)", duration: 3.0, position: .Bottom)
        }
        searchBtn.enabled = true
    }
}


