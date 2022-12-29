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
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (state is ImageLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ImageExceptionState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is ImageLoadedState) {
                      return Image.network(state.images[index].url!);
                    }
                    return const SizedBox();
                  },
                  itemCount:
                      state is ImageLoadedState ? state.images.length : 0,
                );
              },
              listener: (context, state) {},
            ),
          ),
        ],
      ),
    );
  }
}
