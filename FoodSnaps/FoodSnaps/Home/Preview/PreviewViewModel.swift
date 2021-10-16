//
//  PreviewViewModel.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 12/10/2021.
//

import RxSwift
import RxCocoa

class PreviewViewModel: PaginateProvider {
    // MARK: - Properties
    let pageSize: Int = 10
    var paginator: Paginator<String>?
    
    // MARK: Rx variable
    var loading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    func fetchData<T>(pageIndex: Int) -> Observable<[T]> {
        return Observable.create({ [weak self] observer in
            guard let self = self else { return Disposables.create() }
            print("get  the next 10 elements from and API")
            return Disposables.create()
        })
    }
}
