public final class ProductsListInjector {
    
    // Datasources
    private lazy var dataBaseDataSource = ProductsListDataBaseDataSource()
    private lazy var remoteDataSource = ProductsListRemoteDataSource()
    
    // Repositories
    private lazy var repository: ProductsListRepository = {
        ProductsListRepository(dataBaseDataSource: dataBaseDataSource,
                               remoteDataSource: remoteDataSource)
    }()
    
    // UseCases
    private lazy var useCases = ProductsListUseCase(repository: repository)
    
    // ViewModel
    public lazy var viewModel = ProductsListViewModel(useCase: useCases)
    
}
