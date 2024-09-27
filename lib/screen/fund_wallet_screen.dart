import 'package:coraapp/controllers/uiControllers/MainScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class FundWalletScreen extends StatefulWidget {
  FundWalletScreen({Key? key}) : super(key: key);

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _addFundController = TextEditingController();
  late APIController apiController;
  var readOnlyFields = true.obs;
  String actionCard = "Edit Card";

  late MainScreenController mainScreenController;

  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeFundWalletScreen);

    mainScreenController = Get.find<MainScreenController>();

    _cardNumberController.text =
        mainScreenController.userModel.value.card_number;
    _expiryDateController.text =
        mainScreenController.userModel.value.card_expiry;
    _cvcController.text = mainScreenController.userModel.value.card_cvc;

    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status ?? true)) {
        if (baseModel.code == 'ADD_WALLET') {
          var apiController =
              Get.find<APIController>(tag: NamedRoutes.routeHomeScreen);
          apiController.webservice.apiCallFetchProfile({}, RxBool(false)).then(
              (value) => apiController.baseModel.value = value);
          Get.offAllNamed(NamedRoutes.routeHomeScreen);
        } else if (baseModel.code == 'SAVE_CARD') {
          var apiController =
              Get.find<APIController>(tag: NamedRoutes.routeHomeScreen);
          apiController.webservice.apiCallFetchProfile({}, RxBool(false)).then(
              (value) => apiController.baseModel.value = value);
        } else if (baseModel.code == 'PAY_WITH_PAYSTACK') {
          Get.toNamed(NamedRoutes.routeMyWebview,
                  arguments: baseModel.data['authorization_url'])
              ?.then((value) {
            if (isNotEmpty(value)) {
              if ((value as Map)['success']) {
                apiController.webservice.apiCallFundWallet({
                  'amount': _addFundController.text,
                }, apiController.isLoading).then(
                    (value) => apiController.baseModel.value = value);
              }
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // FocusScopeNode currentFocus = FocusScope.of(context);

    return GestureDetector(
      onTap: () {
        // _customFormHelper.checkfocus(context, currentFocus);
      },
      child: MyScaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: bizAppBarDecorationBox(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                verticalSpace(height: 8),
                SafeArea(
                  child: MySecondAppBar(
                    appbarLogo: ic_backIcon,
                    appbarText: 'Fund Wallet',
                    fontStyle: FontStyle.normal,
                    onPress: () {},
                  ),
                ),
                verticalSpace(height: 12),
              ],
            ),
          ),
        ),
        backgroundColor: whiteContainerColor,
        body: getBody(size, context),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  getBody(Size size, BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: MyCustomScrollBar(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(height: 24),
                      Center(
                        child: Container(
                          height: 104,
                          width: 280,
                          decoration:
                              userImageRectangularAppBarBoxDecorationWithRadiusElevation(
                                  16, backGroundImage, 4,
                                  color: whiteContainerColor,
                                  shadowColor: Colors.black12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              verticalSpace(height: 10),
                              Text(
                                "Your Balance",
                                style: regularWhiteText14(lightGreyColor),
                              ),
                              verticalSpace(height: 2),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/ic_naira_symbol.png',
                                    height: 24,
                                  ),
                                  Text(
                                    "${mainScreenController.userModel.value.wallet}",
                                    style: boldWhiteText28(Colors.black),
                                  ),
                                ],
                              ),
                              verticalSpace(height: 10),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(height: 24),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: darkGreyColor,
                        ),
                        // decoration:bixRectangularAppBarBoxDecorationWithRadiusElevation(16, 0,
                        //     color: darkGreyColor,
                        //     shadowColor: fieldColor2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Fund",
                              style: regularWhiteText16(Colors.black),
                            ),
                            verticalSpace(height: 6),
                            SizedBox(
                              width: Get.width,
                              child: OnBoardingTextFieldWidget(
                                controller: _addFundController,
                                keyboard: TextInputType.number,
                                passwordVisible: false,
                                hintText: 'Add fund',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(),
                      // Container(
                      //   width: Get.width,
                      //   decoration: BoxDecoration(
                      //       color: darkGreyColor,
                      //       borderRadius: BorderRadius.circular(16)),
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      //   child: Obx(() {
                      //     return Column(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Container(
                      //               height: 44,
                      //               width: 44,
                      //               alignment: Alignment.center,
                      //               decoration: BoxDecoration(
                      //                   color: whiteContainerColor,
                      //                   borderRadius:
                      //                       BorderRadius.circular(12)),
                      //               padding: EdgeInsets.symmetric(
                      //                   horizontal: 10, vertical: 10),
                      //               child: Image.asset(
                      //                 ic_addCardImage,
                      //               ),
                      //             ),
                      //             horizontalSpace(),
                      //             Text(
                      //               "Add New Card",
                      //               style: regularWhiteText16(Colors.black),
                      //             ),
                      //             Expanded(child: Container()),
                      //             GestureDetector(
                      //               onTap: () {
                      //                 readOnlyFields.value =
                      //                     !(readOnlyFields.value);
                      //                 if (readOnlyFields.value) {
                      //                   actionCard = "Edit Card";
                      //                   // if (validateFields()) {
                      //                     saveCard();
                      //                   // }
                      //                 } else {
                      //                   actionCard = "Save Card";
                      //                 }
                      //               },
                      //               child: Container(
                      //                 alignment: Alignment.center,
                      //                 decoration: BoxDecoration(
                      //                     color: darkBlackColor,
                      //                     borderRadius:
                      //                         BorderRadius.circular(12)),
                      //                 padding: EdgeInsets.symmetric(
                      //                     horizontal: 12, vertical: 12),
                      //                 child: Text(
                      //                   actionCard,
                      //                   style: regularWhiteText16(Colors.white,
                      //                       fontWeight: FontWeight.w500),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         verticalSpace(height: 16),
                      //         Visibility(
                      //           visible: true,
                      //           child: Column(
                      //             children: [
                      //               SizedBox(
                      //                 width: Get.width,
                      //                 child: OnBoardingTextFieldWidget(
                      //                   controller: _cardNumberController,
                      //                   readOnly: readOnlyFields.value,
                      //                   keyboard: TextInputType.number,
                      //                   maxLength: 20,
                      //                   passwordVisible: false,
                      //                   hintText: 'Card number',
                      //                 ),
                      //               ),
                      //               verticalSpace(),
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: SizedBox(
                      //                       width: Get.width,
                      //                       child: OnBoardingTextFieldWidget(
                      //                         controller: _expiryDateController,
                      //                         readOnly: readOnlyFields.value,
                      //                         keyboard: TextInputType.datetime,
                      //                         maxLength: 5,
                      //                         passwordVisible: false,
                      //                         hintText: ' Expiry Date',
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   horizontalSpace(width: 6),
                      //                   Expanded(
                      //                     child: SizedBox(
                      //                       width: Get.width,
                      //                       child: OnBoardingTextFieldWidget(
                      //                         controller: _cvcController,
                      //                         readOnly: readOnlyFields.value,
                      //                         keyboard: TextInputType.number,
                      //                         maxLength: 3,
                      //                         passwordVisible: false,
                      //                         hintText: ' CVC',
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               verticalSpace(height: 16),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   }),
                      // ),
                      verticalSpace(height: 20),
                      GestureDetector(
                        onTap: () {
                          fundWallet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: blueAppColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: CustomizedButton(
                            buttonHeight: 48,
                            buttonWidth: Get.width,
                            text: 'Add Fund',
                            textStyle: boldWhiteText16(whiteContainerColor),
                          ),
                        ),
                      ),
                      verticalSpace(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        GenericProgressBar(tag: NamedRoutes.routeFundWalletScreen)
      ],
    );
  }

  bool validateFields() {
    if (isEmpty(_cardNumberController.text)) {
      showSnackBar('Please fill card number', context);
    } else if (isEmpty(_expiryDateController.text)) {
      showSnackBar('Please fill expiry date', context);
    } else if (isEmpty(_cvcController.text)) {
      showSnackBar('Please fill cvc number', context);
    } else {
      return true;
    }

    return false;
  }

  void fundWallet() {
    // if(validateFields()){}
    if (isNotEmpty(_addFundController.text)) {
      apiController.webservice.apiCallInitializePaystack({
        'amount': _addFundController.text,
        'email': mainScreenController.userModel.value.email,
      }, apiController.isLoading).then(
          (value) => apiController.baseModel.value = value);
    } else {
      showSnackBar('Please add funds', context);
    }
  }

  void saveCard() {
    apiController.webservice.apiCallSaveCard({
      'card_number': _cardNumberController.text,
      'card_expiry': _expiryDateController.text,
      'card_cvc': _cvcController.text,
    }, apiController.isLoading).then(
        (value) => apiController.baseModel.value = value);
  }
}
