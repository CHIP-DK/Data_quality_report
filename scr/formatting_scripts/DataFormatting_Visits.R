# ------------------------------------------------
# READ AND FORMAT DATA FROM REDCap FORM Visits
# ------------------------------------------------
# This script was downloaded from REDCap and edited for purpose of the report.

# For when IPA is set up
# Visits <- API_get_data(Sys.getenv("Visits_key")) %>%

# Using randomised and anonymised dummy data set
file_dir <- "data/Visits_API_download_randomised.csv"
Visits <- read.csv(file_dir) %>%
  
  # Calculate age at enrolment
  mutate(age_at_enrolment = floor(difftime(bas_enrol_mistral_d,es_bas_birth_d,units = "days")/365.25)) %>%
  
  # Add column of centre
  mutate(centre = as.factor(sub("(...).*", "\\1", perl = TRUE, .$bas_patient))) %>%
  
  # Add column of centre name
  mutate(centre_name = as.factor(case_when(centre==103 ~ "103: Site 1",
                                           centre==110 ~ "110: Site 2",
                                           centre==143 ~ "143: Site 3",
                                           centre==230 ~ "230: Site 4",
                                           centre==260 ~ "260: Site 5",
                                           centre==270 ~ "270: Site 6",
                                           centre==280 ~ "280: Site 7",
                                           centre==300 ~ "300: Site 8",
                                           centre==305 ~ "305: Site 9",
                                           centre==309 ~ "309: Site 10",
                                           centre==310 ~ "310: Site 11",
                                           centre==315 ~ "315: Site 12",
                                           centre==330 ~ "330: Site 13",
                                           centre==400 ~ "400: Site 14",
                                           centre==402 ~ "402: Site 15",
                                           centre==410 ~ "410: Site 16",
                                           centre==412 ~ "412: Site 17",
                                           centre==506 ~ "506: Site 18",
                                           centre==508 ~ "508: Site 19",
                                           centre==545 ~ "545: Site 20",
                                           centre==600 ~ "600: Site 21",
                                           centre==604 ~ "604: Site 22",
                                           centre==705 ~ "705: Site 23",
                                           TRUE ~ "Error"))) %>%
  
  # Add column of country where clinical site is situated
  # Countries have been anonymised
  mutate(centre_country = as.factor(case_when(centre==103 ~ "Country A",
                                              centre==110 ~ "Country A",
                                              centre==143 ~ "Country A",
                                              centre==230 ~ "Country B",
                                              centre==260 ~ "Country B",
                                              centre==270 ~ "Country B",
                                              centre==280 ~ "Country B",
                                              centre==300 ~ "Country C",
                                              centre==305 ~ "Country C",
                                              centre==309 ~ "Country C",
                                              centre==310 ~ "Country C",
                                              centre==315 ~ "Country C",
                                              centre==330 ~ "Country C",
                                              centre==400 ~ "Country D",
                                              centre==402 ~ "Country D",
                                              centre==410 ~ "Country D",
                                              centre==412 ~ "Country D",
                                              centre==506 ~ "Country E",
                                              centre==508 ~ "Country E",
                                              centre==545 ~ "Country E",
                                              centre==600 ~ "Country F",
                                              centre==604 ~ "Country F",
                                              centre==705 ~ "Country G",
                                              TRUE ~ "Error"))) %>%
  
  # Add column of how many enrolments are expected per clinical site
  # Enrolment numbers have been anonymised
  mutate(centre_count = case_when(centre==103 ~ 50,
                                  centre==110 ~ 50,
                                  centre==143 ~ 75,
                                  centre==230 ~ 35,
                                  centre==260 ~ 100,
                                  centre==270 ~ 30,
                                  centre==280 ~ 35,
                                  centre==300 ~ 85,
                                  centre==305 ~ 50,
                                  centre==309 ~ 75,
                                  centre==310 ~ 25,
                                  centre==315 ~ 60,
                                  centre==330 ~ 15,
                                  centre==400 ~ 50,
                                  centre==402 ~ 25,
                                  centre==410 ~ 50,
                                  centre==412 ~ 35,
                                  centre==506 ~ 70,
                                  centre==508 ~ 10,
                                  centre==545 ~ 25,
                                  centre==600 ~ 70,
                                  centre==604 ~ 20,
                                  centre==705 ~ 35))

# Define date columns and convert to date objects
date_cols <- c("es_completed_date_a1","bas_enrol_mistral_d","es_completed_date_a1b","vis_stool_samp_rec_d_1",
               "es_samp_plasma_d_1","vis_stool_samp_col_d_1","es_bas_birth_d")
Visits <- Visits %>% mutate(across(all_of(date_cols), as.Date))

#Setting Labels
label(Visits$bas_patient)="Patient ID:"
label(Visits$redcap_event_name)="Event Name"
label(Visits$bas_enrol_mistral_d)="Date of enrolment (signed informed consent): *must provide value"
label(Visits$mist_bas_genom_cons)="Did the participant give consent to genomics analyses?"
label(Visits$patient_baseline_data_complete)="Complete?"
label(Visits$es_bas_gender)="Which gender is the participant? (this must be the same as stated on the enrolment form):"
label(Visits$es_bas_birth_d)="Date of Birth: "
label(Visits$vis_stool_samp_col_d_1)="Date of defecation for current stool sample:"
label(Visits$vis_stool_samp_rec_d_1)="Stool sample receive date at clinic:"
label(Visits$vis_stool_samp_t_1)="Stool consistency as reported by participant based on the Bristol Stool Form Scale for current sample:  View description: https://www.mdcalc.com/bristol-stool-form-scaleNote: Clicking the link will open a new window, allowing you to continue entering data."
label(Visits$vis_stool_aver_14d_t)="Average stool consistency (i.e., most frequent type of stool) based on the Bristol Stool Form Scale in the last 14 days:   View description: https://www.mdcalc.com/bristol-stool-form-scaleNote: Clicking the link will open a new window, allowing you to continue entering data."
label(Visits$vis_stool_aver_14d_fr)="Average stool frequency (times per day) within last 14 days:"
label(Visits$vis_diet_t_omni___omni)="Omnivore: both plant- and animal-based diet (choice=)"
label(Visits$vis_diet_t_pesc___pesc)="Pescatarian:  plant- and fish/seafood-based diet (i.e. a person who adds fish and seafood to a vegetarian diet) (choice=)"
label(Visits$vis_diet_t_vege___vege)="Vegetarian: plant-based diet including dairy products and eggs (choice=)"
label(Visits$vis_diet_t_vega___vega)="Vegan: solely plant-based diet (i.e. no animal products or by-products) (choice=)"
label(Visits$vis_diet_t_lact)="Does the participant have a lactose-free diet: no consumption of products with lactose?"
label(Visits$vis_diet_t_glut)="Does the participant have a gluten-free diet: no consumption of products with gluten?"
label(Visits$vis_diet_rmeat_1m_fr)="How many days per week do you eat red meat? "
label(Visits$vis_diet_fruitveg_1m_fr)="What is the average number of portions of fruit and/or vegetable that you consume per day (e.g., one bell pepper, a handful of peas or one apple)?"
label(Visits$vis_diet_dairy_1m_fr)="What is the average number of portions of dairy/milk that you consume per day (e.g., one glass or cup of yogurt or milk (200 ml) or two slices (60 g) of hard cheese or 2 spoons (25 g) of soft cheese)?"
label(Visits$vis_diet_fiber_1m_fr)="What is the average number of portions of fiber/whole grains that you consume per day (e.g., one slice wholegrain bread, ½ cup brown rice, wholegrain pasta or cereal)?"
label(Visits$vis_subs_alco_1m_fr)="What is the average number of alcoholic beverages you have had per week (one alcoholic beverage is equal to e.g., one beer (250 mL), glass of wine (110 mL), or spirit (30 mL)):"
label(Visits$vis_exercise_1m_fr)="What is your average exercise per week (in hours) the last month:       Examples of exercise:  - Aerobic: walking, running, swimming, cycling - Muscle-strengthening: strength or resistance training - Flexibility: stretching, yoga, tai chi    "
label(Visits$questionnaire_complete)="Complete?"
label(Visits$es_completed_date_a1b)="HIDDEN eCRF completed date: "
label(Visits$es_sample_stool_code_1)="Please scan the barcode or manually type the sample code for stool sample aliquot 1 below (if typing, include the dash (-))"
label(Visits$es_sample_stool_code_1_h)="Length of field es_sample_stool_code_1"
label(Visits$es_sample_stool_code_2)="Please scan the barcode or manually type the sample code for stool sample aliquot 2 below (if typing, include the dash (-))"
label(Visits$es_sample_stool_code_2_h)="Length of field es_sample_stool_code_2"
label(Visits$es_sample_stool_code_3)="Please scan the barcode or manually type the sample code for stool sample aliquot 3 below (if typing, include the dash (-))"
label(Visits$es_sample_stool_code_3_h)="Length of field es_sample_stool_code_3"
label(Visits$es_sample_stool_code_4)="Please scan the barcode or manually type the sample code for stool sample aliquot 4 below (if typing, include the dash (-))"
label(Visits$es_sample_stool_code_4_h)="Length of field es_sample_stool_code_4"
label(Visits$es_sample_stool_code_5)="Please scan the barcode or manually type the sample code for stool sample aliquot 5 below (if typing, include the dash (-))"
label(Visits$es_sample_stool_code_5_h)="Length of field es_sample_stool_code_5"
label(Visits$es_sample_stool_code_6)="Please scan the barcode or manually type the sample code for stool sample aliquot 6 below (if typing, include the dash (-))"
label(Visits$es_sample_stool_code_6_h)="Length of field es_sample_stool_code_6"
label(Visits$es_samp_plasma_d_1)="Plasma sample collection date:"
label(Visits$es_sample_plasma_code_1)="Please scan the barcode or manually type the sample code for plasma aliquot 1 below (if typing, include the dash (-))"
label(Visits$es_sample_plasma_code_1_h)="Length of field es_sample_plasma_code_1"
label(Visits$es_sample_plasma_code_2)="Please scan the barcode or manually type the sample code for plasma aliquot 2 below (if typing, include the dash (-))"
label(Visits$es_sample_plasma_code_2_h)="Length of field es_sample_plasma_code_2"
label(Visits$es_sample_plasma_code_3)="Please scan the barcode or manually type the sample code for plasma aliquot 3 below (if typing, include the dash (-))"
label(Visits$es_sample_plasma_code_3_h)="Length of field es_sample_plasma_code_3"
label(Visits$es_sample_plasma_code_4)="Please scan the barcode or manually type the sample code for plasma aliquot 4 below (if typing, include the dash (-))"
label(Visits$es_sample_plasma_code_4_h)="Length of field es_sample_plasma_code_4"
label(Visits$es_sample_plasma_code_5)="Please scan the barcode or manually type the sample code for plasma aliquot 5 below (if typing, include the dash (-))"
label(Visits$es_sample_plasma_code_5_h)="Length of field es_sample_plasma_code_5"
label(Visits$es_sample_plasma_code_6)="Please scan the barcode or manually type the sample code for plasma aliquot 6 below (if typing, include the dash (-))"
label(Visits$es_sample_plasma_code_6_h)="Length of field es_sample_plasma_code_6"
label(Visits$es_sample_wb_1_h)="Length of field es_sample_plasma_code_1"
label(Visits$es_sample_wb_2_h)="Length of field es_sample_plasma_code_2"
label(Visits$es_sample_wb_3_h)="Length of field es_sample_plasma_code_3"
label(Visits$es_sample_wb_4_h)="Length of field es_sample_plasma_code_4"
label(Visits$samples_complete)="Complete?"


#Setting Factors(will create new variable for factors)
Visits$redcap_event_name.factor = factor(Visits$redcap_event_name,levels=c("visit_1_arm_1","visit_2_arm_1"))
Visits$mist_bas_genom_cons.factor = factor(Visits$mist_bas_genom_cons,levels=c("CONS","NOCONS"))
Visits$patient_baseline_data_complete.factor = factor(Visits$patient_baseline_data_complete,levels=c("0","1","2"))
Visits$es_bas_gender.factor = factor(Visits$es_bas_gender,levels=c("1","2","3","4","5","9"))
Visits$vis_stool_samp_t_1.factor = factor(Visits$vis_stool_samp_t_1,levels=c("Type_1","Type_2","Type_3","Type_4","Type_5","Type_6","Type_7"))
Visits$vis_stool_aver_14d_t.factor = factor(Visits$vis_stool_aver_14d_t,levels=c("Type_1","Type_2","Type_3","Type_4","Type_5","Type_6","Type_7"))
Visits$vis_stool_aver_14d_fr.factor = factor(Visits$vis_stool_aver_14d_fr,levels=c("red_61","red_62","red_63","red_64","red_65","unk"))
Visits$vis_diet_t_omni___omni.factor = factor(Visits$vis_diet_t_omni___omni,levels=c("0","1"))
Visits$vis_diet_t_pesc___pesc.factor = factor(Visits$vis_diet_t_pesc___pesc,levels=c("0","1"))
Visits$vis_diet_t_vege___vege.factor = factor(Visits$vis_diet_t_vege___vege,levels=c("0","1"))
Visits$vis_diet_t_vega___vega.factor = factor(Visits$vis_diet_t_vega___vega,levels=c("0","1"))
Visits$vis_diet_t_lact.factor = factor(Visits$vis_diet_t_lact,levels=c("1","0","9"))
Visits$vis_diet_t_glut.factor = factor(Visits$vis_diet_t_glut,levels=c("1","0","9"))
Visits$vis_diet_rmeat_1m_fr.factor = factor(Visits$vis_diet_rmeat_1m_fr,levels=c("0","1_3","4_5","6_7","9"))
Visits$vis_diet_fruitveg_1m_fr.factor = factor(Visits$vis_diet_fruitveg_1m_fr,levels=c("0","1_2","3_5","6_99","9"))
Visits$vis_diet_dairy_1m_fr.factor = factor(Visits$vis_diet_dairy_1m_fr,levels=c("0","1_2","3_5","6_99","9"))
Visits$vis_diet_fiber_1m_fr.factor = factor(Visits$vis_diet_fiber_1m_fr,levels=c("0","1_2","3_5","6_99","9"))
Visits$questionnaire_complete.factor = factor(Visits$questionnaire_complete,levels=c("0","1","2"))
Visits$samples_complete.factor = factor(Visits$samples_complete,levels=c("0","1","2"))

levels(Visits$mist_bas_genom_cons.factor)=c("Yes","No")
levels(Visits$patient_baseline_data_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Visits$es_bas_gender.factor)=c("Male","Female","Transgender male","Transgender female","Other","Unknown")
levels(Visits$vis_stool_samp_t_1.factor)=c("Type 1","Type 2","Type 3","Type 4","Type 5","Type 6","Type 7")
levels(Visits$vis_stool_aver_14d_t.factor)=c("Type 1","Type 2","Type 3","Type 4","Type 5","Type 6","Type 7")
levels(Visits$vis_stool_aver_14d_fr.factor)=c("Less than every 3rd day","Every 2nd to every 3rd day","1-3 x daily","4-5 x daily","> 5 x daily","Unknown")
levels(Visits$vis_diet_t_omni___omni.factor)=c("Unchecked","Checked")
levels(Visits$vis_diet_t_pesc___pesc.factor)=c("Unchecked","Checked")
levels(Visits$vis_diet_t_vege___vege.factor)=c("Unchecked","Checked")
levels(Visits$vis_diet_t_vega___vega.factor)=c("Unchecked","Checked")
levels(Visits$vis_diet_t_lact.factor)=c("Yes","No","Unknown")
levels(Visits$vis_diet_t_glut.factor)=c("Yes","No","Unknown")
levels(Visits$vis_diet_rmeat_1m_fr.factor)=c("0","1-3","4-5","6-7","Unknown")
levels(Visits$vis_diet_fruitveg_1m_fr.factor)=c("0","1-2","3-5","> 5","Unknown")
levels(Visits$vis_diet_dairy_1m_fr.factor)=c("0","1-2","3-5","> 5","Unknown")
levels(Visits$vis_diet_fiber_1m_fr.factor)=c("0","1-2","3-5","> 5","Unknown")
levels(Visits$questionnaire_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Visits$samples_complete.factor)=c("Incomplete","Unverified","Complete")
