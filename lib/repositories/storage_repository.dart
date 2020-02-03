import 'dart:io';

import 'package:learn_flutter/providers/storage_provider.dart';

class StorageRepository {
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadImage(File file, String path) => storageProvider.uploadImage(file, path);
}