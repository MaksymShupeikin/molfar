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
    final vehicle = searchState.asData?.value;
    final bool isLoading = searchState.isLoading;

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
                          const MolfarLogo(size: 100),
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

  @override
  void dispose() {
    _plateController.dispose();
    _vinController.dispose();
    super.dispose();
  }
}
