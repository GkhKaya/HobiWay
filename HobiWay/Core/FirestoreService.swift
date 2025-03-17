//
//  FirestoreManager.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 15.10.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol FirestoreServiceProtocol{
    func getAllDocument<T:Decodable>(from collection:String) async throws -> [T]
    func getDocumentById<T: Decodable>(from collection: String, documentId: String) async throws -> T?
    func getDocumentsWhere<T: Decodable>(from collection: String, where conditions: [(field: String, value: Any)]) async throws -> [T]
    func addDocument<T: Encodable>(to collection: String, data: T) async throws
    func getDocumentWhere<T: Decodable>(from collection: String, where conditions: [(field: String, value: Any)]) async throws -> T?
    func updateDocument(in collection: String, documentId: String, with data: [String: Any]) async throws
    func setDocument<T: Encodable>(documentId: String, in collection: String, data: T) async throws
    func deleteDocument(from collection: String, documentId: String) async throws

}


class FirestoreService : FirestoreServiceProtocol{
    
     let db = Firestore.firestore()
    private let decoder: Firestore.Decoder = {
            let decoder = Firestore.Decoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
    
    func getAllDocument<T>(from collection: String) async throws -> [T] where T : Decodable {
        let collectionRef = db.collection(collection)
        let snapshot = try await collectionRef.getDocuments()
        
        guard !snapshot.isEmpty else {
            print("No documents found in the collection")
            return []
        }
        
        do {
            // `DocumentSnapshot`'ları doğrudan decode et
            let documents = snapshot.documents
            let decodeObjects = try documents.compactMap { try $0.data(as: T.self) }
            return decodeObjects
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
    
    func getDocumentById<T: Decodable>(from collection: String, documentId: String) async throws -> T? {
        let documentRef = db.collection(collection).document(documentId)
        let snapshot = try await documentRef.getDocument()

        guard snapshot.exists else {
            print("No document found with ID \(documentId)")
            return nil
        }
        
        do {
            let decodedObject = try snapshot.data(as: T.self)
            return decodedObject
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
    
    func getDocumentsWhere<T>(from collection: String, where conditions: [(field: String, value: Any)]) async throws -> [T] where T: Decodable {
        var query: Query = db.collection(collection)
        
        // Her bir koşul için whereField ekle
        for condition in conditions {
            query = query.whereField(condition.field, isEqualTo: condition.value)
        }
        
        let snapshot = try await query.getDocuments()
        
        guard !snapshot.isEmpty else {
            print("No documents found matching the query")
            return []
        }
        
        do {
            let documents = snapshot.documents
            let decodedObjects = try documents.compactMap { try $0.data(as: T.self) }
            return decodedObjects
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
    
    func getDocumentWhere<T>(from collection: String, where conditions: [(field: String, value: Any)]) async throws -> T? where T: Decodable {
        var query: Query = db.collection(collection)
        
        for condition in conditions {
            query = query.whereField(condition.field, isEqualTo: condition.value)
            print("Query condition added: \(condition.field) == \(condition.value)")
        }
        
        let snapshot = try await query.getDocuments()
        print("Query executed, document count: \(snapshot.documents.count)")
        
        guard let document = snapshot.documents.first else {
            print("No documents found for query in collection: \(collection)")
            return nil
        }
        
        let documentData = document.data()
        print("Document data: \(documentData)")
        
        do {
            let decodedObject = try document.data(as: T.self)
            print("Decoded object: \(decodedObject)")
            return decodedObject
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func addDocument<T>(to collection: String, data: T) async throws where T: Encodable {
            let collectionRef = db.collection(collection)
            
            do {
                try collectionRef.addDocument(from: data)
                print("Document added successfully")
            } catch {
                print("Error adding document: \(error)")
                throw error
            }
        }
    
    func setDocument<T>(documentId: String, in collection: String, data: T) async throws where T: Encodable {
        let documentRef = db.collection(collection).document(documentId)
        
        do {
            try documentRef.setData(from: data)
            print("Document with ID \(documentId) set successfully")
        } catch {
            print("Error setting document: \(error)")
            throw error
        }
    }
    
    func updateDocument(in collection: String, documentId: String, with data: [String: Any]) async throws {
            let documentRef = db.collection(collection).document(documentId)
            
            do {
                try await documentRef.updateData(data)
                print("Document successfully updated")
            } catch {
                print("Error updating document: \(error)")
                throw error
            }
        }
    
    func deleteDocument(from collection: String, documentId: String) async throws {
            let documentRef = db.collection(collection).document(documentId)
            
            do {
                try await documentRef.delete()
                print("Document with ID \(documentId) successfully deleted from collection \(collection)")
            } catch {
                print("Error deleting document: \(error)")
                throw error
            }
        }
    
    private func cleanJSONString(_ jsonString: String) -> String {
            // Başındaki ve sonundaki boşlukları temizle
            var cleaned = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Eğer JSON string içinde "```json" veya "```" varsa temizle
            // (Gemini bazen markdown formatında yanıt verebiliyor)
            cleaned = cleaned.replacingOccurrences(of: "```json", with: "")
            cleaned = cleaned.replacingOccurrences(of: "```", with: "")
            
            // Tekrar whitespace'leri temizle
            cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
            
            return cleaned
        }
        
        func importJSONData(from jsonString: String, to collection: String) async throws {
            // JSON string'i temizle
            let cleanedJSON = cleanJSONString(jsonString)
            print("Cleaned JSON: \(cleanedJSON)") // Debug için
            
            guard let jsonData = cleanedJSON.data(using: .utf8) else {
                throw NSError(domain: "JSONParsingError", code: -1,
                             userInfo: [NSLocalizedDescriptionKey: "Invalid JSON string encoding"])
            }
            
            do {
                // JSON parsing options'a fragment'ı ekle
                let options = JSONSerialization.ReadingOptions.fragmentsAllowed
                
                guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: options) as? [String: Any] else {
                    // Eğer dictionary olarak parse edilemezse, array olarak dene
                    guard let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: options) as? [[String: Any]] else {
                        throw NSError(domain: "JSONParsingError", code: -2,
                                    userInfo: [NSLocalizedDescriptionKey: "Cannot parse JSON"])
                    }
                    
                    // Array ise her bir elementi ekle
                    for item in jsonArray {
                        try await db.collection(collection).addDocument(data: item)
                    }
                    return
                }
                
                // Tek bir object ise direkt ekle
                try await db.collection(collection).addDocument(data: jsonObject)
                print("JSON data successfully imported to Firestore")
                
            } catch {
                print("Error parsing JSON: \(error)")
                print("Original JSON string: \(jsonString)") // Debug için
                throw error
            }
        }
    
    
}
