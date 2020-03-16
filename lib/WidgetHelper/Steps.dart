

import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  final int selectedStep;
  final int nbSteps;
  final Color selectedStepColorOut;
  final Color selectedStepColorIn;
  final Color doneStepColor;
  final Color unselectedStepColor;
  final Color doneLineColor;
  final Color undoneLineColor;
  final bool isHorizontal;
  final double lineLength;
  final double lineThickness;
  final double doneStepSize;
  final double unselectedStepSize;
  final double selectedStepSize;
  final double selectedStepBorderSize;
  final Widget doneStepWidget;
  final Widget unselectedStepWidget;
  final Widget selectedStepWidget;
  final List<String> stepTitle;

  const Steps(
      {this.selectedStep = 0,
        this.nbSteps = 4,
        this.selectedStepColorOut = Colors.blue,
        this.selectedStepColorIn = Colors.white,
        this.doneStepColor = Colors.blue,
        this.unselectedStepColor = Colors.blue,
        this.doneLineColor = Colors.blue,
        this.undoneLineColor = Colors.blue,
        this.isHorizontal = true,
        this.lineLength = 40,
        this.lineThickness = 1,
        this.doneStepSize = 10,
        this.unselectedStepSize = 10,
        this.selectedStepSize = 14,
        this.selectedStepBorderSize = 1,
        this.doneStepWidget,
        this.unselectedStepWidget,
        this.selectedStepWidget,
        this.stepTitle
      });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      // Display in Row
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (var i = 0; i < nbSteps; i++) stepBuilder(i , stepTitle[i] ),
        ],
      );
    } else {
      // Display in Column
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (var i = 0; i < nbSteps; i++) stepBuilder(i ,  stepTitle[i]),
        ],
      );
    }
  }

  Widget stepBuilder(int i , String stepTitle) {
    if (isHorizontal) {
      // Display in Row
      return (selectedStep == i
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,   children: <Widget>[
          stepSelectedWidget(stepTitle),
          selectedStep == nbSteps ? stepLineDoneWidget() : Container(),
          i != nbSteps - 1 ? stepLineUndoneWidget() : Container()
        ],
      )
          : selectedStep > i
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          stepDoneWidget(stepTitle),
          i < nbSteps - 1 ? stepLineDoneWidget() : Container(),
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          stepUnselectedWidget(stepTitle),
          i != nbSteps - 1 ? stepLineUndoneWidget() : Container()
        ],
      ));
    } else {
      // Display in Column
      return (selectedStep == i
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          stepSelectedWidget(stepTitle),
          selectedStep == nbSteps ? stepLineDoneWidget() : Container(),
          i != nbSteps - 1 ? stepLineUndoneWidget() : Container()
        ],
      )
          : selectedStep > i
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          stepDoneWidget(stepTitle),
          i < nbSteps - 1 ?  stepLineDoneWidget(): Container(),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          stepUnselectedWidget(stepTitle),
          i != nbSteps - 1 ? stepLineUndoneWidget() : Container()
        ],
      ));
    }
  }

  Widget stepSelectedWidget(stepTitle) {
    return Hero(
      tag: 'selectedStep',
      child: selectedStepWidget != null
          ? selectedStepWidget
          :
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          ClipRRect(
            borderRadius: BorderRadius.circular(selectedStepSize),
            child: Container(
                decoration: BoxDecoration(
                    color: selectedStepColorIn,
                    borderRadius: BorderRadius.circular(selectedStepSize),
                    border: Border.all(
                        width: selectedStepBorderSize,
                        color: selectedStepColorOut)),
                height: selectedStepSize,
                width: selectedStepSize,
                child: Container()),
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("$stepTitle" , style: TextStyle(height: 0),),
          ),
        ],

      )


    );
  }

  Widget stepDoneWidget(stepTitle) {
    return doneStepWidget != null
        ? doneStepWidget
        :

    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      textBaseline: TextBaseline.alphabetic,
      textDirection: TextDirection.ltr,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.circular(doneStepSize),
          child: Container(
            color: doneStepColor,
            height: doneStepSize,
            width: doneStepSize,
            child: Container(),
          ),
        ),
        SizedBox(width: 10,),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("$stepTitle" , style: TextStyle(height: 0),),
        ),

      ],

    );


  }

  Widget stepUnselectedWidget(stepTitle) {
    return unselectedStepWidget != null
        ? unselectedStepWidget
        :
      Row(
         textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(unselectedStepSize),
          child: Container(
            color: unselectedStepColor,
            height: unselectedStepSize,
            width: unselectedStepSize,
            child: Container(),
          ),
        ),
        SizedBox(width: 10,),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("$stepTitle" , style: TextStyle(height: 0),),
        ),

      ],

    );


  }

  Widget stepLineDoneWidget() {
    return Container(
        margin: EdgeInsets.only(left: 4.5 , right: 4.5),
        height: isHorizontal ? lineThickness : lineLength,
        width: isHorizontal ? lineLength : lineThickness,
        color: doneLineColor);
  }

  Widget stepLineUndoneWidget() {
    return Container(
        margin: EdgeInsets.only(left: 4.5 , right: 4.5),
        height: isHorizontal ? lineThickness : lineLength,
        width: isHorizontal ? lineLength : lineThickness,
        color: undoneLineColor,

    );
  }
}
