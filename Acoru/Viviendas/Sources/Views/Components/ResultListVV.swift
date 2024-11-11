//
//  ResultListVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 04/11/24.
//
import SwiftUI

struct ResultsListView: View {
    @Binding var resultModel: [EvaluadorVVModel]
    @Binding var currentThemeColor: ColorVariant

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(Array($resultModel.enumerated()), id: \.0) { index, model in
                    ResultItemView(model: model, currentThemeColor: $currentThemeColor)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}
