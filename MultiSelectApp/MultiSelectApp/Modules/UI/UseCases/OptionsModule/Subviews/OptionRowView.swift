//
//  OptionRowView.swift
//
//  Created by Даниил Павленко on 18.08.2024.
//

import SwiftUI

// MARK: - OptionRowView

public struct OptionRowView: View {
    
    // MARK: - Proprties
    
    var option: Option
    var toggleSelection: () -> Void
    
    public var body: some View {
        HStack(alignment: .bottom) {
            Button(action: toggleSelection) {
                Image(systemName: Constants.Checkmark.imageName(option.isSelected))
                    .foregroundColor(Constants.Checkmark.foregroundColor(option.isSelected))
            }
            Text(option.title)
                .padding(.leading, Constants.doubleInset)
            
            if option.required {
                Text(loc("option.required.label"))
                    .font(Constants.RequiredLabel.font)
                    .kerning(Constants.RequiredLabel.kerning)
                    .foregroundColor(Constants.RequiredLabel.foregroundColor)
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Helpers

extension OptionRowView {
    
    struct Constants {
        
        /// Двойной отступ, **8 точек**
        static let doubleInset: CGFloat = 8
        
        /// Чекбокс
        struct Checkmark {
            
            /// Иконка
            static func imageName(_ isSelected: Bool) -> String { isSelected ? "checkmark.square.fill" : "square" }
            
            /// Цвет
            static func foregroundColor(_ isSelected: Bool) -> Color { isSelected ? .blue : .gray }
        }
        
        /// 'required' текст
        struct RequiredLabel {
            
            /// Шрифт
            static let font: Font = .system(size: 11)
            
            /// Отступ между символами, **-0.41 точки**
            static let kerning: CGFloat = -0.41
            
            /// Цвет текста
            static let foregroundColor: Color = .gray
        }
    }
}
