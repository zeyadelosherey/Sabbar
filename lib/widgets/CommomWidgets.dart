import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sabbar/utilities/Constants.dart';
import 'package:sabbar/widgets/SlidingPanel.dart';
import 'package:sabbar/widgets/Steps.dart';

class CommonWidgets{
  static Widget slideImageWidget(imageAnimation , heightAndWidth){
    return Positioned(
      bottom: heightAndWidth,
      child: Container(
        width: imageAnimation.value * 130,
        height: imageAnimation.value * 130,
        decoration: new BoxDecoration(
          color: Constants.appWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 9.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
            )
          ],
          borderRadius:  BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          child: Hero(
            tag: "profileImage",
            child: CachedNetworkImage(
              imageUrl: "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/69810320_100605981323755_90273817355616256_n.jpg?_nc_cat=103&_nc_sid=85a577&_nc_oc=AQl9EMdWBS40MaTgllSFsCSW-C3URhCPI7gSzDO5MgKuwu35VdvCoqCiQ8Uo3JXCS3w&_nc_ht=scontent-hbe1-1.xx&oh=091ef64824996dcf1afdf91c387ef23b&oe=5E94542C",
              placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Constants.appOrange),)),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/pickup.png",
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }



 static Widget orderInformationWidget(String title , String time , BuildContext context){
    return  Container(
      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/6 , right: MediaQuery.of(context).size.width/6 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Align( alignment: Alignment.centerLeft, child: Text("$title" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),)),),
          Expanded(child: Align( alignment: Alignment.centerRight,child: Text("$time")), flex: 1,)

        ],
      ),
    );
  }



  static Widget slideWidget(panelAnimation , imageAnimation , panelController , height  , Widget widget ){
    return Stack(
      alignment:Alignment.center,
      children: <Widget>[
        SlidingUpPanel(
          minHeight: panelAnimation.value*height,
          maxHeight: height,
          controller: panelController,
          color: Constants.appOrange,
          borderRadius: BorderRadius.only(topRight: Radius.circular(35), topLeft: Radius.circular(35)),
          panel: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80,),
                  Text("Mohamed Abdullah" , style: TextStyle(color: Constants.appBlack , fontSize: 16 , fontWeight: FontWeight.bold),),
                  SizedBox(height: 25,),
                  widget
                ],
              ),
            ),
          ),
        ),
        CommonWidgets.slideImageWidget(imageAnimation , height - 60 )
      ],
    );
  }
}