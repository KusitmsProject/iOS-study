//
//  DataModel.swift
//  APITest
//
//  Created by 오예진 on 2022/10/24.
//

import Alamofire

func getData(_ completedHandler : @escaping (Data)->Void){
    let url = "https://vjsel.herokuapp.com/book/comments/1"
    AF.request(
        url,
        method: .get,
        parameters: nil,
        encoding: URLEncoding.default,
        headers: ["Content-Type":"application/json", "Accept":"application/json"]
    )
    .validate(statusCode: 200..<500)
    .responseJSON(completionHandler: { response in
        switch response.result{
            
        case .success:
            guard let result = response.data else {return}
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(Data.self, from: result)
                completedHandler(json)
            } catch {
                print("error!\(error)")
            }
            
        default:
            return
        }
    })
}
