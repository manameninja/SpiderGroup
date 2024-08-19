//
//  OptionsViewModel.swift

//
//  Created by Даниил Павленко on 18.08.2024.
//

import Combine
import SwiftUI

// MARK: - OptionsViewModel

public class OptionsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var options: [Option] = []
    @Published var isSelectAll: Bool = false
    @Published var isSubmitEnabled: Bool = false
    
    var selectAllTapped: Bool = false
    
    private let dataService: DataService
    
    // MARK: - Initializer
    
    public init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Methods
    
    func toggleOptionSelection(_ option: Option) {
        guard let index = options.firstIndex(where: { $0.id == option.id }) else { return }
        options[index].isSelected.toggle()
        updateSelectAllState()
        updateSubmitButtonState()
    }
    
    func toggleSelectAll() {
        guard selectAllTapped else { return }
        isSelectAll.toggle()
        for index in options.indices where options[index].tappedOnSelectAll {
            options[index].isSelected = isSelectAll
        }
        updateSubmitButtonState()
    }
    
    private func updateSelectAllState() {
        let allSelected = options.filter { $0.tappedOnSelectAll }.allSatisfy { $0.isSelected }
        selectAllTapped = allSelected
        isSelectAll = allSelected
    }
    
    private func updateSubmitButtonState() {
        isSubmitEnabled = options.filter { $0.required }.allSatisfy { $0.isSelected }
    }
    
    func submit() {
        // TODO: An action to send data
    }
    
    // MARK: - ViewOutput
    
    func didTriggerViewReadyEvent() {
        Task {
            let result = await dataService.obtainOptions()
            await MainActor.run { [weak self] in
                switch result {
                case .success(let options):
                    self?.options = options
                case .failure(_): break
                    // TODO: Error handling
                }
                self?.updateSubmitButtonState()
            }
        }
    }
}
