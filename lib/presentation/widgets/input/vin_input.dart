import 'package:molfar/core/imports.dart';
import 'package:molfar/core/utils/vin_formater.dart';

class VinInput extends StatefulWidget {
  final TextEditingController controller;

  const VinInput({super.key, required this.controller});

  @override
  State<VinInput> createState() => _VinInputState();
}

class _VinInputState extends State<VinInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CyberInputShell(
      focusNode: _focusNode,
      height: 90.0,
      child: Center(
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          inputFormatters: [VinInputFormatter()],
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          textAlign: TextAlign.center,
          cursorColor: AppPalette.primaryYellow,
          cursorWidth: 3.0,
          cursorRadius: const Radius.circular(2.0),
          style: CyberInputStyle.mainStyle(
            isFocused: _isFocused,
            fontSize: 22,
            letterSpacing: 1.5,
          ),

          decoration: CyberInputStyle.decoration(
            hintText: 'WBA00000000000000',
            hintStyle: CyberInputStyle.hintStyle(
              isFocused: _isFocused,
              fontSize: 22,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
