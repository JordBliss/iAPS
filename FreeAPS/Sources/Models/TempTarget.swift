import Foundation

struct TempTarget: JSON, Identifiable {
    var id = UUID().uuidString
    let name: String
    var createdAt: Date
    let targetTop: Decimal
    let targetBottom: Decimal
    let duration: Decimal
    let enteredBy: String?

    static let manual = "freeaps-x://manual"
    static let custom = "Custom"
    static let cancel = "Cancel"
}

extension TempTarget {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case createdAt = "created_at"
        case targetTop
        case targetBottom
        case duration
        case enteredBy
    }
}