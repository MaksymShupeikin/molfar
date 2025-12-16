import 'package:molfar/core/imports.dart';
import 'package:molfar/core/utils/plate_formater.dart';

class PlateInput extends StatefulWidget {
  final TextEditingController controller;

  const PlateInput({super.key, required this.controller});

  @override
  State<PlateInput> createState() => _PlateInputState();
}

class _PlateInputState extends State<PlateInput> {
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
          inputFormatters: [PlateInputFormatter()],
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          textAlign: TextAlign.center,
          cursorColor: AppPalette.primaryYellow,
          cursorWidth: 3.0,
          cursorRadius: const Radius.circular(2.0),
      
          style: CyberInputStyle.mainStyle(
            isFocused: _isFocused,
            fontSize: 26,
            letterSpacing: 3.0,
          ),
      
          decoration: CyberInputStyle.decoration(
            hintText: 'AA 0000 AA',
            hintStyle: CyberInputStyle.hintStyle(
              isFocused: _isFocused,
              fontSize: 26,
              letterSpacing: 4.0,
            ),
          ),
        ),
      ),
    );
  }
}
