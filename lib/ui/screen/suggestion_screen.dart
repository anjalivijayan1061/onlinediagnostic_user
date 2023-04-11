import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/suggestion/suggestion_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/suggestions/add_suggestion_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/suggestions/suggestion_card.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  SuggestionBloc suggestionBloc = SuggestionBloc();

  @override
  void initState() {
    suggestionBloc.add(GetAllSuggestionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SuggestionBloc>.value(
      value: suggestionBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Suggestions",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider<SuggestionBloc>.value(
                      value: suggestionBloc,
                      child: const AddSuggestionDialog(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<SuggestionBloc, SuggestionState>(
            listener: (context, state) {
              if (state is SuggestionFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failed!',
                    message: state.message,
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: state is SuggestionLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: state is SuggestionSuccessState
                                ? state.suggestions.isNotEmpty
                                    ? Wrap(
                                        runSpacing: 15,
                                        children: List<Widget>.generate(
                                          state.suggestions.length,
                                          (index) => SuggestionCard(
                                            suggestionDetails:
                                                state.suggestions[index],
                                            suggestionBloc: suggestionBloc,
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'No suggestions found!\nClick on + button on the appbar to send a suggestion',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                : state is SuggestionFailureState
                                    ? Center(
                                        child: CustomIconButton(
                                          icon: Icons.refresh_outlined,
                                          iconColor: Colors.blue,
                                          onTap: () {
                                            suggestionBloc
                                                .add(GetAllSuggestionEvent());
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
