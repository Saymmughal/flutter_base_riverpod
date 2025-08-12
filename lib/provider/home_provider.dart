import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class for home
class HomeState {
  // Add your home state properties here
  const HomeState();
}

// Home StateNotifier
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  // Add your home methods here
}

// Providers
final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((
  ref,
) {
  return HomeNotifier();
});

final homeStateProvider = Provider<HomeState>((ref) {
  return ref.watch(homeNotifierProvider);
});
