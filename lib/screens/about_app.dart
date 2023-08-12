import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget githubButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: ElevatedButton(
          onPressed: () async {
            HapticFeedback.mediumImpact();
            var url = Uri(
              scheme: 'https',
              host: 'github.com',
              path: '/miracleanupam/ADKosh',
            );
            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          },
          child: FaIcon(
            FontAwesomeIcons.github,
            size: 25,
          )),
    );
  }

  Widget homeButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: ElevatedButton(
          onPressed: () async {
            HapticFeedback.mediumImpact();
            var url = Uri(
              scheme: 'https',
              host: 'www.anupamdahal.com.np',
            );
            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          },
          child: FaIcon(
            FontAwesomeIcons.house,
            size: 25,
          )),
    );
  }

  Widget scrollableBody(context) {
    return Center(
      child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'यो आ्याप सिक्नको लागी बनाईएको हो । साथसाथै नेपली भाषा तथा साहित्य क्षेत्रको उत्थानमा पनि केहि योगदान पुगोस् भन्न मेरो आशा छ ।',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'पहिले बजारमा भएका आ्याप हरुमा मैले चाहेका धेरै सुविधाहरु नभएकोले आफैंले यो आ्याप बनाउने जमर्को गरेको हुँ । सोर्स कोड हेन तल दिईएको गिटगबको लिङ्कमा ट्याप गर्नुहोला ।',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'यहाँ केहि त्रुटिहरु भेट्टाउनु भयो भने गिटहबमा वा मेरो वेबसाइट मार्फत सम्पर्क गर्नुहोला । आ्यापलाई अझ राम्रो बनाउन चाहानुहुन्छ भने गिटहबमा Pull Request पठाउनु होला ।',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    
                  ],
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(child: scrollableBody(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                githubButton(),
                homeButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}
