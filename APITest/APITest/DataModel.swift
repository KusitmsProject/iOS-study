struct Comment : Decodable {
    var comments : [Data]
}


struct Data: Decodable {
    let content: String
    let userId: String
    let createdAt: String
    let updateAt: String
}
