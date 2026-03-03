import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FirestoreServices {
  // singleton
  FirestoreServices._();
  static final instance = FirestoreServices._();
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  // add & update data
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    debugPrint('$path: $data');
    await reference.set(data);
  }

  // update data
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    await reference.update(data);
  }

  // delete data
  Future<void> deleteData({required String path}) async {
    final reference = firestore.doc(path);
    await reference.delete();
  }

  //
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documntedId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs
              .map(
                (snapshot) => builder(
                  snapshot.data() as Map<String, dynamic>,
                  snapshot.id,
                ),
              )
              .where((v) => v != null)
              .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  //
  Stream<T> documnetStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documntedId) builder,
  }) {
    final reference = firestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) =>
          builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
    );
  }

  // One Time Request for the document
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final reference = firestore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  // One Time Request for a list of documents
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documntedId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = await query.get();
    final result =
        snapshots.docs
            .map(
              (snapshot) =>
                  builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
            )
            .where((v) => v != null)
            .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }
}
