//import UIKit
//
//class SettingsVС:  UIViewController, UITableViewDataSource,  UITableViewDelegate{
//    @IBOutlet weak var tableView: UITableView!
//    var activityIndicator: UIActivityIndicatorView!
//    var objectId: String?
//    var fetchedQuestions: [String] = []
//    var name_test: String = ""
//    private let nameTest = OnlineNameTest()
//
//    let simpleBluetoothIO = BluetoothManager()
//    
//    
//    
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.hidesBackButton = true
//        setupUI()
//   
//
//        
//        updateData(withObjectId: objectId ?? "")
//        print(simpleBluetoothIO.receivedDataArray)
//    }
//    
//   
//        
//
//
//    private func setupUI() {
//        activityIndicator = UIActivityIndicatorView(style: .gray)
//        activityIndicator.center = view.center
//        view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//    
//    func updateData(withObjectId objectId: String) {
//        self.objectId = objectId
//
//        nameTest.fetchDataFromAPI(objectId: objectId, token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) { [weak self] questions in
//            guard let self = self else { return }
//            
//            DispatchQueue.main.async {
//                if let fetchedQuestions = questions {
//                    self.fetchedQuestions = fetchedQuestions
//                    self.tableView.reloadData()
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.removeFromSuperview()
//                    
//                }
//                
//                 else {
//                     if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: self.name_test) {
//                         self.fetchedQuestions = questionsArray
//                         self.tableView.reloadData()
//                         self.activityIndicator.stopAnimating()
//                         self.activityIndicator.removeFromSuperview()
//                     }
//                    }
//                }
//            }
//        }
//   
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedQuestions.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier1", for: indexPath)
//        let answer = fetchedQuestions[indexPath.row] // Получаем ответ из массива fetchedQuestions на основе indexPath.row
//        cell.textLabel?.text = answer // Назначаем этот ответ текстом ячейки
//        return cell
//    }
//    @IBAction private func startTestButton(){
//        let storyboard = UIStoryboard(name: "AllTestStoryboard", bundle: nil)
//        
//        if let vc = storyboard.instantiateViewController(withIdentifier: "AllTestVC") as? AllTestVC {
//            vc.questions = fetchedQuestions
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//}




import UIKit

class SettingsVС:  UIViewController, UITableViewDataSource,  UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    var objectId: String?
    var fetchedQuestions: [String] = []
    var name_test: String = ""
    private let nameTest = OnlineNameTest()
    let simpleBluetoothIO = BluetoothManager()


    override func viewDidLoad() {
          super.viewDidLoad()
          navigationItem.hidesBackButton = true
          setupUI()
          
          simpleBluetoothIO.delegate = self // Устанавливаем делегата здесь
          updateData(withObjectId: objectId ?? "")
        printReceivedDataArray()
        for i in TestVC.array{
           print(i)
        }
   
      }






    private func setupUI() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        tableView.dataSource = self
        tableView.delegate = self
    }

    func updateData(withObjectId objectId: String) {
            self.objectId = objectId

            nameTest.fetchDataFromAPI(objectId: objectId, token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) { [weak self] questions in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    if let fetchedQuestions = questions {
                        self.fetchedQuestions = fetchedQuestions
                        self.tableView.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()

                    } else {
                        if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: self.name_test) {
                            self.fetchedQuestions = questionsArray
                            self.tableView.reloadData()
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.removeFromSuperview()
                        }
                    }
                }
            }
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier1", for: indexPath)
        let answer = fetchedQuestions[indexPath.row] // Получаем ответ из массива fetchedQuestions на основе indexPath.row
        cell.textLabel?.text = answer // Назначаем этот ответ текстом ячейки
        return cell
    }
    @IBAction private func startTestButton(){
        let storyboard = UIStoryboard(name: "AllTestStoryboard", bundle: nil)

        if let vc = storyboard.instantiateViewController(withIdentifier: "AllTestVC") as? AllTestVC {
            vc.questions = fetchedQuestions
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SettingsVС: BluetoothManagerDelegate {
    // Реализуем метод делегата для получения данных из BluetoothManager
    func didReceiveData(data: String) {
        simpleBluetoothIO.receivedDataArray.append(data)
        printReceivedDataArray()
        // Обновляем интерфейс, если необходимо, и взаимодействуем с данными
    }
    
    func printReceivedDataArray() {
        print("Received Data Array:")
        for data in simpleBluetoothIO.receivedDataArray {
            print(data)
        }
    }
}
