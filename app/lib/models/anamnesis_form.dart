class AnamnesisForm {
  bool previousAestheticTreatment;
  bool hasChildren;
  bool isBreastfeeding;
  String bowelFunction;
  String waterIntake;
  String eatingHabits;
  bool foodIntolerance;
  bool alcoholicBeverageIntake;
  bool smoking;
  String sleepQuality;
  bool physicalActivity;
  bool usesCosmetics;
  bool allergiesOrIrritations;
  bool keloid;
  bool easySkinStaining;
  bool pathologies;
  bool hormonalDisorder;
  bool usesContraceptive;
  bool usesAntidepressant;
  String medication;
  bool vitaminDeficiency;
  bool weakNailsAndHair;


  // Campos de texto livre
String skinEvaluation;
  String treatment;


  String homeProducts;



  AnamnesisForm({
 this.previousAestheticTreatment = false,


     this.hasChildren = false,


   this.isBreastfeeding = false,
 this.bowelFunction = '',


        this.waterIntake = '',


      this.eatingHabits = '',



      this.foodIntolerance = false,


       this.alcoholicBeverageIntake = false,
this.smoking = false,



       this.sleepQuality = '',


        this.physicalActivity = false,


 this.usesCosmetics = false,




       this.allergiesOrIrritations = false,




     this.keloid = false,
    this.easySkinStaining = false,




      this.pathologies = false,




       this.hormonalDisorder = false,

 this.usesContraceptive = false,



   this.usesAntidepressant = false,



    this.medication = '',


   this.vitaminDeficiency = false,


      this.weakNailsAndHair = false,



      this.skinEvaluation = "",




    this.treatment = "",
 this.homeProducts = "",



 });






 Map<String, dynamic> toMap() {


     return {


       'previousAestheticTreatment': previousAestheticTreatment,



  'hasChildren': hasChildren,



  'isBreastfeeding': isBreastfeeding,


       'bowelFunction': bowelFunction,



         'waterIntake': waterIntake,


  'eatingHabits': eatingHabits,
       'foodIntolerance': foodIntolerance,


       'alcoholicBeverageIntake': alcoholicBeverageIntake,


       'smoking': smoking,

   'sleepQuality': sleepQuality,

        'physicalActivity': physicalActivity,




          'usesCosmetics': usesCosmetics,
   'allergiesOrIrritations': allergiesOrIrritations,
 'keloid': keloid,
   'easySkinStaining': easySkinStaining,


        'pathologies': pathologies,



 'hormonalDisorder': hormonalDisorder,
      'usesContraceptive': usesContraceptive,




  'usesAntidepressant': usesAntidepressant,


        'medication': medication,

  'vitaminDeficiency': vitaminDeficiency,


     'weakNailsAndHair': weakNailsAndHair,
   'skinEvaluation': skinEvaluation,

        'treatment': treatment,
         'homeProducts': homeProducts,


     };

   }



factory AnamnesisForm.fromMap(Map<String, dynamic> map) {

 return AnamnesisForm(

       previousAestheticTreatment: map['previousAestheticTreatment'] ?? false,




  //'hasChildren': hasChildren,


      isBreastfeeding: map['isBreastfeeding'] ?? false,

  bowelFunction: map['bowelFunction'] ?? '',



   waterIntake: map['waterIntake'] ?? '',



       eatingHabits: map['eatingHabits'] ?? '',



    foodIntolerance: map['foodIntolerance'] ?? false,

     alcoholicBeverageIntake: map['alcoholicBeverageIntake'] ?? false,
       smoking: map['smoking'] ?? false,


       sleepQuality: map['sleepQuality'] ?? '',


   physicalActivity: map['physicalActivity'] ?? false,
        usesCosmetics: map['usesCosmetics'] ?? false,
       allergiesOrIrritations: map['allergiesOrIrritations'] ?? false,


        keloid: map['keloid'] ?? false,




      easySkinStaining: map['easySkinStaining'] ?? false,

pathologies: map['pathologies'] ?? false,
 hormonalDisorder: map['hormonalDisorder'] ?? false,
       usesContraceptive: map['usesContraceptive'] ?? false,
        usesAntidepressant: map['usesAntidepressant'] ?? false,

     medication: map['medication'] ?? '',
      vitaminDeficiency: map['vitaminDeficiency'] ?? false,


       weakNailsAndHair: map['weakNailsAndHair'] ?? false,
    skinEvaluation: map['skinEvaluation'] ?? '',

treatment: map['treatment'] ?? '',



       homeProducts: map['homeProducts'] ?? '',




);



  }


 }