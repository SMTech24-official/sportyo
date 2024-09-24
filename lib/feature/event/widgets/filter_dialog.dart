import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/app_texts.dart';
import '../../../core/global_widegts/customTextField.dart';
import '../../../core/global_widegts/custom_button_container.dart';
import '../../profile/widget/global_text_style.dart';
import '../controller/event_controller.dart';

void showFilterDialog(BuildContext context) {
  final EventController eventController =
      Get.find<EventController>(); // Find the controller

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 284.w,
          height: 415.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  AppTexts.filterEvents,
                  style: globalTextStyle(
                      fontSize: 20.sp, lineHeight: 30.sp / 20.sp),
                ),
              ),
              SizedBox(height: 5.h),
              // Country input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.country,
                    style: globalTextStyle(
                        fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                  ),
                  DropdownButtonFormField<String>(
                    padding: EdgeInsets.zero,
                    value: eventController.country.value.isEmpty
                        ? null
                        : eventController.country.value,
                    hint: Text(
                      'Select a Country',
                      style: globalTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          lineHeight: 17.sp / 12.sp),
                    ),
                    items: countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              lineHeight: 17.sp / 12.sp),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        eventController.countryController.text = newValue;
                        eventController.country.value = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Color(0xff010101), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Color(0xff010101), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Color(0xff010101), width: 1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Sport input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.sport,
                    style: globalTextStyle(
                        fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: double.infinity,
                    child: CustomTextField(
                      hitText: 'Sport XX',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      lineHeight: 17.sp / 12.sp,
                      textEditingController: eventController.sportController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Event input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.event,
                    style: globalTextStyle(
                        fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: double.infinity,
                    child: CustomTextField(
                      hitText: 'Level XXX',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      lineHeight: 17.sp / 12.sp,
                      textEditingController: eventController.eventController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Date",
                  style: globalTextStyle(
                      fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 113.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: GoogleFonts.sourceSans3(
                                fontSize: 10.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                height: 15.sp / 10.sp,
                                color: AppColors.blackColor),
                          ),
                          CustomTextField(
                            textEditingController:
                                eventController.dateFromController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 113.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TO',
                            style: GoogleFonts.sourceSans3(
                                fontSize: 10.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                height: 15.sp / 10.sp,
                                color: AppColors.blackColor),
                          ),
                          CustomTextField(
                            textEditingController:
                                eventController.dateToController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              // Save and Cancel buttons
              CustomButtonContainer(
                save: () {
                  Get.back();
                },
                cancel: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      );
    },
  );
}

// Country list
final List<String> countries = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'Andorra',
  'Angola',
  'Antigua and Barbuda',
  'Argentina',
  'Armenia',
  'Australia',
  'Austria',
  'Azerbaijan',
  'Bahamas',
  'Bahrain',
  'Bangladesh',
  'Barbados',
  'Belarus',
  'Belgium',
  'Belize',
  'Benin',
  'Bhutan',
  'Bolivia',
  'Bosnia and Herzegovina',
  'Botswana',
  'Brazil',
  'Brunei',
  'Bulgaria',
  'Burkina Faso',
  'Burundi',
  'Côte d\'Ivoire',
  'Cabo Verde',
  'Cambodia',
  'Cameroon',
  'Canada',
  'Central African Republic',
  'Chad',
  'Chile',
  'China',
  'Colombia',
  'Comoros',
  'Congo',
  'Costa Rica',
  'Croatia',
  'Cuba',
  'Cyprus',
  'Czech Republic',
  'Democratic Republic of the Congo',
  'Denmark',
  'Djibouti',
  'Dominica',
  'Dominican Republic',
  'Ecuador',
  'Egypt',
  'El Salvador',
  'Equatorial Guinea',
  'Eritrea',
  'Estonia',
  'Eswatini',
  'Ethiopia',
  'Fiji',
  'Finland',
  'France',
  'Gabon',
  'Gambia',
  'Georgia',
  'Germany',
  'Ghana',
  'Greece',
  'Grenada',
  'Guatemala',
  'Guinea',
  'Guinea-Bissau',
  'Guyana',
  'Haiti',
  'Holy See',
  'Honduras',
  'Hungary',
  'Iceland',
  'India',
  'Indonesia',
  'Iran',
  'Iraq',
  'Ireland',
  'Israel',
  'Italy',
  'Jamaica',
  'Japan',
  'Jordan',
  'Kazakhstan',
  'Kenya',
  'Kiribati',
  'Kuwait',
  'Kyrgyzstan',
  'Laos',
  'Latvia',
  'Lebanon',
  'Lesotho',
  'Liberia',
  'Libya',
  'Liechtenstein',
  'Lithuania',
  'Luxembourg',
  'Madagascar',
  'Malawi',
  'Malaysia',
  'Maldives',
  'Mali',
  'Malta',
  'Marshall Islands',
  'Mauritania',
  'Mauritius',
  'Mexico',
  'Micronesia',
  'Moldova',
  'Monaco',
  'Mongolia',
  'Montenegro',
  'Morocco',
  'Mozambique',
  'Myanmar',
  'Namibia',
  'Nauru',
  'Nepal',
  'Netherlands',
  'New Zealand',
  'Nicaragua',
  'Niger',
  'Nigeria',
  'North Korea',
  'North Macedonia',
  'Norway',
  'Oman',
  'Pakistan',
  'Palau',
  'Palestine State',
  'Panama',
  'Papua New Guinea',
  'Paraguay',
  'Peru',
  'Philippines',
  'Poland',
  'Portugal',
  'Qatar',
  'Romania',
  'Russia',
  'Rwanda',
  'Saint Kitts and Nevis',
  'Saint Lucia',
  'Saint Vincent and the Grenadines',
  'Samoa',
  'San Marino',
  'Sao Tome and Principe',
  'Saudi Arabia',
  'Senegal',
  'Serbia',
  'Seychelles',
  'Sierra Leone',
  'Singapore',
  'Slovakia',
  'Slovenia',
  'Solomon Islands',
  'Somalia',
  'South Africa',
  'South Korea',
  'South Sudan',
  'Spain',
  'Sri Lanka',
  'Sudan',
  'Suriname',
  'Sweden',
  'Switzerland',
  'Syria',
  'Tajikistan',
  'Tanzania',
  'Thailand',
  'Timor-Leste',
  'Togo',
  'Tonga',
  'Trinidad and Tobago',
  'Tunisia',
  'Turkey',
  'Turkmenistan',
  'Tuvalu',
  'Uganda',
  'Ukraine',
  'United Arab Emirates',
  'United Kingdom',
  'United States of America',
  'Uruguay',
  'Uzbekistan',
  'Vanuatu',
  'Venezuela',
  'Vietnam',
  'Yemen',
  'Zambia',
  'Zimbabwe',
];
