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

}


class FirestoreService : FirestoreServiceProtocol{
    
    private let db = Firestore.firestore()
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
           }
           
           let snapshot = try await query.getDocuments()
           
           guard let document = snapshot.documents.first else {
               return nil
           }
           
           do {
               let decodedObject = try document.data(as: T.self)
               return decodedObject
           } catch {
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
}
