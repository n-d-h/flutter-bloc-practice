import 'package:flutter/material.dart';

class TextFieldWithValidator extends StatefulWidget {
  final String hintText;
  final bool isSecured;
  final Color borderColor;
  final String? validator;
  final String? Function(String?)? onValidator;
  final Function(String)? onChange;
  final IconData? iconLeft;
  final TextInputAction? textInputAction;

  const TextFieldWithValidator({
    super.key,
    this.isSecured = false,
    this.hintText = '',
    this.borderColor = Colors.white,
    this.iconLeft,
    this.validator,
    this.onValidator,
    this.onChange, this.textInputAction,
  });

  @override
  State<TextFieldWithValidator> createState() => _TextFieldWithValidatorState();
}

class _TextFieldWithValidatorState extends State<TextFieldWithValidator> {
  final controller = TextEditingController();
  bool isShown = false;

  // String msg = '';
  bool checkValidator = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    checkValidator = (widget.validator != null && widget.validator!.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          width: size.width,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(40),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.grey.withOpacity(0.5),
                Colors.grey.withOpacity(0.8),
              ],
            ),
            shadows: const [
              BoxShadow(
                color: Colors.transparent,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(14),
          //   boxShadow: const [
          //     BoxShadow(
          //       color: Colors.grey,
          //       spreadRadius: 1,
          //       blurRadius: 5,
          //       offset: Offset(0, 0),
          //     ),
          //   ],
          // ),
          child: TextFormField(
            focusNode: focusNode,
            onChanged: (value) => widget.onChange?.call(value),
            // readOnly: readOnly,
            controller: controller,
            textInputAction: widget.textInputAction,
            keyboardType: widget.isSecured
                ? TextInputType.text
                : TextInputType.visiblePassword,
            obscureText: widget.isSecured ? !isShown : false,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            onTapOutside: (details) {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
            decoration: InputDecoration(
              // filled: true,
              // fillColor: Colors.white,
              hintText: widget.hintText,
              hintFadeDuration: const Duration(milliseconds: 100),
              errorStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(14),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
              hintStyle: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              // focusColor: widget.borderColor,
              isDense: true,
              alignLabelWithHint: true,
              prefixIcon: widget.iconLeft != null
                  ? Container(
                      width: 24,
                      height: 24,
                      margin: widget.iconLeft != null
                          ? const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 22)
                          : null,
                      child: Icon(
                        widget.iconLeft,
                        color: Colors.black,
                        size: 24,
                      ),
                    )
                  : null,
              suffixIcon: widget.isSecured
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isShown = !isShown;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.only(
                            right: 22, top: 10, bottom: 10),
                        child: Icon(
                          isShown
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black54,
                          size: 24,
                        ),
                      ),
                    )
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (widget.onValidator != null) {
                return widget.onValidator?.call(value);
              }
              if (checkValidator && (value == null || value.isEmpty)) {
                return widget.validator;
              }
              return null;
            },
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(
        //     left: size.width * 0.039,
        //     right: size.width * 0.039,
        //     top: 4,
        //   ),
        //   child: Text(
        //     msg,
        //     style: const TextStyle(
        //       color: Colors.red,
        //       fontSize: 14,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
