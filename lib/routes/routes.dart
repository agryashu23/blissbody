import 'package:blissbody_app/admin/admin_add_gym.dart';
import 'package:blissbody_app/admin/admin_edit_gym.dart';
import 'package:blissbody_app/admin/admin_bookings.dart';
import 'package:blissbody_app/admin/admin_gyms.dart';
import 'package:blissbody_app/admin/admin_home.dart';
import 'package:blissbody_app/admin/admin_own_gyms.dart';
import 'package:blissbody_app/admin/admin_search_city.dart';
import 'package:blissbody_app/admin/admin_transaction.dart';
import 'package:blissbody_app/owner_pages/owner_booking.dart';
import 'package:blissbody_app/owner_pages/owner_edit_cover.dart';
import 'package:blissbody_app/owner_pages/owner_edit_machines.dart';
import 'package:blissbody_app/owner_pages/owner_edit_package.dart';
import 'package:blissbody_app/owner_pages/owner_edit_details.dart';
import 'package:blissbody_app/owner_pages/owner_edit_slots.dart';
import 'package:blissbody_app/owner_pages/owner_homepage.dart';
import 'package:blissbody_app/owner_pages/owner_profile.dart';
import 'package:blissbody_app/owner_pages/widgets/owner_transactions.dart';
import 'package:blissbody_app/pages/bookings.dart';
import 'package:blissbody_app/pages/choose_package.dart';
import 'package:blissbody_app/pages/create_profile.dart';
import 'package:blissbody_app/pages/create_reel_image.dart';
import 'package:blissbody_app/pages/create_reels.dart';
import 'package:blissbody_app/pages/details_page.dart';
import 'package:blissbody_app/pages/edit_profile.dart';
import 'package:blissbody_app/pages/exercises.dart';
import 'package:blissbody_app/pages/favourites.dart';
import 'package:blissbody_app/pages/login_screen.dart';
import 'package:blissbody_app/pages/nearby_gym_page.dart';
import 'package:blissbody_app/pages/onboarding_screen.dart';
import 'package:blissbody_app/pages/otp_screen.dart';
import 'package:blissbody_app/pages/privacy_policy.dart';
import 'package:blissbody_app/pages/search_gyms.dart';
import 'package:blissbody_app/pages/search_screen.dart';
import 'package:blissbody_app/pages/slot_page.dart';
import 'package:blissbody_app/pages/splash_screen.dart';
import 'package:blissbody_app/pages/start_page.dart';
import 'package:blissbody_app/pages/transactions.dart';
import 'package:blissbody_app/pages/user_reels.dart';
import 'package:blissbody_app/widgets/chooseVideo.dart';
import 'package:blissbody_app/widgets/exercise_detail.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/onboard',
        page: () => const OnBoardingScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/otp',
        page: () => const OtpScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/create-profile',
        page: () => const CreateProfile(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/start',
        page: () => const StartPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/search-city',
        page: () => SearchCity(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/choose/video',
        page: () => ChooseVideo(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/edit-profile',
        page: () => const EditProfile(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/details',
        page: () => const DetailsPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/packages',
        page: () => const BookPackages(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/slots',
        page: () => const SlotPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/favourites',
        page: () => const Favorites(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/home',
        page: () => const OwnerHomePage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/profile',
        page: () => const OwnerProfile(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/edit/details',
        page: () => OwnerEditDetails(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/edit/cover',
        page: () => OwnerEditCover(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/edit/slots',
        page: () => OwnerEditSlots(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/edit/package',
        page: () => OwnerEditPackage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/edit/machines',
        page: () => OwnerMachines(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/bookings',
        page: () => const OwnerBookings(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/owner/transactions',
        page: () => const OwnerTransactions(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/create/reel',
        page: () => const CreateReels(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/create/reel/image',
        page: () => const CreateReelImage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/user/reel',
        page: () => const UserReels(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/nearby/gyms',
        page: () => const NearbyGymsPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/search/gyms',
        page: () => SearchGyms(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/bookings',
        page: () => const Bookings(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/transactions',
        page: () => const Transactions(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/home',
        page: () => const AdminHome(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/bookings',
        page: () => const AdminBookings(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/transactions',
        page: () => const AdminTransaction(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/gyms',
        page: () => const AdminGyms(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/search-city',
        page: () => AdminSearchCity(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/edit-gym',
        page: () => const AdminEditGym(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/add-gym',
        page: () => const AdminAddGym(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/admin/own/gyms',
        page: () => const AdminOwnGyms(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/privacy',
        page: () => const PrivacyPolicy(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/exercises',
        page: () => Exercises(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/exercise/detail',
        page: () => ExerciseDetail(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
