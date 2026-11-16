# BlissBody: Gym Discovery and Booking App

A Flutter app for finding gyms nearby, comparing their packages, and booking
and paying for workout slots, with a separate dashboard for gym owners and an
admin console for onboarding gyms. It also has a short-video **reels** feed
where gyms and users share workout content.

**About 15,000 lines of Dart** across 75+ files, three user roles and 25+
routes.

## Three apps in one

### Members
- **Phone OTP login** with SMS autofill: the code is read from the SMS
  automatically, with no typing.
- **Onboarding and profile setup:** carousel onboarding, profile photo, height
  and body details.
- **Nearby gyms:** the device location (Geolocator) is turned into an address
  (geocoding) to show gyms near you. You can also search by city or name.
- **Gym details:** a cover carousel, machines and facilities, packages, a map
  pin with a Google Maps deep link, and ratings and reviews with a rating
  summary.
- **Packages, slots and payment:** pick a package, then a date on a timeline
  picker and a time slot, then pay in-app through **Razorpay** (success, error
  and external-wallet callbacks are all handled).
- **Bookings, transactions and favourites** history.
- **Reels:** record or pick a video, **trim** it, **compress** it on the device,
  then upload it. Image reels are supported too, and there's a scrollable feed.
- **Exercise library** and plan builder, with Markdown-rendered content.

### Gym owners
- Owner home with **bookings** and **transactions**.
- Edit the gym profile: details, cover images, **time slots**, **packages**,
  **machines** and location on an embedded Google Map.
- Post promotional videos and reels.

### Admin
- Add and edit gyms on behalf of owners, including media upload.
- City-wise gym search, the admin's own gyms, and a platform-wide view of
  bookings and transactions.

## Architecture

```
lib/
  main.dart             GetMaterialApp bootstrap
  routes/routes.dart    25+ named routes (GetX)
  controllers/          GetX controllers per feature: auth, home, gym, detail,
                        profile, reels, owner, admin (reactive state with Rx)
  services/rest.dart    REST client: JSON calls + multipart uploads
                        (images, covers, videos, reels) to S3 via the backend
  pages/                member screens
  owner_pages/          owner dashboard and editors
  admin/                admin console
  widgets/              reusable cards: gym, booking, plan, reviews, ...
  utils/permissions.dart  location-permission flow
```

- **State management and routing:** GetX (controllers, `Obx` reactivity, named
  routes, dependency injection).
- **Media pipeline:** `image_picker` → (video) `video_trimmer` →
  `video_compress` → multipart upload → S3 URL stored with the gym or reel.
- **Session:** `shared_preferences` keeps the logged-in user ID, phone number and profile-completion state.

## Tech stack

Flutter · Dart · GetX · REST (`http`) · AWS S3 (via backend) · Google Maps
Flutter · Geolocator + Geocoding · Razorpay · sms_autofill · video_trimmer ·
video_compress · video_player · carousel_slider · flutter_rating_bar ·
flutter_markdown

## Running

```bash
flutter pub get
flutter run
```

You'll need:
- A **Google Maps API key** in `android/app/src/main/AndroidManifest.xml`.
- A **Razorpay key** for the checkout options in `lib/pages/slot_page.dart`.
- The backend base URL used in `lib/services/rest.dart`.
