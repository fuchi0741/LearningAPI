//
//  QiitaModel.swift
//  sampleUseAPI
//
//  Created by 渕一真 on 2021/03/09.
//

import Foundation

struct Qiita: Codable {
    let title: String
    let createdAt: String
    let user: User
    
    private enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case user
    }
}

struct User: Codable {
    let name: String
    let profileImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case profileImageUrl = "profile_image_url"
    }
}

struct QiitaManager {
    static var qiitas = [Qiita]()

    static func getQiitaApi(completionHander: @escaping () -> Void) {
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("情報の取得に失敗しました。", err)
            }
            
            if let data = data {
                do {
                    qiitas = try JSONDecoder().decode([Qiita].self, from: data)
                    DispatchQueue.main.async {
                        completionHander()
                    }
                    print("JSONが取得できた", qiitas)
                } catch(let err) {
                    print("情報の取得に失敗しました", err)
                }
            }
        }
        task.resume()
    }
}
