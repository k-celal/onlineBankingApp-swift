import Foundation

class ApiPostTransactionService {
    private let localStorageManager: LocalStorageManager
    
    init() {
        self.localStorageManager = LocalStorageManager()
    }
    
    func depositMoney(accountId: String, depositAmount: String, completion: @escaping (Result<DepositResponseModel, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8070/transact/deposit") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Access token'i al
        guard let accessToken = localStorageManager.getAccessToken() else {
            completion(.failure(AuthenticationError.missingAccessToken))
            return
        }
        
        // Access token'i header'a ekle
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Request body oluştur
        let createAccountRequestModel = DepositRequestModel(accountId: accountId, depositAmount: depositAmount)
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(createAccountRequestModel)
        } catch {
            completion(.failure(NetworksError.serializationError))
            return
        }
        
        // URLSession ile isteği gönder
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworksError.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworksError.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworksError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(DepositResponseModel.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()

    }
    func createAccount(accountName: String, accountType: String, completion: @escaping (Result<AccountModel, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8070/account/create_account") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Access token'i al
        guard let accessToken = localStorageManager.getAccessToken() else {
            completion(.failure(AuthenticationError.missingAccessToken))
            return
        }
        
        // Access token'i header'a ekle
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Request body oluştur
        let createAccountRequestModel = CreateAccountRequestModel(accountName: accountName, accountType: accountType)
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(createAccountRequestModel)
        } catch {
            completion(.failure(NetworksError.serializationError))
            return
        }
        
        // URLSession ile isteği gönder
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworksError.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworksError.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworksError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let accountModels = try decoder.decode([AccountModel].self, from: data)
                print(accountModels)
                guard let accountModel = accountModels.last else {
                    completion(.failure(NetworksError.invalidData))
                    return
                }
                completion(.success(accountModel))
            } catch {
                completion(.failure(NetworksError.decodingError))
            }
        }

        task.resume()

    }
}
