import 'dart:io';

import 'package:citizen_service/BlockServices/MenuService.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuEvent{
  fetchAlbums
}

abstract class MenuState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MenuLoadingState extends MenuState{ }
class MenuInitialState extends MenuState{ }

class MenuLoadedState extends MenuState{
  final List<DropDownModal> albums;
  MenuLoadedState({required this.albums});
}

class MenuListErrorstate extends MenuState{

  final error;
  MenuListErrorstate({this.error});
}

class MenuBloc extends Bloc<MenuEvent,MenuState>
{
  @override
  // TODO: implement initialState
  MenuState get initialState => throw UnimplementedError();

  final MenuService albumsrepository;
  late List<DropDownModal> listAlbums;

  MenuBloc({required this.albumsrepository}) : super(MenuInitialState());


  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {

    switch(event)
    {
      case MenuEvent.fetchAlbums:

        yield  MenuLoadingState();

        try {
          listAlbums = await albumsrepository.getCategoryMenu();

          yield MenuLoadedState(albums: listAlbums);

        }on SocketException {
          yield MenuListErrorstate(
            error: ('No Internet'),
          );
        } on HttpException {
          yield MenuListErrorstate(
            error: ('No Service'),
          );
        } on FormatException {
          yield MenuListErrorstate(
            error: ('No Format Exception'),
          );
        } catch (e) {
          yield MenuListErrorstate(
            error: ('Un Known Error ${e.toString()}'),
          );
        }
        break;
    }

  }



}