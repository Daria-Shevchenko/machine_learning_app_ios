//
//  IncredientsView.swift
//  RecipeRecommender
//
//  Created by Mohammad Azam on 3/11/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct IncredientsView: View {
    
    let incredients: [String]
    
    var body: some View {
        List(self.incredients, id: \.self) { incredient in
            Text(incredient)
        }
    }
}

struct IncredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IncredientsView(incredients: [String]())
    }
}
