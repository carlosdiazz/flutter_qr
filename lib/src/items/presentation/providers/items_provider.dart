import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr/src/src.dart';
import 'package:uuid/uuid.dart';

final itemsProvider = StateNotifierProvider<ItemsNotifier, ItemsState>((ref) {
  final itemRepository = ref.watch(itemsRepositoryProvider);

  return ItemsNotifier(itemRepository: itemRepository);
});

class ItemsNotifier extends StateNotifier<ItemsState> {
  final ItemRepository itemRepository;
  final Uuid _uuid = const Uuid();

  ItemsNotifier({required this.itemRepository}) : super(const ItemsState()) {
    loadItems();
  }

  Future<void> loadItems() async {
    _setLoading();
    try {
      final items = await itemRepository.getAllItem();
      state = state.copyWith(
          isError: false, isLoading: false, items: items, message: "ok");
    } catch (e) {
      print(e);
      _setError();
    }
  }

  Future<void> deleteAlltems() async {
    _setLoading();
    try {
      await itemRepository.deleteAllItem();
      state = state.copyWith(
          isError: false, isLoading: false, items: [], message: "ok");
    } catch (e) {
      print(e);
      _setError();
    }
  }

  Future<void> createItem(String text) async {
    _setLoading();
    try {
      final ItemEntity newItem = ItemEntity(text: text, uuid: _uuid.v4());
      await itemRepository.createItem(newItem);
      loadItems();
    } catch (e) {
      print(e);
      _setError();
    }
  }

  Future<void> deleteItem(String uuid) async {
    _setLoading();
    try {
      await itemRepository.deleteOneItem(uuid);
      loadItems();
    } catch (e) {
      print(e);
      _setError();
    }
  }

  void _setLoading() {
    state = state.copyWith(
      isError: false,
      isLoading: true,
    );
  }

  void _setError() {
    state = state
        .copyWith(items: [], isError: true, isLoading: false, message: "Error");
  }
}

class ItemsState extends Equatable {
  final bool isError;
  final bool isLoading;
  final String message;
  final List<ItemEntity> items;

  const ItemsState(
      {this.isError = false,
      this.message = "",
      this.items = const [],
      this.isLoading = false});

  ItemsState copyWith(
          {bool? isLoading,
          List<ItemEntity>? items,
          String? message,
          bool? isError}) =>
      ItemsState(
          isLoading: isLoading ?? this.isLoading,
          items: items ?? this.items,
          message: message ?? this.message,
          isError: isError ?? this.isError);

  @override
  List<Object> get props => [
        isError,
        message,
        items,
        isLoading,
      ];
}
