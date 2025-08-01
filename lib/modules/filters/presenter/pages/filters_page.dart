import 'package:rick_and_morty/app_imports.dart';

class FiltersPage extends StatefulWidget {
  static const String name = "/filters";

  final GenderEnum? selectedGender;
  final SpeciesEnum? selectedSpecies;
  final StatusEnum? selectedStatus;

  const FiltersPage({
    super.key,
    this.selectedGender,
    this.selectedSpecies,
    this.selectedStatus,
  });

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  GenderEnum? _selectedGender;
  SpeciesEnum? _selectedSpecies;
  StatusEnum? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.selectedGender;
    _selectedSpecies = widget.selectedSpecies;
    _selectedStatus = widget.selectedStatus;
  }

  void _clearFilters() {
    setState(() {
      _selectedGender = null;
      _selectedSpecies = null;
      _selectedStatus = null;
    });
    _applyFilters();
  }

  void _applyFilters() {
    context.pop({
      'gender': _selectedGender,
      'species': _selectedSpecies,
      'status': _selectedStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => context.pop(),
                child: const Vector(
                  Vectors.close_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            CustomText(
              'Filtros',
              color: AppColors.white,
              size: 24,
              fontWeight: FontWeight.w800,
            ),
            const Divider(height: 40),

            CustomText(
              'Gêneros',
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            const Gap(20),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: GenderEnum.values.length,
                separatorBuilder: (_, __) => const Gap(10),
                itemBuilder: (_, index) {
                  final gender = GenderEnum.values[index];
                  return FilterPillButton(
                    onTap: () {
                      setState(() {
                        _selectedGender = _selectedGender == gender
                            ? null
                            : gender;
                      });
                    },
                    isSelected: _selectedGender == gender,
                    label: gender.name,
                  );
                },
              ),
            ),
            const Gap(20),

            CustomText(
              'Espécies',
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            const Gap(20),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: SpeciesEnum.values.length,
                separatorBuilder: (_, __) => const Gap(10),
                itemBuilder: (_, index) {
                  final specie = SpeciesEnum.values[index];
                  return FilterPillButton(
                    onTap: () {
                      setState(() {
                        _selectedSpecies = _selectedSpecies == specie
                            ? null
                            : specie;
                      });
                    },
                    isSelected: _selectedSpecies == specie,
                    label: specie.specie,
                  );
                },
              ),
            ),
            const Gap(20),

            CustomText(
              'Status',
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            const Gap(20),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: StatusEnum.values.length,
                separatorBuilder: (_, __) => const Gap(10),
                itemBuilder: (_, index) {
                  final status = StatusEnum.values[index];
                  return FilterPillButton(
                    onTap: () {
                      setState(() {
                        _selectedStatus = _selectedStatus == status
                            ? null
                            : status;
                      });
                    },
                    isSelected: _selectedStatus == status,
                    label: status.name,
                  );
                },
              ),
            ),
            const Gap(30),

            CustomButton(
              label: 'Aplicar Filtros',
              width: MediaQuery.of(context).size.width,
              onTap: _applyFilters,
            ),
            const Gap(20),

            CustomButton(
              label: 'Limpar',
              width: MediaQuery.of(context).size.width,
              outlined: true,
              onTap: _clearFilters,
              textStyle: TextStyle(
                fontFamily: FontFamily.openSans.family,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              borderColor: AppColors.darkAtlantis,
            ),
          ],
        ),
      ),
    );
  }
}
