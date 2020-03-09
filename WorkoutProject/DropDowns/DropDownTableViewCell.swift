import UIKit

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var dropdownLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        if (UIScreen.main.bounds.size.width > 320) {
            let fontSize = dropdownLabel?.font.pointSize
            var percent = UIScreen.main.bounds.size.width / 320

            // cap the percent from getting too big (iPad)
            if percent > 1.5 {
                percent = 1.5
            }

            let newFontSize = fontSize! * percent
            dropdownLabel?.font = (dropdownLabel?.font?.withSize(newFontSize))!
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
