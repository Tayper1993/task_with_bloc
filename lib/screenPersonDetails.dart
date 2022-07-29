import 'package:flutter/material.dart';

import 'api.dart';
import 'models.dart';
import 'theme.dart';

const textNormal = TextStyle(fontSize: 16.0);
const textBold = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

class PersonDetailsScreen extends StatefulWidget {
  final String id;
  final Api _api;

  const PersonDetailsScreen({Key? key, required this.id, required api})
      : _api = api,
        super(key: key);

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsScreen> {
  final String id;
  PersonDetails? person;
  bool loading = true;

  _State({required this.id}) : super();

  void load() async {
    setState(() {
      this.loading = true;
    });
    try {
      final res = await widget._api.loadPersonDetails(id);
      setState(() {
        person = res;
        loading = false;
      });
    } on Exception {
      new Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Fail to load data'),
              backgroundColor: Colors.red[900]),
        );
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(person == null ? '' : person!.name),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading',
                valueColor: AlwaysStoppedAnimation(ThemeColors.primary),
              ),
            )
          : person == null
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Fail to load'),
                    ElevatedButton(
                      onPressed: load,
                      child: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                          primary: ThemeColors.primary),
                    )
                  ],
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        person!.avatar,
                        alignment: Alignment.topLeft,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width > 600
                            ? null
                            : double.infinity,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Row(
                          children: [
                            const Text('Name: ', style: textBold),
                            Text(person!.name, style: textNormal),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12, left: 16),
                        child: Row(
                          children: [
                            const Text('Status: ', style: textBold),
                            Text(person!.status, style: textNormal),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12, left: 16),
                        child: Row(
                          children: [
                            const Text('Spices: ', style: textBold),
                            Text(person!.spices, style: textNormal),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16, left: 24),
                        child: Row(
                          children: [
                            const Text('Origin: ', style: textBold),
                            Text(
                              person!.originName,
                              style: textNormal,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
}
