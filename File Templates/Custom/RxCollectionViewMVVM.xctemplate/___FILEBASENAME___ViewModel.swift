//___FILEHEADER___

import Foundation
import RxSwift

class ___FILEBASENAMEASIDENTIFIER___ {
    
    typealias SectionModel = ___VARIABLE_productName:identifier___SectionModel
    
    func trans(input: Input) -> Output {
        
        return Output(sectionStreams: <#Observable<[SectionModel]>#>)
    }
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    struct Input {
        
    }

    struct Output {
        let sectionStreams: Observable<[SectionModel]>
    }
}
