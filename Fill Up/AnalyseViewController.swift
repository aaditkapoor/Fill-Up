//
//  AnalyseViewController.swift
//  Fill Up
//
//  Created by Aadit Kapoor on 6/3/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import UIKit

class AnalyseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate{
    
    
    
    // At this point, text has already been loaded.
    var textToAnalyse:String!
    var analyser:Analyser!
        
    
    
    var toCheck:[String] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        do {
            try analyser = Analyser(text: self.textToAnalyse)
            analyser.new_word_list = analyser.santizeString()
            analyser.create(many: 2)
        }
            
        catch {
            debugPrint("Error in initializing!")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return analyser.word_list_with_blanks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "word", for: indexPath) as! UICollectionViewCellCustomCollectionViewCell
        
        cell.textField.text = self.analyser.word_list_with_blanks[indexPath.item]
        cell.textField.placeholder = "Fill Here"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("\(indexPath.item)")
    }
    
    func check(tocheck:[String]) -> Bool {
        if self.analyser.word_list_with_blanks.sorted() == tocheck.sorted() && self.analyser.word_list_with_blanks.count == tocheck.count {
            return true
        }
        else {
            return false
        }
    }
    func createAlert(v:String) {
        let alert = UIAlertController(title: v, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Alright", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func checkAnswers(_ sender: UIButton) {
        for i in collectionView.indexPathsForVisibleItems {
            let cell = collectionView.cellForItem(at: i) as! UICollectionViewCellCustomCollectionViewCell
            if let input = cell.textField.text {
                
                
                
                               self.toCheck.append(input)
            }
        }
        
        
        /*
         print(toCheck)
         print(analyser.getWordList())
         
         
         */
        
       
        
        var sanitized:Array<String> = []
        for i in toCheck {
            sanitized.append(i.trimmingCharacters(in: .whitespaces))
        }
        
        
        
        
        if sanitized.sorted() == analyser.getWordList().sorted() && sanitized.count == analyser.getWordList().count {
            createAlert(v: "Awesome! You got everything correct.")
            print (sanitized)
            print(analyser.getWordList())
        }
        else {
            createAlert(v: "Oops! One or more inputs wrong.")
            print (toCheck)
            print(analyser.getWordList())
            
        }
        
    }
    
    
    
    
    
}
