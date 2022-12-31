import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../blocs/image_bloc.dart';
import '../blocs/image_states.dart';

import '../blocs/image_events.dart';
import '../blocs/image_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBloc>(
      create: (context) =>
          ImageBloc(ImageRepository())..add(ImageLoadedEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('bloc api'),
        ),
        body: BlocBuilder<ImageBloc, ImageStates>(
          builder: (context, state) {
            if (state is ImageLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ImageLoadedState) {
              return ListView.builder(
                itemCount: state.images.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(state.images[index].url!),
                    ),
                    title: Text(state.images[index].title!),
                    subtitle: Text(state.images[index].url!),
                  );
                },
              );
            } else if (state is ImageExceptionState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }
}
