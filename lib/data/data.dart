import 'package:flutter/material.dart';

List days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
List machines = [
  "Treadmill",
  "Rowing",
  "Dipping Bar",
  "Leg Press",
  "Lat Pulldown",
  "Chest Press",
  "Shoulder Press",
  "Cable Crossover",
  "Smith",
  "Leg Extension",
  "Back Extension"
];

final List<Map<String, dynamic>> amenities = [
  {'name': 'AC', 'icon': Icons.ac_unit},
  {'name': 'Wifi', 'icon': Icons.wifi},
  {'name': 'Parking', 'icon': Icons.local_parking},
  {'name': 'Water Cooler', 'icon': Icons.local_drink},
  {'name': 'Locker', 'icon': Icons.lock},
];

final Map<String, IconData> amenityIcons = {
  for (var amenity in amenities) amenity['name']: amenity['icon'],
};
const markdown = """
**Privacy Policy**

This privacy policy applies to the Blissbody app (hereby referred to as "Application") for mobile devices that was created by Shivam Rajput (hereby referred to as "Service Provider") as a Free service. This service is intended for use "AS IS".

**Information Collection and Use**

The Application collects information when you download and use it. This information may include information such as

*   Your device's Internet Protocol address (e.g. IP address)
*   The pages of the Application that you visit, the time and date of your visit, the time spent on those pages
*   The time spent on the Application
*   The operating system you use on your mobile device

The Application does not gather precise information about the location of your mobile device.

The Application collects your device's location, which helps the Service Provider determine your approximate geographical location and make use of in below ways:

*   Geolocation Services: The Service Provider utilizes location data to provide features such as personalized content, relevant recommendations, and location-based services.
*   Analytics and Improvements: Aggregated and anonymized location data helps the Service Provider to analyze user behavior, identify trends, and improve the overall performance and functionality of the Application.
*   Third-Party Services: Periodically, the Service Provider may transmit anonymized location data to external services. These services assist them in enhancing the Application and optimizing their offerings.

The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions.

For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information, including but not limited to name,age,gender,phone,otp. The information that the Service Provider request will be retained by them and used as described in this privacy policy.

**Third Party Access**

Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.

Please note that the Application utilizes third-party services that have their own Privacy Policy about handling data. Below are the links to the Privacy Policy of the third-party service providers used by the Application:

*   [Google Play Services](https://www.google.com/policies/privacy/)

The Service Provider may disclose User Provided and Automatically Collected Information:

*   as required by law, such as to comply with a subpoena, or similar legal process;
*   when they believe in good faith that disclosure is necessary to protect their rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;
*   with their trusted services providers who work on their behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement.

**Opt-Out Rights**

You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.

**Data Retention Policy**

The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at cvam.rex@gmail.com and they will respond in a reasonable time.

**Children**

The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13.

The Application does not address anyone under the age of 13. The Service Provider does not knowingly collect personally identifiable information from children under 13 years of age. In the case the Service Provider discover that a child under 13 has provided personal information, the Service Provider will immediately delete this from their servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact the Service Provider (cvam.rex@gmail.com) so that they will be able to take the necessary actions.

**Security**

The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains.

**Changes**

This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to the Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.

This privacy policy is effective as of 2024-05-26

**Your Consent**

By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by us.

**Contact Us**

If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at cvam.rex@gmail.com.

""";
List<String> gymData = [
  "Chest",
  "Back",
  "Shoulder",
  "Legs",
  "Biceps",
  "Triceps",
  "Abs"
];
List<Map<String, dynamic>> workouts = [
  {
    'name': 'Chest',
    'image':
        'https://t3.ftcdn.net/jpg/01/93/73/18/360_F_193731868_afOYcVHhGIsrKB6IaO0kkQRVIXU47nvY.jpg'
  },
  {
    'name': 'Legs',
    'image':
        'https://qph.cf2.quoracdn.net/main-qimg-c657959fdc35d9a9df62ade4da61cfa2-pjlq'
  },
  {
    'name': 'Back',
    'image':
        'https://cdn.muscleandstrength.com/sites/default/files/best_back_exercises_-_1200x630.jpg'
  },
  {
    'name': 'Triceps',
    'image': 'https://blog.squatwolf.com/wp-content/uploads/2019/07/tw5.jpg'
  },
  {
    'name': 'Biceps',
    'image':
        'https://blogscdn.thehut.net/app/uploads/sites/495/2021/08/shutterstock_1417778522-hero-min_1629721852_1669991413.jpg'
  },
  {
    'name': 'Abs',
    'image':
        'https://media.istockphoto.com/id/998035336/photo/muscular-man-standing-in-the-gym.jpg?s=612x612&w=0&k=20&c=J6L6VcDGRs_wVt5B0uEIulZE0NkHNenlNZigUoFVZBU='
  },
  {
    'name': 'Shoulder',
    'image':
        'https://t4.ftcdn.net/jpg/03/23/50/79/360_F_323507957_0gQGkUqu7ZStF7SgJ0JssJY7tnM0BGG2.jpg'
  },
];

Map<String, List<String>> workoutExercises = {
  'Chest': [
    'Bench Press',
    'Incline Bench Press',
    'Decline Bench Press',
    'Butterfly',
    'Dumbbell Flyes',
    'Push-Ups',
  ],
  'Back': [
    'Pull-Ups',
    'Lat Pull-Down',
    'Bent-Over Row',
    'Deadlift',
    'T-Bar Row',
    'Seated Cable Row',
  ],
  'Shoulder': [
    'Military Press',
    'Dumbbell Shoulder Press',
    'Lateral Raises',
    'Front Raises',
    'Shrugs',
    'Reverse Flyes',
  ],
  'Legs': [
    'Squats',
    'Leg Press',
    'Lunges',
    'Leg Extensions',
    'Leg Curls',
    'Calf Raises',
  ],
  'Biceps': [
    'Barbell Curls',
    'Dumbbell Curls',
    'Hammer Curls',
    'Concentration Curls',
    'Preacher Curls',
    'Cable Curls',
  ],
  'Triceps': [
    'Tricep Dips',
    'Skull Crushers',
    'Tricep Pushdown',
    'Overhead Tricep Extension',
    'Close-Grip Bench Press',
    'Tricep Kickbacks',
  ],
  'Abs': [
    'Crunches',
    'Leg Raises',
    'Planks',
    'Russian Twists',
    'Bicycle Crunches',
    'Hanging Leg Raises',
  ],
};
