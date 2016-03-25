//
//  DetailViewController.swift
//  Word
//
//  Created by marquis on 16/3/25.
//  Copyright © 2016年 marquis. All rights reserved.
//

import UIKit
import Cosmos

class DetailViewController: UIViewController, UINavigationBarDelegate {
    
    var wordItem: Word = Word()
    var playVoiceService: PlayVoiceService = PlayVoiceService()
    
    @IBOutlet weak var wordNameLabel: UILabel!
    @IBOutlet weak var rateStar: CosmosView!
    
    @IBOutlet weak var nValue: UILabel!
    @IBOutlet weak var vtValue: UILabel!
    @IBOutlet weak var viValue: UILabel!
    @IBOutlet weak var adjValue: UILabel!
    @IBOutlet weak var advValue: UILabel!

    @IBOutlet weak var shapesValue: UITextView!
    
    @IBOutlet weak var collins: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //create navigationBar
        createNavigationBar()
        initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData(){
        wordNameLabel.text = wordItem.word
        rateStar.settings.updateOnTouch = false
        rateStar.rating = wordItem.rate
        nValue.text = wordItem.n
        vtValue.text = wordItem.vt
        viValue.text = wordItem.vi
        adjValue.text = wordItem.adj
        advValue.text = wordItem.adv
        
        var shapes: String = ""
        for shape in wordItem.shapes {
            shapes = shapes+shape.type+":"+shape.value+"  "
        }
        shapesValue.text = shapes
        var spacer = CGFloat(0)
        var noteNum = 1
        for collins in wordItem.collins{
            let note = UILabel(frame: CGRectMake(0, 0, 300, 42))
            note.lineBreakMode = NSLineBreakMode.ByCharWrapping
            note.numberOfLines = 0
            note.center = CGPointMake(160, 0 + spacer )
            note.text = "(\(noteNum))"
            note.font = UIFont(name: note.font.fontName, size: 12)
            
            let label = UILabel(frame: CGRectMake(0, 0, 300, 42))
            label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            label.numberOfLines = 0
            label.center = CGPointMake(200, 0 + spacer )
            label.text = collins.note
            label.font = UIFont(name: label.font.fontName, size: 12)
            
            for sentence in collins.sentence{
                packagesentence(sentence, spacer: spacer)
                spacer = spacer + 50
            }
            
            spacer = spacer + 50
            noteNum++
            self.collins.addSubview(note)
            self.collins.addSubview(label)
        }
    }
    
    func packagesentence(sentence: Sentence, spacer: CGFloat){
        let enLabel = UILabel(frame: CGRectMake(0, 0, 300, 42))
        enLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        enLabel.numberOfLines = 0
        enLabel.center = CGPointMake(200, spacer + 30 )
        enLabel.text = sentence.en
        enLabel.font = UIFont(name: enLabel.font.fontName, size: 12)
        
        
        let zhLabel = UILabel(frame: CGRectMake(0, 0, 300, 42))
        zhLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        zhLabel.numberOfLines = 0
        zhLabel.center = CGPointMake(200, spacer + 50 )
        zhLabel.text = sentence.zh
        zhLabel.font = UIFont(name: enLabel.font.fontName, size: 12)
        
        self.collins.addSubview(enLabel)
        self.collins.addSubview(zhLabel)
    }
    
    @IBAction func SpeakUKVoice(sender: AnyObject) {
        if wordItem.speakUK != "" {
            playVoiceService.play(NSURL(string: wordItem.speakUK)!)
        }
    }
    
    @IBAction func SpeakUSVoice(sender: AnyObject) {
        if wordItem.speakUS != "" {
            playVoiceService.play(NSURL(string: wordItem.speakUS)!)
        }
    }
    
    func createNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = wordItem.word
        
        // Create left and right button for navigation item
        let leftButton = UIBarButtonItem(image: UIImage(named: "Back") , style: UIBarButtonItemStyle.Plain, target: self, action: "backButtonClick")
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
    
    func backButtonClick() {
         self.dismissViewControllerAnimated(true, completion:nil)
    }
}
