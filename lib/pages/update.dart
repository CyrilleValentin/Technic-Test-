import 'package:flutter/material.dart';
import 'package:test_app/widgets/input.dart';

class Update extends StatefulWidget {
  final dynamic data;

  const Update({Key? key, required this.data}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _gender;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _streetNumber;
  late TextEditingController _city;
  late TextEditingController _country;
  late TextEditingController _email;
  late TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    _gender = TextEditingController(text: widget.data['gender']);
    _lastName = TextEditingController(text: widget.data['lastName']);
    _firstName = TextEditingController(text: widget.data['firstName']);
    _streetNumber = TextEditingController(text: widget.data['streetNumber']);
    _city = TextEditingController(text: widget.data['city']);
    _country = TextEditingController(text: widget.data['country']);
    _email = TextEditingController(text: widget.data['email']);
    _phone = TextEditingController(text: widget.data['phone']);
  }

  @override
  void dispose() {
    _gender.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _streetNumber.dispose();
    _city.dispose();
    _country.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${widget.data['pictureThumbnail']}'),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 240, // Adjust the height as needed
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      myInput(
                        controller: _lastName,
                        prefixText: 'LastName: ',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myInput(
                        controller: _firstName,
                        prefixText: 'FirstName: ',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myInput(controller: _gender, prefixText: "Gender: "),
                      const SizedBox(
                        height: 10,
                      ),
                      myInput(
                        controller: _email,
                        prefixText: "Email: ",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myInput(controller: _city, prefixText: "City: "),
                      const SizedBox(
                        height: 10,
                      ),
                      myInput(controller: _country, prefixText: "Country: "),
                      const SizedBox(
                        height: 10,
                      ),
                      myInput(controller: _phone, prefixText: "Phone: ", keyboardType: TextInputType.phone),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () {
                            // navigatorDelete(context, const ScanPage());
                          },
                          child: const Text('Update'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
