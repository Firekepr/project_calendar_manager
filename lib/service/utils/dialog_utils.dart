import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/widget/buttons/simple_text_button.dart';
import 'package:project_calendar_manager/widget/page_header/page_header.dart';
import 'package:project_calendar_manager/widget/simple.dart';

class DialogUtils {

  static Future<dynamic> showNewConfirmDialog({
    required BuildContext context,
    required String header,
    Widget? body,
    double buttonWidth = 0.33,
    String cancelButtonLabel = 'Cancelar',
    String confirmButtonLabel = 'Confirmar',
    String message = '',
    bool barrierDismissible = true,
    bool showButtons = true,
    bool popFalse = false,
    bool hideClose = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return PopScope(
          canPop: barrierDismissible,
          child: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PageHeader(
                  hideBack: hideClose,
                  goBack: () => Navigator.pop(context, popFalse ? false : null),
                  title: header,
                  titleColor: AppColors.black,
                  iconColor: AppColors.black,
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      SimpleWidget.customText(
                        hide: message.isEmpty,
                        text: message,
                        centerText: true,
                        alternativeText: "'body' or 'message' must be required",
                        padding: const EdgeInsets.only(bottom: 12.0)
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SimpleTextButton(
                            elevation: 3.0,
                            hidden: !showButtons,
                            width: buttonWidth,
                            label: cancelButtonLabel,
                            bgColor: AppColors.red,
                            bdColor: AppColors.redDark,
                            borderWidth: 1,
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          const SizedBox(width: 24),
                          SimpleTextButton(
                            elevation: 3.0,
                            hidden: !showButtons,
                            width: buttonWidth,
                            label: confirmButtonLabel,
                            centered: true,
                            bgColor: AppColors.graphite,
                            bdColor: AppColors.black,
                            borderWidth: 1,
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}