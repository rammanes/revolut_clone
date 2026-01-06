import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../styles/app_colors.dart';

class OtpInput extends StatelessWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const OtpInput({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return _OtpInputStateful(
      length: length,
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
  }
}

class _OtpInputStateful extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const _OtpInputStateful({
    required this.length,
    this.onChanged,
    this.onCompleted,
  });

  @override
  State<_OtpInputStateful> createState() => _OtpInputStatefulState();
}

class _OtpInputStatefulState extends State<_OtpInputStateful> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste
      for (int i = 0; i < widget.length && i < value.length; i++) {
        _controllers[i].text = value[i];
      }
      if (value.length >= widget.length) {
        _focusNodes[widget.length - 1].unfocus();
        widget.onCompleted?.call(value.substring(0, widget.length));
      } else {
        _focusNodes[value.length].requestFocus();
      }
    } else if (value.isNotEmpty) {
      // Move to next field
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }

    // Get current code
    final code = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(code);

    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available width and adjust field size
        final availableWidth = constraints.maxWidth;
        final fieldWidth = ((availableWidth - 48) / widget.length).clamp(
          40.0,
          48.0,
        );
        final fieldMargin = 2.0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            final isMiddle = index == widget.length ~/ 2;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isMiddle) ...[
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 1,
                    color: AppColors.white.withOpacity(0.3),
                  ),
                  const SizedBox(width: 4),
                ],
                Container(
                  width: fieldWidth,
                  height: 56,
                  margin: EdgeInsets.symmetric(horizontal: fieldMargin),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey.shade800.withOpacity(0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.accentBlue,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) => _onChanged(index, value),
                    onTap: () {
                      _controllers[index]
                          .selection = TextSelection.fromPosition(
                        TextPosition(offset: _controllers[index].text.length),
                      );
                    },
                    onSubmitted: (_) {
                      if (index < widget.length - 1) {
                        _focusNodes[index + 1].requestFocus();
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
