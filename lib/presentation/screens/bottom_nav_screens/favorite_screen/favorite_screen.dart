import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/data/home_cubit/home_cubit.dart';
import 'package:safqa_app/data/home_cubit/home_state.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/custom_product_vert_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/search_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.favoriteStatus) {
          case FavoriteStatus.initial:
          case FavoriteStatus.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case FavoriteStatus.success:
            return Column(
              children: [
                Container(
                  width: 375.w,
                  height: 115.h,
                  decoration: BoxDecoration(color: Color(0xffF6FAFD)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: arrowBackWidget(context),
                            ),
                            Spacer(),
                            Text(
                              'المفضلة',
                              style: TextStyles.appBarTitle,
                            ),
                            Spacer(),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    // scrollDirection: ./,
                      itemBuilder: (context, index) => CustomProductVertWidget(
                            inFavorite:state.myFavoritePosts![index].isFavorite!,
                            imagePath: state.myFavoritePosts![index].gallery!.first.original!,
                            title:state.myFavoritePosts![index].title!,
                            owner: state.myFavoritePosts![index].user!.name!,
                            price: state.myFavoritePosts![index].price!.toString(),
                        onTap: () {

                        },
                            location: '${state.myFavoritePosts![index].region!.name!}-${state.myFavoritePosts![index].district!.name!}',
                            duration: state.myFavoritePosts![index].parseDate(DateTime.parse(state.myFavoritePosts![index].updatedAt!)),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: state.myFavoritePosts!.length),
                )
              ],
            );
          case FavoriteStatus.failure:
            return Center(
              child: Text(state.errorMessage!),
            );
        }
      },
    );
  }
}
