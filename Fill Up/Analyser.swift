import UIKit
import Foundation

// MARK : EXTENSION
// CAN BE CONVERTED TO FUNCTION
extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

class Analyser {
    var textToAnalyse:String!
    var word_list:Array<String>!
    var new_word_list:Array<String>!
    var word_list_with_blanks:Array<String>!
    var answers:Dictionary<Int, String> = [:]
    
    
    var to_delete = ["is","from","what","where",".",",","!",">","<","=","where","?"]
    
    
    
    init(text:String) {
        self.textToAnalyse = text.lowercased()
        word_list = textToAnalyse.components(separatedBy: " ")
    }
    
    
    func santizeString() -> [String] {
        
        var new_word_list: Array<String> = []
        var to_del_set:Set<String> = Set(to_delete)
        var w:Set<String> = Set(self.word_list)
        
        if Array(w.intersection(to_del_set)) == [] {
            return Array(w)
        }
        else {
            let x = Array(w.intersection(to_del_set))
            for k in x{
                word_list.remove(at:word_list.index(of: k)!)
                
            }
            
            // MARK: NEW WORD LIST CREATED
            self.new_word_list = word_list
            return word_list
        }
        return []
    }
    
    
    
    func create(many:Int) -> [String] {
        for i in 1...many {
            
            let toRemoveAndStore = self.new_word_list.randomItem()
            
            answers[i] = toRemoveAndStore
            
            var v = self.new_word_list.index(of: toRemoveAndStore)
            new_word_list[v!] = " "
        }
        
        self.word_list_with_blanks = new_word_list
        return self.word_list_with_blanks
    }
    
    
    func checkAnswers(x:String...) -> Bool {
        for i in x {
            self.word_list_with_blanks.append(i)
        }
        
        
        var tocheck = self.word_list_with_blanks.sorted()
        var with = self.word_list.sorted()
        
        if tocheck.count == with.count && tocheck == with {
            return true
        }
        else {
            return false
        }
    }
    
    
    func getWordList() -> [String] {
        return self.word_list
    }
}


/*
 
 Testing
 =========================================
 
 var text = "Aadit is Kapoor"
 
 var a = Analyser(text: text)
 
 a.getWordList()
 a.santizeString()
 
 a.create(many: 1)
 a.word_list
 a.word_list_with_blanks[a.word_list_with_blanks.index(of: " ")!] = "aadit"
 
 
 */

















