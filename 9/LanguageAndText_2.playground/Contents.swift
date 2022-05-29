import UIKit
import NaturalLanguage
import CoreML

private func printNamedEntities(text: String) {
    
    let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
    tagger.string = text
    
    let range = NSRange(location: 0, length: text.count)
    
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    
    let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
    
    tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, stop in
        
        if let tag = tag, tags.contains(tag) {
            let name = (text as NSString).substring(with: tokenRange)
            print("\(name) is a \(tag.rawValue)")
        }
        
    }
    
}


["My name is John and I love to visit Australia", "My name is Mary and I work for Google","Yesterday, I went to Costa Rica and also met with James who works at Exxon", "Holla Comos Estas"].forEach { text in
        
    printNamedEntities(text: text)
    
}
