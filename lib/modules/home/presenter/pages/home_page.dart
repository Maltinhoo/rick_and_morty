import 'package:rick_and_morty/app_imports.dart';

class HomePage extends StatefulWidget {
  static const name = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.locator<HomeCubit>(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            CustomToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();

          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await homeCubit.refresh();
                },
                child: CustomScrollView(
                  slivers: [
                    if (state is! HomeError)
                      SliverAppBar(
                        floating: true,
                        expandedHeight: 80,

                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    hint: 'Pesquisar...',
                                    prefixIcon: Icon(Icons.search),
                                    useDebounce: true,
                                    onChanged: (value) {
                                      homeCubit.search(value);
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final result = await context
                                        .push<Map<String, dynamic>>(
                                          FiltersPage.name,
                                          extra: {
                                            'selectedGender': state.gender,
                                            'selectedSpecies': state.specie,
                                            'selectedStatus': state.status,
                                          },
                                        );

                                    if (result != null) {
                                      final gender =
                                          result['gender'] as GenderEnum?;
                                      final species =
                                          result['species'] as SpeciesEnum?;
                                      final status =
                                          result['status'] as StatusEnum?;

                                      homeCubit.filterCharacters(
                                        gender: gender,
                                        specie: species,
                                        status: status,
                                      );
                                    }
                                  },
                                  icon: Vector(Vectors.filter),
                                ),
                              ],
                            ),
                          ),
                        ),
                        toolbarHeight: 80,
                        collapsedHeight: 80,
                      ),

                    if (state is HomeLoaded)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: PagedSliverList<int, CharacterEntity>.separated(
                          state: state.pagingState,
                          fetchNextPage: homeCubit.fetchNextPage,
                          builderDelegate:
                              PagedChildBuilderDelegate<CharacterEntity>(
                                itemBuilder: (context, char, index) {
                                  return CharacterCard(
                                    char: char,
                                    onTap: (p0) {
                                      context.push(
                                        CharacterPage.name,
                                        extra: {'char': char},
                                      );
                                    },
                                  );
                                },
                              ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(20);
                          },
                        ),
                      ),

                    if (state is HomeError)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Ocorreu um erro:\n${state.message}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  onPressed: homeCubit.clearFilters,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Tentar novamente'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
