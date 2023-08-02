import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  IndexScreen({super.key});

  final idx = [
    ["अ.", "अरबी"],
    ["अक.", "अकरण"],
    ["अक्रि.", "अकर्मक क्रिया"],
    ["अङ्.", "अङ्ग्रेजी"],
    ["अनौ.", "अनौपचारिक"],
    ["अमू.", "अनुकरण मूल"],
    ["अरु.", "अरुणाञ्चल"],
    ["अव.", "अवधी"],
    ["अव्य.",  "अव्यय"],
    ["अश्ली.", "अश्लील"],
    ["अस.", "असमी नेपाली"],
    ["आ.", "आगन्तुक"],
    ["आद.", "आदरार्थी"],
    ["आने.", "आधुनिक नेपाली"],
    ["इ.", "इत्यादि"],
    ["इपू.", "इसापूर्व"],
    ["इसन्", "इस्वी सन्"],
    ["इरि.", "इरिङ"],
    ["उ.", "उर्दु"],
    ["उडि.", "उडिया"],
    ["उदा.", "उदाहरण"],
    ["उप.", "उपसर्ग"],
    ["उरा.", "उराउ"],
    ["कक्रि.", "कर्मवाच्य क्रिया"],
    ["कथ्य", "कथ्य भाषा"],
    ["कि.", "किरात"],
    ["केव.", "केवरत"],
    ["को.", "कोइच"],
    ["क्रि.", "क्रिया"],
    ["क्रिवि.", "क्रियाविशेषण"],
    ["खा.", "खाम्ची"],
    ["गन्गा.", "गन्गाई"],
    ["गाखा.", "गाउँखाने कथा"],
    ["गु.", "गुरुङ"],
    ["ग्रि.", "ग्रिक"],
    ["घ.", "घले"],
    ["चिनि", "चिनिया"],
    ["चे.", "चेपाङ"],
    ["छन्त्या.", "छन्त्याल"],
    ["जर्म.", "जर्मनेली"],
    ["जापा.", "जापानी"],
    ["जि.", "जिरेल"],
    ["टु.", "टुक्का"],
    ["ता.", "तामाङ"],
    ["ताज.", "ताजपुरिया"],
    ["तिब्ब", "तिब्बती"],
    ["तिरू.", "तिर्यक् रूप"],
    ["तु.", "तुर्की"],
    ["तुल.", "तुलनीय"],
    ["थका.", "थकाली"],
    ["था.", "थारू"],
    ["दनु.", "दनुवार"],
    ["दर.", "दरबारिया"],
    ["दा.", "दार्जिलिङ"],
    ["दिव्य.", "दिव्योपदेश"],
    ["दु.", "दुरा"],
    ["देगी.", "देउडा गीत"],
    ["द्वि.", "द्वित्व"],
    ["धाबो.", "धामी बोली"],
    ["धि.", "धिमाल"],
    ["नं.‌", "नम्बर"],
    ["ना.", "नाम"],
    ["नायो.", "नामयोगी"],
    ["नि.", "निपात"],
    ["नेवा.", "नेवारी"],
    ["प.", "पहरी"],
    ["पने.", "पश्चिमी नेपाली"],
    ["पस.", "परसर्ग"],
    ["पु.", "पुलिङ्ग"],
    ["पुर्त.", "पुर्तगाली"],
    ["पूक्रि.", "पूरक क्रिया"],
    ["पूस.", "पूर्वसर्ग"],
    ["पो.", "पोथी"],
    ["प्रत्य.‌", "प्रत्यय"],
    ["प्रा.", "प्राकृत"],
    ["प्राने.", "प्राचीन नेपाली"],
    ["प्रेक्रि.", "प्रेरणार्थक क्रिया"],
    ["फा.", "फारसी"],
    ["फ्रे.", "फ्रेन्च"],
    ["बङ्.", "बङ्गाली"],
    ["बरा.", "बराम"],
    ["बव.", "बहुवचन"],
    ["बाबो.", "बालबोली"],
    ["भाइ.", "भारत इरानेली"],
    ["भाक्रि.", "भाववाच्य क्रिया"],
    ["भु.", "भुटान"],
    ["भो.", "भोटे"],
    ["भोज.", "भोजपुरी"],
    ["भोब.", "भोटबर्मेली"],
    ["मग.", "मगर"],
    ["मणि.‌", "मणिपुर"],
    ["म.", "मनाङे"],
    ["मने.", "मध्यकालीन नेपाली"],
    ["मरा.", "मराठी"],
    ["मिजो.", "मिजोरम"],
    ["मै.", "मैथिली"],
    ["या.", "याक्खा"],
    ["रा.", "राई"],
    ["राउ.", "राउटे"],
    ["राज.", "राजवंशी"],
    ["रुसी.", "रुसी"],
    ["लघु.", "लघुतावाची"],
    ["ला.", "लाक्षणिक"],
    ["लि.", "लिम्बू"],
    ["ले.", "लेप्चा"],
    ["लोको.", "लोकोक्ति"],
    ["ल्हो.", "ल्होमी/ल्होपा"],
    ["वि.", "विशेषण"],
    ["विप.", "विपरीतार्थक"],
    ["विबो.", "विस्मयादिबोधक"],
    ["विभ.", "विभक्ति"],
    ["विसं.", "विक्रम संवत्"],
    ["वै.", "वैकल्पिक"],
    ["व्या.", "व्याकरण"],
    ["शे.", "शेर्पा"],
    ["सं.", "संस्कृत"],
    ["सङ्क्षे.", "सङ्क्षेप"],
    ["सम्बो.", "सम्बोधन"],
    ["संयु.", "संयुक्त"],
    ["संयो.", "संयोजक"],
    ["सक्रि.", "सकर्मक क्रिया"],
    ["सता.", "सतार"],
    ["सर्व.", "सर्वनाम"],
    ["सहाक्रि.", "सहायक क्रिया"],
    ["सात.", "सातत्य"],
    ["सु.", "सुरेल"],
    ["सुनु.", "सुनुवार"],
    ["सुपने.", "सुदूरपश्चिम नेपाली"],
    ["स्त्री.", "स्त्रीलिङ्ग"],
    ["स्पे.", "स्पेनिस"],
    ["हा.", "हायु"],
    ["हि.", "हिन्दी"],
    ["हे.", "हेर्नुहोस्"],
    ["ह्यो.", "ह्योल्म"],
    ["+", "रूप सीमावा जोड"],
    ["-", "योजक चिह्न, निर्देशक चिह्न"],
    ["[]", "स्रोत; व्युत्पादन; प्रयोग क्षेत्र (प्रविष्टिसँग भएमा)"],
    ["()", "प्रयोग क्षेत्र (अर्थसँग भएमा), व्याख्या वा विवृति"],
    ["=", "बराबर"],
    ["/", "विभाजक वा विकल्प रूप"],
    ["<", "पछिल्लो शब्दबाट व्युत्पन्न"],
    [">", "अगिल्लो शब्दबाट व्युत्पन्न"],
    ["√", "मूल रूपको किटान"],
    [".", "सङ्क्षेपीकृत चिह्न"],
    ["~", "विशेष्य नाम (नजोडिने)"],
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("सङ्केतसूची"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: idx.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(idx[index][0], textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),),
                      // VerticalDivider(width: 20,),
                      Expanded(child: Text(idx[index][1], textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),),
                    ]
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 8,
                  endIndent: 8,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
