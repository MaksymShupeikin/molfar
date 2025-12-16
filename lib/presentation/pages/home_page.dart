import 'package:molfar/core/imports.dart';
import 'package:molfar/presentation/widgets/custom_button.dart';
import 'package:molfar/presentation/widgets/input/plate_input.dart';
import 'package:molfar/presentation/widgets/custom_toggle.dart';
import 'package:molfar/presentation/widgets/input/vin_input.dart';
import 'package:molfar/presentation/widgets/molfar_logo.dart';
import 'package:molfar/presentation/widgets/vehicle_info_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  SearchMode _currentMode = SearchMode.plate;
  final TextEditingController _plateController =
      TextEditingController();
  final TextEditingController _vinController =
      TextEditingController();

  void _performSearch() {
    FocusScope.of(context).unfocus();

    final query = _currentMode == SearchMode.plate
        ? _plateController.text
        : _vinController.text;

    ref.read(searchProvider.notifier).search(query, _currentMode);
  }

  void _clearSearch() {
    ref.read(searchProvider.notifier).clear();
    _plateController.clear();
    _vinController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final vehicle = searchState.currentVehicle;
    final bool isLoading = searchState.isLoading;

    ref.listen(searchProvider, (previous, next) {
      if (!next.isLoading && next.errorMessage != null) {
        _showErrorSnackBar(next.errorMessage!);
      }

      if (previous?.isLoading == true &&
          !next.isLoading &&
          next.currentVehicle == null &&
          next.errorMessage == null) {
        _showErrorSnackBar('Транспортний засіб не знайдено');
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              transitionBuilder:
                  (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.center,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
              child: vehicle != null
                  ? VehicleInfoCard(
                      vehicle: vehicle,
                      onReset: _clearSearch,
                    )
                  : SingleChildScrollView(
                      key: const ValueKey('SearchForm'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MolfarLogo(size: 40),
                          const SizedBox(height: 75),
                          CustomToggle(
                            currentMode: _currentMode,
                            onModeChanged: (newMode) {
                              setState(() {
                                _currentMode = newMode;
                              });
                            },
                          ),
                          const SizedBox(height: 25),
                          if (_currentMode == SearchMode.plate) ...[
                            PlateInput(controller: _plateController),
                          ] else ...[
                            VinInput(controller: _vinController),
                          ],
                          const SizedBox(height: 25),
                          CustomButton(
                            text: isLoading ? 'ПОШУК...' : 'ШУКАТИ',
                            isLoading: isLoading,
                            onTap: isLoading ? null : _performSearch,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0505).withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.redAccent.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _plateController.dispose();
    _vinController.dispose();
    super.dispose();
  }
}
