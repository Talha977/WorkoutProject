import UIKit

protocol DropdownViewControllerDelegate : class{
    func dropDown(sender:DropdownViewController, selected:String)
}

enum DropDownType {
    case NarcID
    case Age
    case Weight
    case Clinic
    case Vet
}

class DropdownViewController: UIViewController {
    
    
    
    weak var delegate: DropdownViewControllerDelegate?
    
    var currentType:DropDownType? = nil
    
    @IBOutlet weak var searchConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    var searchActive:Bool = false
    var searchFiltered:[String] = []
    var searchNarcNameFiltered = [[String]]()
    
    var narcIDArray = [String]()
    
    var selectedNarcID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 55.0
        
        
        if currentType == .NarcID  {
            
            self.searchbar.keyboardType = .numberPad
            
        }
            
        else if currentType == .Vet || currentType == .Clinic {
            
            self.searchbar.isHidden = true
            self.searchActive = false
        }
            
        else{
            
            self.searchbar.keyboardType = .default
            
        }
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        self.searchbar.delegate = self
        
        let nib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DropDownTableViewCell")
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layer.cornerRadius = 3
    }
    
    
}

//MARK: - tableview methods

extension DropdownViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            
            return self.searchFiltered.count
        }
        else
        {
            return narcIDArray.count
        }
        
    }
    
    func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DropDownTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
        if(searchActive){
            cell.dropdownLabel.text = searchFiltered[indexPath.row]
        }
        else
        {
            cell.dropdownLabel.text = narcIDArray[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            delegate?.dropDown(sender: self, selected: searchFiltered[indexPath.row])
            
        } else {
            
            delegate?.dropDown(sender: self, selected: narcIDArray[indexPath.row])
            
        }
        
        self.searchbar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
}

extension DropdownViewController : UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchbar.text = ""
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        return
        //        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText == "" || searchText == " "){
            searchActive = false
            
            self.tableView.reloadData()
            
        } else {
            searchActive = true
            self.itemsFilteredContentForSearchText(searchText: searchBar.text!)
            self.tableView.reloadData()
        }
    }
    
    func itemsFilteredContentForSearchText(searchText:String) {
        
        self.searchFiltered = self.narcIDArray.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let rang = tmp.range(of: searchText, options: [.anchored, .caseInsensitive])
            
            return rang.location != NSNotFound
        })
        
        searchActive = true
        
    }
    
}
