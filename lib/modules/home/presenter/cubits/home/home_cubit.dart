import 'package:rick_and_morty/app_imports.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ICharacterRepository _characterRepository;

  HomeCubit(this._characterRepository) : super(HomeInitial()) {
    _state = PagingState<int, CharacterEntity>();
    fetchNextPage();
  }

  late PagingState<int, CharacterEntity> _state;
  String _searchQuery = '';

  PagingState<int, CharacterEntity> get pagingState => _state;
  String get searchQuery => _searchQuery;

  GenderEnum? selectedGender;
  SpeciesEnum? selectedSpecies;
  StatusEnum? selectedStatus;

  Future<void> fetchNextPage() async {
    if (_state.isLoading || !_state.hasNextPage) return;

    emit(HomeLoading());

    try {
      final nextPage = (_state.keys?.last ?? 0) + 1;

      _state = _state.copyWith(isLoading: true, error: null);
      emit(HomeLoaded(_state));

      final newItems = await _characterRepository.getCharactersList(
        page: nextPage,
        searchQuery: _searchQuery.isNotEmpty ? _searchQuery : null,
        gender: selectedGender,
        specie: selectedSpecies,
        status: selectedStatus,
      );

      final isLastPage = newItems.length < 20;

      _state = _state.copyWith(
        pages: [...?_state.pages, newItems],
        keys: [...?_state.keys, nextPage],
        hasNextPage: !isLastPage,
        isLoading: false,
      );

      emit(
        HomeLoaded(
          _state,
          gender: selectedGender,
          specie: selectedSpecies,
          status: selectedStatus,
        ),
      );
    } catch (e) {
      _state = _state.copyWith(error: e, isLoading: false);
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refresh() async {
    _state = PagingState<int, CharacterEntity>();
    emit(HomeInitial());
    await fetchNextPage();
  }

  Future<void> search(String query) async {
    _searchQuery = query.trim();
    _state = PagingState<int, CharacterEntity>();
    emit(HomeInitial());
    await fetchNextPage();
  }

  Future<void> clearFilters() async {
    _searchQuery = '';

    selectedGender = null;
    selectedSpecies = null;
    selectedStatus = null;

    _state = PagingState<int, CharacterEntity>();
    emit(HomeInitial());
    await fetchNextPage();
  }

  Future<void> filterCharacters({
    GenderEnum? gender,
    SpeciesEnum? specie,
    StatusEnum? status,
  }) async {
    selectedGender = gender;
    selectedSpecies = specie;
    selectedStatus = status;

    _state = PagingState<int, CharacterEntity>();
    emit(HomeInitial());

    await fetchNextPage();
  }

  Future<void> clearSearch() async {
    if (_searchQuery.isEmpty) return;

    _searchQuery = '';
    await refresh();
  }
}
