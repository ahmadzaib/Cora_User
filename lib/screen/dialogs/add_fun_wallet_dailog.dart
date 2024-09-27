import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../../utils/widgets.dart';

class AddFundWalletDialog extends StatelessWidget {
  const AddFundWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            verticalSpace(height: 16),
            SizedBox(
              width: Get.width,
              child: OnBoardingTextFieldWidget(
                keyboard: TextInputType.text,
                passwordVisible: false,
                hintText: ' Input',
              ),
            ),
            verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: Get.width,
                    child: OnBoardingTextFieldWidget(
                      keyboard: TextInputType.text,
                      passwordVisible: false,
                      hintText: ' Input',
                    ),
                  ),
                ),
                horizontalSpace(width: 6),
                Expanded(
                  child: SizedBox(
                    width: Get.width,
                    child: OnBoardingTextFieldWidget(
                      keyboard: TextInputType.text,
                      passwordVisible: false,
                      hintText: ' Input',
                    ),
                  ),
                ),

              ],
            ),
            verticalSpace(height: 16),
          ],
        ),
      ),
    );
  }
}
