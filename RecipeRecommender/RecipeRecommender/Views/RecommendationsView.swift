//
//  RecommendationsView.swift
//  RecipeRecommender
//
//  Created by Mohammad Azam on 3/11/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct RecommendationsView: View {
    
    let recommendations: [String]
    var incredientAdded: (String) -> Void = { _ in }
    
    var body: some View {
        List(self.recommendations, id: \.self) { recommendation in
            HStack {
                Text(recommendation)
                Spacer()
                Image(systemName: "plus")
                    .onTapGesture {
                        self.incredientAdded(recommendation)
                }
            }
        }
    }
}

struct RecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsView(recommendations: ["Garlic"])
    }
}
