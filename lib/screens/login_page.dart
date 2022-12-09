import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/models/user_details.dart';
import 'package:login/providers/userdataProvider.dart';
import 'package:login/screens/home_page.dart';
import 'package:login/util/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String name = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            title: Text("Login Page"),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            toolbarHeight: 60,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                prefixIcon: const Icon(FeatherIcons.user),
                keyboardType: TextInputType.name,
                label: "Name",
                validator: TextFieldValidator.name,
                onChanged: (value) {
                  name = value;
                  print(name);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                prefixIcon: const Icon(FeatherIcons.mail),
                keyboardType: TextInputType.emailAddress,
                label: "Email",
                validator: TextFieldValidator.email,
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: Consumer(builder: (context, WidgetRef ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(userDetailsProvider.notifier).updateEmail(email);
                      ref.read(userDetailsProvider.notifier).updateName(name);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text("Login"),
                );
              }),
            ),
          )
        ],
      ),
    ));
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    required this.keyboardType,
    this.prefixIcon,
    required this.label,
    this.hintText,
    this.validator,
  });
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String?>? onSaved;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final String? hintText;
  final String label;
  final String? Function(String?)? validator;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: textEditingController,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        label: Text(widget.label),
        counter: const SizedBox.shrink(),
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                textEditingController.clear();
              },
              child: const Icon(FeatherIcons.xCircle),
            )
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            width: 2.0,
          ),
        ),
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
