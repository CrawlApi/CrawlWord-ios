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
    var voiceArray: [String] = []
    var voiceIndex = 0
    
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
            note.center = CGPointMake(160, 25 + spacer )
            note.text = "(\(noteNum))"
            note.font = UIFont(name: note.font.fontName, size: 12)
            
            let label = UILabel(frame: CGRectMake(0, 0, 300, 42))
            label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            label.numberOfLines = 0
            label.center = CGPointMake(180, 25 + spacer )
            label.text = collins.note
            label.font = UIFont(name: label.font.fontName, size: 12)
            for sentence in collins.sentence{
                voiceArray.append(sentence.voice)
                packagesentence(sentence, spacer: spacer, voiceArray: voiceArray, voiceIndex: voiceIndex)
                voiceIndex += 1
                spacer = spacer + 50
            }
            
            spacer = spacer + 50
            noteNum += 1
            self.collins.addSubview(note)
            self.collins.addSubview(label)
        }
        self.collins.contentSize = CGSize(width: 375, height: spacer)
    }
    
    func packagesentence(sentence: Sentence, spacer: CGFloat, voiceArray: [String], voiceIndex: Int){
        let enLabel = UILabel(frame: CGRectMake(0, 0, 275, 42))
        enLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        enLabel.numberOfLines = 0
        enLabel.center = CGPointMake(190, spacer + 50 )
        enLabel.text = sentence.en
        enLabel.font = UIFont(name: enLabel.font.fontName, size: 12)
        
        let voiceButton = UIButton(frame: CGRectMake(345, 25, 25, 25)) as UIButton
        voiceButton.center = CGPointMake(350, spacer + 50 )
        voiceButton.setImage(UIImage(named: "VoiceClose"), forState: .Normal)
        voiceButton.tag = voiceIndex
        voiceButton.addTarget(self, action: #selector(DetailViewController.voiceAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let zhLabel = UILabel(frame: CGRectMake(0, 0, 300, 42))
        zhLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        zhLabel.numberOfLines = 0
        zhLabel.center = CGPointMake(190, spacer + 75 )
        zhLabel.text = sentence.zh
        zhLabel.font = UIFont(name: enLabel.font.fontName, size: 12)
        
        self.collins.addSubview(enLabel)
        self.collins.addSubview(zhLabel)
        self.collins.addSubview(voiceButton)
    }
    
    func voiceAction(sender: UIButton){
        if self.voiceArray[sender.tag] != "" {
            playVoiceService.play(NSURL(string: self.voiceArray[sender.tag])!)
        }
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
        let leftButton = UIBarButtonItem(image: UIImage(named: "Back") , style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.backButtonClick))
        
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
