//
//  ViewController.swift
//  Font Viewer
//
//  Created by Jennifer Huang on 2020/7/6.
//  Copyright © 2020 Jennifer Huang. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    @IBOutlet
    weak var fontFamiliesPopup: NSPopUpButton!
     
    @IBOutlet
    weak var fontTypesPopup: NSPopUpButton!
     
    @IBOutlet
    weak var sampleLabel: NSTextField!
    
    var selectedFontFamily:String?
    var fontFamilyMembers = [[Any]]()
    

   
    @IBAction
    func handleFontFamilySelection(_ sender: Any) {
        if let fontFamily = fontFamiliesPopup.titleOfSelectedItem{
            view.window?.title = fontFamily
            selectedFontFamily = fontFamily
            if let members=NSFontManager.shared.availableMembers(ofFontFamily: fontFamily){
                fontFamilyMembers.removeAll()
                fontFamilyMembers = members
                updateFontTypesPopup()
            }
        }
     
    }
     
     
    @IBAction
    func handleFontTypeSelection(_ sender: Any) {
        let selectedMember = fontFamilyMembers[fontTypesPopup.indexOfSelectedItem]
        if let postscriptName = selectedMember[0] as? String, let weight = selectedMember[2] as? Int, let traits = selectedMember[3] as? UInt, let fontfamily = selectedFontFamily{
            let font = NSFontManager.shared.font(withFamily:fontfamily,
                                                 traits: NSFontTraitMask(rawValue:traits),
                                                 weight: weight,
                                                 size: 19.0)
            sampleLabel.font = font
            sampleLabel.stringValue = postscriptName
        }
     
    }
    
     
     
    @IBAction
    func displayAllFonts(_ sender: Any) {
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateFontFamilies()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupUI(){
        fontFamiliesPopup.removeAllItems()
        fontTypesPopup.removeAllItems()
        sampleLabel.stringValue=""
        sampleLabel.alignment = .center
    }

    func populateFontFamilies(){
        fontFamiliesPopup.removeAllItems()
        fontFamiliesPopup.addItems(withTitles: NSFontManager.shared.availableFontFamilies)
        handleFontFamilySelection(self)
    }
    
    func updateFontTypesPopup(){
        fontTypesPopup.removeAllItems()
        for member in fontFamilyMembers{
            if let fontType=member[1] as? String{
                fontTypesPopup.addItem(withTitle: fontType)
            }
        }
        fontTypesPopup.selectItem(at: 0)
        handleFontTypeSelection(self)
    }

 
    
}

