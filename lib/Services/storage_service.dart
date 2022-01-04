import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class StorageService extends ChangeNotifier {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  String _base = '';
  firebase_storage.FirebaseStorage? _storage;
  firebase_storage.Reference? _currentref;
  firebase_storage.ListResult? _currentcontents;
  List<firebase_storage.Reference>? _currentcategories;
  List<firebase_storage.Reference>? _currentitems;
  firebase_storage.Reference? _currentitem;
  String _currentdownloadurl = '';

  StorageService() {
    initialize();
  }

  void initialize() {
    _storage = firebase_storage.FirebaseStorage.instance;
    _currentref = null;
    _currentcontents = null;
    resetcurrentcontent();
  }

  // reset current content
  void resetcurrentcontent() {
    _currentcontents = null;
    _currentcategories = null;
    _currentitems = null;
    _currentitem = null;
    _currentdownloadurl = '';
  }

  //set reference - you can set this any number of times - this will refresh its
  // children and notify listeners
  void setReference(String base) async {
    logger.d("SetReference called with: " + base);
    //check if same ref
    if (_base == base) {
      logger.d("Reference already at " + base);
      return; // reference previously set
    }

    _base = base;
    _currentref = _storage!.ref(base);
    resetcurrentcontent();
    if (_currentref == null) {
      logger.d("Storage refernece not found: " + base);
      notifyListeners();
      return;
    }

    //get list of all contents
    _currentcontents = await list();

    if (_currentcontents == null) {
      logger.d("Found no contents");
      notifyListeners();
      return;
    }

    if (_currentcontents!.prefixes.isEmpty) {
      logger.d("Found no directories");
      if (_currentcontents!.items.isEmpty) {
        logger.d("Found no items");
        notifyListeners();
        return;
      }
    }

    logger.d("SerReference found contents");
    _currentcategories = _currentcontents!.prefixes;
    if (_currentcategories != null) {
      for (int i = 0; i < _currentcategories!.length; i++) {
        logger.d("Found directory: " + _currentcategories![i].fullPath);
      }
    }

    _currentitems = _currentcontents!.items;
    if (_currentitems == null) {
      logger.d("Found no items");
      notifyListeners();
      return;
    }

    for (int i = 0; i < _currentitems!.length; i++) {
      logger.d("Found item: " + _currentitems![i].fullPath);
    }

    _currentitem = _currentitems![0];
    _currentdownloadurl = '';
    if (_currentitem != null) {
      logger.d("Selected item: " + _currentitem!.fullPath);
    }

    notifyListeners();
  }

  String getCurrentDownloadUrl() {
    return _currentdownloadurl;
  }

  List<firebase_storage.Reference>? getCurrentItems() {
    return _currentitems;
  }

  List<firebase_storage.Reference>? getCurrentCategories() {
    return _currentcategories;
  }

  firebase_storage.Reference? getCurrentItem() {
    return _currentitem;
  }

  // set a selected item
  void setSelectedItem(int index) {
    if (_currentitems == null) return;
    //if item already selected
    if (_currentitem == _currentitems!.elementAt(index)) return;
    //if new selection
    _currentdownloadurl = '';
    _currentitem = _currentitems!.elementAt(index);
    notifyListeners();
  }

  //get top level categories
  Future<List<firebase_storage.Reference>?> listCategories() async {
    firebase_storage.ListResult? all = await list();
    return (all == null) ? null : _currentcategories = all.prefixes;
  }

  //get all lists
  Future<firebase_storage.ListResult?> list() async {
    firebase_storage.ListOptions options =
        const firebase_storage.ListOptions(maxResults: 10);

    return await _currentref!.list(options);
  }

  Future<String> getDownloadUrl(String childpath) async {
    if (_currentref == null) return '';
    return await _currentref!.child(childpath).getDownloadURL();
  }

  Future<String> fetchCurrentDownloadUrl() async {
    if (_currentitem == null) return '';
    _currentdownloadurl = await _currentitem!.getDownloadURL();
    return _currentdownloadurl;
  }
}
