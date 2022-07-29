import 'package:flutter/material.dart';

import 'api.dart';
import 'models.dart';
import 'theme.dart';
import 'screenPersonDetails.dart';

class PersonListScreen extends StatefulWidget {
  final title = 'Characters';
  final Api _api;

  const PersonListScreen({Key? key, required api})
      : _api = api,
        super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PersonListScreen> {
  List<Person> persons = [];
  var nextPage = 1;
  var loadingError = false;

  void load() async {
    if (nextPage == -1) return;
    try {
      final res = await widget._api.loadPersonList(nextPage);
      setState(() {
        nextPage = res.item2;
        persons.addAll(res.item1);
        loadingError = false;
      });
    } on Exception {
      setState(() {
        loadingError = true;
      });
    }
  }

  void navigateToPersonDetails(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonDetailsScreen(
                  id: id,
                  api: widget._api,
                )));
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: persons.isEmpty
          ? Loader(load: load, loadingError: loadingError)
          : ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: persons.length + 1,
              itemBuilder: (context, i) {
                if (i == persons.length) {
                  if (nextPage == -1) {
                    return const SizedBox.shrink();
                  }
                  load();
                  return Loader(load: load, loadingError: loadingError);
                }
                return showPersonNew(persons[i]);
              },
              separatorBuilder: (context, i) => const Divider(),
            ));

  Widget showPersonNew(Person person) => ListTile(
        title: Text(
          person.name,
          style: const TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(
          person.status.toLowerCase(),
          style: TextStyle(
              fontSize: 14.0,
              color: person.status == 'Dead'
                  ? Colors.red
                  : person.status == 'unknown'
                      ? Colors.orange
                      : ThemeColors.primary),
        ),
        leading: CircleAvatar(
          maxRadius: 40,
          backgroundImage: NetworkImage(person.image),
        ),
        onTap: () => navigateToPersonDetails(person.id),
      );
}

class Loader extends StatelessWidget {
  final void Function() load;
  final bool loadingError;

  const Loader({Key? key, required this.loadingError, required this.load})
      : super(key: key);

  @override
  Widget build(BuildContext context) => loadingError
      ? Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Fail to load data'),
            ElevatedButton(
                onPressed: load,
                child: Text('Try again'),
                style: ElevatedButton.styleFrom(primary: ThemeColors.primary)),
          ],
        ))
      : const Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Loading',
            valueColor: AlwaysStoppedAnimation(ThemeColors.primary),
          ),
        );
}
