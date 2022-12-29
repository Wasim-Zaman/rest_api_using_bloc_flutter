import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/image_bloc.dart';
import '../blocs/image_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bloc api'),
      ),
      body: Column(
        children: [
          const Text('bloc api'),
          Expanded(
            child: BlocConsumer<ImageBloc, ImageStates>(
              builder: (context, state) {
                if (state is ImageExceptionState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is ImageLoadedState) {
                  return ListView.builder(
                    itemCount: state.images.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            Image.network(state.images[index].thumbnailUrl!),
                        title: Text(state.images[index].title!),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
              listener: (context, state) {
                if (state is ImageExceptionState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
