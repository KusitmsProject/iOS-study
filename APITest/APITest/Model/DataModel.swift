struct Data: Decodable {
    var comments: [Comment]
}

struct Comment: Decodable, Hashable {
    let _id: String
    let content: String
    let userId: String
    let createdAt: String
    let updateAt: String
}

extension Comment {
    static var list = [
        Comment(_id: " ", content: "", userId: "", createdAt: "", updateAt: "")
    ]
}
