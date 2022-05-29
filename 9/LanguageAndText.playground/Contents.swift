import UIKit
import NaturalLanguage
import CoreML



private func predictLanguage(text: String) -> String? {
    
    let locale = Locale(identifier: "en")
    let recognizer = NLLanguageRecognizer()
    
    recognizer.processString(text)
    
    guard let language = recognizer.dominantLanguage else {
        return "Unable to predict language"
    }
    
    print(language)
    
    return locale.localizedString(forLanguageCode: language.rawValue)
    
}

["Hello World", "Holla Comos Estas","5%%5","ہیلو آپ کیسے ہیں؟","Hello Holla"].forEach {
    if let prediction = predictLanguage(text: $0) {
        print(prediction)
    }
}
