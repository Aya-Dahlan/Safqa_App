import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/data/models/post_model.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/details_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/dots_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/header_buttons.dart';

class ProductDetailsScreen extends StatefulWidget {
   ProductDetailsScreen({super.key,required this.postModel});

  PostModel postModel;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState(postModel:postModel);
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PostModel postModel;

  _ProductDetailsScreenState({required this.postModel});
  int _currentIndex = 0;

  final List<String> images = [
    'assets/images/product_details.jpg',
    'assets/images/product_details.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350.h,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: postModel.gallery!.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.network(
                        postModel.gallery![index].original!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
                const header_buttons(),
                dots_widget(images: postModel.gallery!.map((e) => e.original!,).toList(), currentIndex: _currentIndex),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              left: 16.w,
              right: 16.w,
            ),
            child:  detailsWidget(
              dateAgo: postModel.parseDate(DateTime.parse(postModel.updatedAt!)),
              imagePerson: postModel.user!.avatarUrls!.isNotEmpty?postModel.user!.avatarUrls!.first : 'assets/icons/badge.svg',
              nameProduct: postModel.title!,
              price: '${postModel.price} ريال',
              namePerson: postModel.user!.name!,
              location: '${postModel.region!.name!}-${postModel.district!.name!}',
              descProduct: postModel.description!
                  // 'شقة أرضية مميزة بمساحة 150 متر مربع، تضم 3 غرف نوم واسعة، وصالة استقبال مشرقة، ومطبخ مفتوح مجهز. الشقة تتمتع بحديقة خاصة بمساحة إضافية 50 متر مربع، مما يوفر مساحة للاسترخاء والاستمتاع بالهواء الطلق. تقع في منطقة هادئة وقريبة من جميع الخدمات الضرورية مثل المدارس والمراكز التجارية.',
            ),
          ),
        ],
      ),
    );
  }
}
