//
//  Lembrete+CoreDataProperties.swift
//  TDMP3-EX2
//
//  Created by Roger Peratello on 10/12/22.
//
//

import Foundation
import CoreData


extension Lembrete {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lembrete> {
        return NSFetchRequest<Lembrete>(entityName: "Lembrete")
    }

    @NSManaged public var texto: String?
    @NSManaged public var concluido: Bool

}

extension Lembrete : Identifiable {

}
