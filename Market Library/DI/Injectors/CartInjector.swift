//
//  CartInjector.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

public final class CartInjector {
    
    // Datasources
    private lazy var dataSource = CartDataBaseDataSource()
    
    // Repositories
    private lazy var repository = CartRepository(dataSource: dataSource)
    
    // UseCases
    private lazy var useCase = CartUseCase(repository: repository)
    
    // ViewModel
    public lazy var viewModel = CartViewModel(useCase: useCase)
}
