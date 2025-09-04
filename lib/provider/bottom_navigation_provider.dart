import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base_riverpod/view/screens/home_screen/home_screen.dart';
import 'package:flutter_base_riverpod/view/screens/menu_screen/menu_screeen.dart';

// State class for bottom navigation
class BottomNavigationState {
  final int currentIndex;
  final List<Widget> bottomNavigationIndex;
  final List<String> bottomNavigationIndexNameList;

  BottomNavigationState({
    this.currentIndex = 0,
    required this.bottomNavigationIndexNameList,
    required this.bottomNavigationIndex,
  });

  BottomNavigationState copyWith({
    int? currentIndex,
    List<Widget>? bottomNavigationIndex,
    List<String>? bottomNavigationIndexNameList,
  }) {
    return BottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      bottomNavigationIndex:
          bottomNavigationIndex ?? this.bottomNavigationIndex,
      bottomNavigationIndexNameList:
          bottomNavigationIndexNameList ?? this.bottomNavigationIndexNameList,
    );
  }
}

// Bottom Navigation StateNotifier
class BottomNavigationNotifier extends StateNotifier<BottomNavigationState> {
  BottomNavigationNotifier()
    : super(
        BottomNavigationState(
          bottomNavigationIndex: [HomeScreen(), MenuScreen()],
          bottomNavigationIndexNameList: ['Home', 'Menu'],
        ),
      );

  // set Current Index
  void setCurrentIndex(int newIndex) {
    state = state.copyWith(currentIndex: newIndex);
  }

  // Reset Index
  void resetIndex() {
    state = state.copyWith(currentIndex: 0);
  }

  /*=====================================
  APIs calling
 ======================================*/
  // Variables
}

// Providers
final bottomNavigationNotifierProvider =
    StateNotifierProvider<BottomNavigationNotifier, BottomNavigationState>((
      ref,
    ) {
      return BottomNavigationNotifier();
    });

final bottomNavigationStateProvider = Provider<BottomNavigationState>((ref) {
  return ref.watch(bottomNavigationNotifierProvider);
});

final currentIndexProvider = Provider<int>((ref) {
  return ref.watch(bottomNavigationStateProvider).currentIndex;
});

final bottomNavigationIndexProvider = Provider<List<Widget>>((ref) {
  return ref.watch(bottomNavigationStateProvider).bottomNavigationIndex;
});

final bottomNavigationIndexNameProvider = Provider<List<String>>((ref) {
  return ref.watch(bottomNavigationStateProvider).bottomNavigationIndexNameList;
});
