import 'package:login_screen/data/services/item_model.dart';
import 'package:mobx/mobx.dart';

part 'item_store.g.dart';

class ItemStore = _ItemStore with _$ItemStore;
final itemStore = ItemStore();

abstract class _ItemStore with Store {

  @observable
  ObservableList<ItemModel> items = ObservableList<ItemModel>();

  @computed
  int get totalItems => items.length;

  @computed
  int get totalCharacters =>
      items.fold(0, (sum, item) => sum + item.text.length);

  @computed
  int get totalEdits =>
      items.fold(0, (sum, item) => sum + item.edits);

  @computed
  int get totalLetters =>
      items.fold(0, (sum, item) {
        final letters = item.text.replaceAll(RegExp(r'[^a-zA-ZÀ-ÿ]'), '');
        return sum + letters.length;
      });

  @computed
  int get totalNumbers =>
      items.fold(0, (sum, item) {
        final numbers = item.text.replaceAll(RegExp(r'[^0-9]'), '');
        return sum + numbers.length;
      });

  @action
  void addItem(String text) {
    if (text.trim().isEmpty) return;

    items.add(
      ItemModel(
        text: text,
        edits: 0,
      ),
    );
  }

  @action
  void editItem(int index, String newText) {
    if (newText.trim().isEmpty) return;

    final old = items[index];

    items[index] = ItemModel(
      text: newText,
      edits: old.edits + 1,
    );
  }

  @action
  void removeItem(int index) {
    items.removeAt(index);
  }
}
