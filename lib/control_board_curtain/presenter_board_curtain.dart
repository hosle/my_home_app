import 'package:my_home_app/control_board_curtain/view_board_curtain.dart';
import 'control_board_curtain_model.dart';
import 'dart:developer' as developer;

class PresenterBoardCurtain{

  ViewBoardCurtain _view =ViewBoardCurtain();

  void onCurtainSelectionChanged(Set<Piece> selection){
    _view.notifyCurtainSelectionChanged("Curtain selection changed to ${selection.first}", selection);
  }

  void onCurtainUpClicked(){
    developer.log("Curtain up clicked", name: "PresenterBoardCurtain");
  }

  void onCurtainDownClicked(){
    developer.log("Curtain Down clicked", name: "PresenterBoardCurtain");

  }

  void onCurtainStopClicked(){
    developer.log("Curtain Stop clicked", name: "PresenterBoardCurtain");

  }

  set setView(ViewBoardCurtain view){
    _view = view;
  }
}