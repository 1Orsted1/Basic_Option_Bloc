import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer_loading_effect/bloc/bloc.dart';
import 'package:flutter_shimmer_loading_effect/bloc/event.dart';
import 'package:flutter_shimmer_loading_effect/bloc/state.dart';
import 'package:flutter_shimmer_loading_effect/model/item.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  //Bloc.observer = SimpleBlocObserver();

  //padre = Home BlocProvider = stless
  //hijo = HomeView BlocListener, BlocBuilder = stfull

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return HomeBloc()
            ..add(const GetItemsEvent());
        })
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isLoading = true;

  List<Item> _items = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        ///State Errors
        if (state is ItemsError) {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${state.error}"),
          ));
        }

        if (state is ItemsEmpty) {}

        if (state is ItemsLoading) {
          setState(() {
            _isLoading = true;
          });
        }
        if (state is ItemsReceived) {
          setState(() {
            _items = state.itemsReceived.items;
          });
          _isLoading = false;
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("BOB'S CODE"),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(GetItemsEvent());
                    },
                    icon: const Icon(Icons.wifi_protected_setup))
              ],
            ),
            body: (_isLoading)
                ? Center(
                    child: ListView(
                      children: [
                        _loadingWidgets(context, _isLoading),
                        _loadingWidgets(context, _isLoading),
                        _loadingWidgets(context, _isLoading),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  _items[index].url,
                                  fit: BoxFit.contain,
                                  width: 150,
                                  height: 150,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(_items[index].title),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
          );
        },
      ),
    );
  }
}

Widget _loadingWidgets(ctx, bool _isLoading) {
  return Card(
    child: Column(
      children: [
        Row(
          children: [
            ShimmerLoading(
              isLoading: _isLoading,
              child: Container(
                color: Colors.grey,
                width: 150,
                height: 150,
              ),
            ),
            Column(
              children: [
                ShimmerLoading(
                  isLoading: _isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(ctx).size.width / 2,
                      height: 20,
                    ),
                  ),
                ),
                ShimmerLoading(
                  isLoading: _isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(ctx).size.width / 2,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);
  final bool isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}
