//___FILEHEADER___

import UIKit
import RxSwift
import RxDataSources

class ___FILEBASENAMEASIDENTIFIER___: UIViewController {
    
    typealias SectionModel = ___VARIABLE_productName:identifier___SectionModel
    
    typealias ViewModel = ___VARIABLE_productName:identifier___ViewModel
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionModel>(configureCell: configureCell)
    
    private lazy var configureCell: RxCollectionViewSectionedAnimatedDataSource<SectionModel>.ConfigureCell = { [weak self] (dataSource, collectionView, indexPath, item) in
        
        return <#UICollectionViewCell#>
    }
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        setupAllConstraint(collectionView)
        
        setupBindings()
    }

    private func setupBindings() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let output = viewModel.trans(input: <#ViewModel.Input#>)
        
        output.sectionStreams.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ___FILEBASENAMEASIDENTIFIER___: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return <#CGSize#>
    }
}
