import 'package:flutter/material.dart';
import 'package:souglink/login_signup/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode _userfirstnameFocusNode = FocusNode();
  final FocusNode _userlastnameFocusNode = FocusNode();
  final FocusNode _useremailFocusNode = FocusNode();
  final FocusNode _passwordconfirmFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  Color _userfirstnameFillColor = const Color.fromARGB(107, 255, 255, 255);
  Color _userlastnameFillColor = const Color.fromARGB(107, 255, 255, 255);
  Color _useremailFillColor = const Color.fromARGB(107, 255, 255, 255);
  Color _passwordFillColor = const Color.fromARGB(107, 255, 255, 255);
  Color _passwordconfirmFillColor = const Color.fromARGB(107, 255, 255, 255);
  DateTime? selectedDate;
  final List<String> userTypes = ['تاجر سوق', ' مزارع'];
  String? selectedUserType;
  bool _isVisibile = false;
  @override
  void initState() {
    super.initState();
    _userfirstnameFocusNode.addListener(() {
      setState(() {
        _userfirstnameFillColor = _userfirstnameFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });
    _userlastnameFocusNode.addListener(() {
      setState(() {
        _userlastnameFillColor = _userlastnameFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });
    _useremailFocusNode.addListener(() {
      setState(() {
        _useremailFillColor = _useremailFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordFillColor = _passwordFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });
    _passwordconfirmFocusNode.addListener(() {
      setState(() {
        _passwordconfirmFillColor = _passwordconfirmFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisibile = true;
      });
    });
  }

  void dispose() {
    _userfirstnameFocusNode.dispose();
    _userlastnameFocusNode.dispose();
    _useremailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordconfirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 66, 4),
      body: Stack(
        children: [
          // Background Image
          Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroundlogin.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Login container at the bottom right
          AnimatedPositioned(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOut,
          top: _isVisibile ? 0 : -750,
          left:  _isVisibile ? 0 : -357,
            child: Padding(
              padding: const EdgeInsets.all(0.0), // Padding from the right and bottom
              child: Stack(
                children:[ Container(
                  width: 357, // Set a fixed width for your content container
                  height: 750,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 12, 66, 4),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(71)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                alignment: Alignment(-1, -1),// Adjust as needed
                child: Container(
                  height: 30,
                  width: 50,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 25,),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_page()));
                    },
                  ),
                ),
              ),
                      // Welcome Text
                      Text(
                        'التسجيل',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Username/Email Input
                      Container(
                        height: 50,
                        width: 310,
                        child: TextField(
                          style: TextStyle(color: Color(0xFFBBB9B9)),
                          focusNode: _userfirstnameFocusNode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            hintText: 'الاسم الأول',
                            hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                            filled: true,
                            fillColor: _userfirstnameFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Last name Input
                      Container(
                        height: 50,
                        width: 310,
                        child: TextField(
                          style: TextStyle(color: Color(0xFFBBB9B9)),
                          focusNode: _userlastnameFocusNode,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            hintText: 'اسم العائلة',
                            hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                            filled: true,
                            fillColor: _userlastnameFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Email or phone Input
                      Container(
                        height: 50,
                        width: 310,
                        child: TextField(
                          style: TextStyle(color: Color(0xFFBBB9B9)),
                          focusNode: _useremailFocusNode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            hintText: 'البريد الإلكتروني، أو رقم الهاتف',
                            hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                            filled: true,
                            fillColor: _useremailFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Date of Birth Container
                      Container(
                        height: 50,
                        width: 310,
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime(1940),
                              lastDate: DateTime.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: Color.fromARGB(255, 71, 118, 0),
                                    hintColor: Color.fromARGB(255, 71, 118, 0),
                                    colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 71, 118, 0)),
                                  ),
                                  child: child ?? SizedBox(),
                                );
                              },
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                hintText: selectedDate != null
                                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                    : 'تاريخ الميلاد',
                                hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.arrow_drop_down, color: Color(0xFFBBB9B9)),
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(107, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 310,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(107, 255, 255, 255),
                        ),
                        child: DropdownButton<String>(
                          
                          value: selectedUserType,
                          isExpanded: true,
                          dropdownColor: Color.fromARGB(255, 228, 243, 226),
                          hint: Text(
                            'اختار نوع المستخدم',
                            style: TextStyle(color: Color(0xFFBBB9B9)),
                          ),
                          style: TextStyle(color: selectedUserType == null ? Color(0xFFBBB9B9) : Colors.black),
                          icon: Icon(Icons.arrow_drop_down, color: Color(0xFFBBB9B9)),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedUserType = newValue;
                            });
                          },
                            selectedItemBuilder: (BuildContext context){
                              return userTypes.map<Widget> ((String item){
                                return Align(
                                  alignment: Alignment(1,0),
                                  child: Text(
                                    item,
                                    style: TextStyle(color: selectedUserType == item ? Color(0xFFBBB9B9): Colors.black),
                                  ),
                                );
                              }).toList();
                          },
                          items: userTypes.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.black),),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20,),
                      // Password Input
                      Container(
                        height: 50,
                        width: 310,
                        child: TextField(
                          style: TextStyle(color: Color(0xFFBBB9B9)),
                          focusNode: _passwordFocusNode,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            hintText: 'كلمة المرور',
                            hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                            filled: true,
                            fillColor: _passwordFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Confirm Password Input
                      Container(
                        height: 50,
                        width: 310,
                        child: TextField(
                          style: TextStyle(color: Color(0xFFBBB9B9)),
                          focusNode: _passwordconfirmFocusNode,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            hintText: 'تأكيد كلمة المرور',
                            hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                            filled: true,
                            fillColor: _passwordconfirmFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      // User Type Dropdown
                      SizedBox(
                          height: 43,
                          width: 170,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 71, 118, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Text(
                              'سجل',
                              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      
                    ],
                  ),
                ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
