// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ItemStore on _ItemStore, Store {
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems => (_$totalItemsComputed ??= Computed<int>(
    () => super.totalItems,
    name: '_ItemStore.totalItems',
  )).value;
  Computed<int>? _$totalCharactersComputed;

  @override
  int get totalCharacters => (_$totalCharactersComputed ??= Computed<int>(
    () => super.totalCharacters,
    name: '_ItemStore.totalCharacters',
  )).value;
  Computed<int>? _$totalEditsComputed;

  @override
  int get totalEdits => (_$totalEditsComputed ??= Computed<int>(
    () => super.totalEdits,
    name: '_ItemStore.totalEdits',
  )).value;
  Computed<int>? _$totalLettersComputed;

  @override
  int get totalLetters => (_$totalLettersComputed ??= Computed<int>(
    () => super.totalLetters,
    name: '_ItemStore.totalLetters',
  )).value;
  Computed<int>? _$totalNumbersComputed;

  @override
  int get totalNumbers => (_$totalNumbersComputed ??= Computed<int>(
    () => super.totalNumbers,
    name: '_ItemStore.totalNumbers',
  )).value;

  late final _$itemsAtom = Atom(name: '_ItemStore.items', context: context);

  @override
  ObservableList<ItemModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<ItemModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$_ItemStoreActionController = ActionController(
    name: '_ItemStore',
    context: context,
  );

  @override
  void addItem(String text) {
    final _$actionInfo = _$_ItemStoreActionController.startAction(
      name: '_ItemStore.addItem',
    );
    try {
      return super.addItem(text);
    } finally {
      _$_ItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editItem(int index, String newText) {
    final _$actionInfo = _$_ItemStoreActionController.startAction(
      name: '_ItemStore.editItem',
    );
    try {
      return super.editItem(index, newText);
    } finally {
      _$_ItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem(int index) {
    final _$actionInfo = _$_ItemStoreActionController.startAction(
      name: '_ItemStore.removeItem',
    );
    try {
      return super.removeItem(index);
    } finally {
      _$_ItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
totalItems: ${totalItems},
totalCharacters: ${totalCharacters},
totalEdits: ${totalEdits},
totalLetters: ${totalLetters},
totalNumbers: ${totalNumbers}
    ''';
  }
}
