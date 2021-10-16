//
//  Paginator.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 12/10/2021.
//

import RxSwift
import RxCocoa

protocol PaginateProvider {
    func fetchData<T>(pageIndex: Int) -> Observable<[T]>
}

class Paginator<T> {
    let refreshTrigger = PublishSubject<Void>()
    let loadNextPageTrigger = PublishSubject<Void>()
    let loading = BehaviorRelay<Bool>(value: false)
    let elements = BehaviorRelay<[T]>(value: [])
    var pageIndex: Int = 0
    let error = PublishSubject<Swift.Error>()
    var totalItems: Int = 0
    var isAllLoaded: Bool = false

    private let disposeBag = DisposeBag()

    init(provider: PaginateProvider) {
        let request = Observable
            .of(refreshRequest(), nextPageRequest())
            .merge()
            .share(replay: 1)

        let response = request.flatMap { offset -> Observable<[T]> in
            provider.fetchData(pageIndex: offset)
                .do(onError: { [weak self] error in
                    self?.error.onNext(error)
                }).catch({ _ -> Observable<[T]> in
                    Observable.empty()
                })
        }.share(replay: 1)

        response.flatMap { resElements -> Observable<[T]> in
            let res = self.pageIndex == 0 ? resElements : self.elements.value + resElements
            self.isAllLoaded = self.totalItems == res.count
            return Observable.of(res)
        }
            .sample(response)
            .bind(to: elements)
            .disposed(by: disposeBag)

        Observable
            .of(request.map { _ in true },
                response.map { _ in false },
                error.map { _ in false })
            .merge()
            .bind(to: loading)
            .disposed(by: disposeBag)
    }

    private func refreshRequest() -> Observable<Int> {
        return loading.asObservable()
            .sample(refreshTrigger)
            .flatMap { loading -> Observable<Int> in
                if loading || self.pageIndex == 0 {
                    return Observable<Int>.create { [weak self] observer in
                        self?.elements.accept([])
                        self?.pageIndex = 1
                        observer.onNext(1)
                        observer.onCompleted()
                        return Disposables.create()
                    }

                } else {
                    return Observable.empty()
                }
        }
    }

    private func nextPageRequest() -> Observable<Int> {
        return loading.asObservable()
            .sample(loadNextPageTrigger)
            .flatMap { [weak self] loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    guard !(self?.isAllLoaded ?? false) else { return Observable.empty() }

                    return Observable<Int>.create { [weak self] observer in
                        self?.pageIndex += 1
                        observer.onNext(self?.pageIndex ?? 0)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
        }
    }
}
