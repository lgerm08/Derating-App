
import UIKit

class TextFieldObject {
    var id: String
    var labelTitle: String
    var unit: String
    var value: Double?
    
    init(
        id: String,
        labelTitle: String,
        unit: String
    ) {
        self.id = id
        self.labelTitle = labelTitle
        self.unit = unit
    }
}
