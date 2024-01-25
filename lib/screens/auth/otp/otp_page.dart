import 'package:auto_route/annotations.dart';
import 'package:chat_demo/core/routes/app_router.dart';
import 'package:chat_demo/screens/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class OtpPage extends ConsumerWidget {
  final String verificationId, phoneNo;

  OtpPage({super.key, required this.verificationId, required this.phoneNo});

  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color:Colors.grey.shade500,
              offset: const Offset(0, 2),
              spreadRadius: 0.1,
              blurRadius: 0.2),
          BoxShadow(
            color:Colors.grey.shade200,
            offset: const Offset(0, -2),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Number ', style: TextStyle()),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(10),
            const Text(
              'we have sent an SMS with a code',
              style: TextStyle(fontSize: 16),
            ),
            const Gap(5),
            Text(
              'on $phoneNo ',
              style: const TextStyle(fontSize: 13),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  length: 6,
                  controller: otpController,
                  pinAnimationType: PinAnimationType.fade,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  defaultPinTheme: defaultPinTheme,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onCompleted: (value) {

                    print(value);
                    if(value.length == 6){

                      appRouter.replaceAll([const ProfileRoute()]);
                      //verifyOtp(ref, context, value.trim());

                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void verifyOtp(WidgetRef ref, BuildContext context, String otp) {
    ref.read(authController).verifyOtp(context, verificationId, otp);
  }
}
