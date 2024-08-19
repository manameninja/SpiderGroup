//
//  OptionsView.swift
//
//  Created by Даниил Павленко on 18.08.2024.
//

import SwiftUI

public struct OptionsView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: OptionsViewModel
    
    // MARK: - Initializer
    
    public init() {
        self.viewModel = .init(dataService: DataServiceImplementation())
    }
    
    public var body: some View {
        VStack {
            HStack {
                Toggle(isOn: Binding(
                    get: { viewModel.isSelectAll },
                    set: { [weak vm = viewModel] newValue in
                        vm?.selectAllTapped = true
                        vm?.isSelectAll = newValue
                    }
                )) {
                    Text(loc("options.select-all.button"))
                }

                .frame(width: Constants.SelectAllButton.width)
                .onChange(of: viewModel.isSelectAll, viewModel.toggleSelectAll)

                Spacer()
                
                Button(action: viewModel.submit) {
                    Text(loc("options.submit.button"))
                        .padding()
                        .foregroundColor(Constants.SubmitButton.foregroundColor)
                        .background(Constants.SubmitButton.backgroundColor(viewModel.isSubmitEnabled))
                        .cornerRadius(Constants.doubleInset)
                }
                .disabled(!viewModel.isSubmitEnabled)
            }
            .padding(.horizontal)
            
            List(viewModel.options) { option in
                OptionRowView(option: option) {
                    viewModel.toggleOptionSelection(option)
                }
            }
            
        }
        .onAppear(perform: viewModel.didTriggerViewReadyEvent)
    }
}

// MARK: - Helpers

extension OptionsView {
    
    struct Constants {
        
        /// Двойной отступ, **8 точек**
        static let doubleInset: CGFloat = 8
        
        /// Кнопка 'Выбрать всё'
        struct SelectAllButton {
            
            /// Ширина, **180 точек**
            static let width: CGFloat = 180
        }
        
        /// Кнопка 'Отправить'
        struct SubmitButton {
            
            /// Цвет текста
            static let foregroundColor: Color = .white
            
            /// Цвет фона для активной и неактивной кнопки
            static func backgroundColor(_ isSubmitEnabled: Bool) -> Color { isSubmitEnabled ? Color.blue : Color.gray }
        }
    }
}

//struct OptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionsView()
//    }
//}
