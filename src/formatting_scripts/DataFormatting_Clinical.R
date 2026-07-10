# ------------------------------------------------
# READ AND FORMAT DATA FROM REDCap FORM Clinical
# ------------------------------------------------
# This script was downloaded from REDCap and edited for purpose of the report.


# For when API is set up
# Clinical = API_get_data(Sys.getenv("Enrolment_key")) %>%

# Using randomised and anonymised dummy data set
file_dir <- "data/Clinical_API_download_randomised.csv"
Clinical <- read.csv(file_dir) %>%
  
  # Calculate age at first positive HIV test
  mutate(age_at_hiv_1_pos = floor(as.numeric(difftime(es_lab_viro_vs_d_hiv_1_pos,bas_birth_d,units = "days"))/365.25)) %>%
  
  # Calculate age at enrolment into study
  mutate(age_at_enrolment = floor(difftime(es_completed_date_a2,bas_birth_d,units = "days")/365.25)) %>%
  
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
                                              TRUE ~ "Error")))

# Define date columns and convert to date objects
date_cols <- c("es_completed_date_a2","es_lab_viro_vs_d_hiv_1_pos","bas_birth_d","bas_frsvis_d","lab_alt_d_1",
               "es_lab_thr_d_1","lab_chol_d_1","es_lab_hba1c_d_1","es_lab_cd4_le_d_1","es_lab_cd4_artstart_d_1")
Clinical <- Clinical %>% mutate(across(all_of(date_cols), as.Date))

## Setting Labels
label(Clinical$bas_patient)="Patient ID:"
label(Clinical$es_completed_date_a2)="HIDDEN eCRF completed date:"
label(Clinical$bas_birth_d)="Date of birth:*must provide value"
label(Clinical$es_bas_gender)="Gender:*must provide value"
label(Clinical$es_lab_viro_vs_d_hiv_1_pos)="First date of documented pos HIV-1 ab test:*must provide value"
label(Clinical$section_a1_demography_and_hiv_status_complete)="Complete?"
label(Clinical$bas_frsvis_d)="First seen at the department:*must provide value"
label(Clinical$info_weight_height)="Do you have information about height and weight?"
label(Clinical$bas_heigh)="Height (in centimeters):"
label(Clinical$es_bas_weigh)="Clinical weight (in kilograms):"
label(Clinical$blood_pressure)="Has the blood pressure been measured?"
label(Clinical$vis_smoking_y)="Is the patient currently a cigarette smoker?"
label(Clinical$es_labtests_d_all)="Date ALL &nbsp (Proteinuria, ALT, AST, albumin, bilirubin, platelets, haemoglobin, INR, total cholesterol, HDL, LDL, serum triglycerides, HbA1C, plasma glucose and/or s-creatinine, total calcium, D-vitamin, phosphate) &nbsp If filled out, this date field will be used for all tests in this section and you do not need to fill in other date fields, unless different from this."
label(Clinical$es_lab_alt_y)="Has ALT (Alanine Aminotransferase) been measured?(if yes, please enter data for the most recently measured)."
label(Clinical$lab_alt_d_1)="ALT (Alanine Aminotransferase) - DATE (1):"
label(Clinical$lab_alt_v_ul_1)="ALT (Alanine Aminotransferase):"
label(Clinical$lab_alt_d_2)="@HIDDEN ALT (Alanine Aminotransferase) - DATE (2):"
label(Clinical$lab_alt_u_2)="@HIDDEN-PDF @HIDDEN ALT (Alanine Aminotransferase) - UNIT (2):"
label(Clinical$lab_alt_v_ul_2)="@HIDDEN ALT (Alanine Aminotransferase) - VALUE (2):"
label(Clinical$lab_alt_d_3)="@HIDDEN ALT (Alanine Aminotransferase) - DATE (3):"
label(Clinical$lab_alt_u_3)="@HIDDEN-PDF @HIDDEN ALT (Alanine Aminotransferase) - UNIT (3):"
label(Clinical$lab_alt_v_ul_3)="@HIDDEN ALT (Alanine Aminotransferase) - VALUE (3):"
label(Clinical$es_lab_thr_y)="Has the platelet count been measured?(if yes, please enter data for the most recently measured)"
label(Clinical$es_lab_thr_d_1)="Platelet count - DATE (1):"
label(Clinical$es_lab_thr_v_1)="Platelet count - VALUE (1):"
label(Clinical$es_lab_thr_d_2)="@HIDDEN Platelet count - DATE (2):"
label(Clinical$es_lab_thr_u_2)="@HIDDEN @HIDDEN-PDF  Platelet count - UNIT (2):"
label(Clinical$es_lab_thr_v_103mcl_2)="@HIDDEN @HIDDEN-PDF  Platelet count - VALUE (2):"
label(Clinical$es_lab_thr_v_109l_2)="@HIDDEN Platelet count - VALUE (2):"
label(Clinical$es_lab_thr_d_3)="@HIDDEN Platelet count - DATE (3):"
label(Clinical$es_lab_thr_u_3)="@HIDDEN @HIDDEN-PDF  Platelet count - UNIT (3):"
label(Clinical$es_lab_thr_v_103mcl_3)="@HIDDEN Platelet count - VALUE (3):"
label(Clinical$es_lab_thr_v_109l_3)="@HIDDEN Platelet count - VALUE (3):"
label(Clinical$es_lab_haem_inr_y)="Has the patient had haemoglobin and/or INR measured?"
label(Clinical$es_lab_haem_y)="Has the haemoglobin level been measured? (if yes, please enter data for most recently measured)"
label(Clinical$lab_haem_d_1)="Haemoglobin level - DATE:"
label(Clinical$lab_haem_u_1)="Haemoglobin level - UNIT:"
label(Clinical$lab_haem_v_mmol_1)="Haemoglobin level - VALUE:"
label(Clinical$lab_haem_v_gl_1)="Haemoglobin level - VALUE:"
label(Clinical$lab_ldl_hdl_trig_chol_y)="Has the total cholesterol, HDL, LDL and/or serum triglycerides been measured?(if yes, please enter data for most recently measured)*must provide value"
label(Clinical$lab_chol_y)="Has the total cholesterol been measured?(if yes, please enter data for the most recently measured)*must provide value"
label(Clinical$lab_chol_d_1)="Serum total cholesterol - DATE (1):*must provide value"
label(Clinical$es_lab_fa_chol_1)="Was the blood sample taken while fasting (1):*must provide value"
label(Clinical$lab_chol_u_1)="Serum total cholesterol - UNIT (1):*must provide value"
label(Clinical$lab_chol_v_mmol_1)="Serum total cholesterol - VALUE (1):*must provide value"
label(Clinical$lab_chol_v_mgdl_1)="Serum total cholesterol - VALUE (1):*must provide value"
label(Clinical$lab_chol_d_2)="@HIDDEN Serum total cholesterol - DATE (2):"
label(Clinical$es_lab_fa_chol_2)="@HIDDEN Was the blood sample taken while fasting (2):"
label(Clinical$lab_chol_u_2)="@HIDDEN Serum total cholesterol - UNIT (2):"
label(Clinical$lab_chol_v_mmol_2)="@HIDDEN Serum total cholesterol - VALUE (2):"
label(Clinical$lab_chol_v_mgdl_2)="@HIDDEN Serum total cholesterol - VALUE (2):"
label(Clinical$lab_chol_v_mgl_2)="@HIDDEN Serum total cholesterol - VALUE (2):"
label(Clinical$lab_chol_d_3)="@HIDDEN Serum total cholesterol - DATE (3):"
label(Clinical$es_lab_fa_chol_3)="@HIDDEN Was the blood sample taken while fasting (3):"
label(Clinical$lab_chol_u_3)="@HIDDEN Serum total cholesterol - UNIT (3):"
label(Clinical$lab_chol_v_mmol_3)="@HIDDEN Serum total cholesterol - VALUE (3):"
label(Clinical$lab_chol_v_mgdl_3)="@HIDDEN Serum total cholesterol - VALUE (3):"
label(Clinical$lab_chol_v_mgl_3)="@HIDDEN Serum total cholesterol - VALUE (3):"
label(Clinical$es_lab_hba1c_y)="Has HbA1c been measured?(if yes, please enter data for peak measurement)*must provide value"
label(Clinical$es_lab_hba1c_d_1)="HbA1c - DATE:*must provide value"
label(Clinical$es_lab_hba1c_u_1)="HbA1c - UNIT:*must provide value"
label(Clinical$es_lab_hba1c_v_mmolm)="HbA1c - VALUE:*must provide value"
label(Clinical$es_lab_hba1c_v_per)="HbA1c - VALUE:*must provide value"
label(Clinical$section_b1_laboratory_values_complete)="Complete?"
label(Clinical$es_lab_cd4_u_all)="CD4 - Unit ALL: &nbsp If filled out, this unit will be used for all CD4 counts in this section and you do not need to fill in other unit fields, unless different from this."
label(Clinical$es_lab_cd4_le_d_1)="Date of lowest CD4 count ever measured:*must provide value"
label(Clinical$es_lab_cd4_le_u_1)="Unit:"
label(Clinical$es_lab_cd4_le_v_cellmc_1)="Value, Cells/µl:*must provide value"
label(Clinical$es_lab_cd4_le_v_109l_1)="Value, 10^9/L:*must provide value"
label(Clinical$es_lab_cd4_artstart_d_1)="Date of CD4 count at ART initiation:*must provide value"
label(Clinical$es_lab_cd4_artstart_u_1)="Unit:"
label(Clinical$es_lab_cd4_artstart_v_109l_1)="Value, 10^9/L:*must provide value"
label(Clinical$es_lab_cd4_artstart_v_cellmc_1)="Value, Cells/µl:*must provide value"
label(Clinical$es_lab_cd4_d_1)="Date of CD4 cell measurement (1):*must provide value"
label(Clinical$es_lab_cd4_u_1)="Unit (1):"
label(Clinical$es_lab_cd4_v_cellmc_1)="Value, Cells/µl (1):*must provide value"
label(Clinical$es_lab_cd4_v_109l_1)="Value, 10^9/L (1):*must provide value"
label(Clinical$es_lab_cd4_d_2)="Date of CD4 cell measurement (2):*must provide value"
label(Clinical$es_lab_cd4_u_2)="Unit (2):"
label(Clinical$es_lab_cd4_v_cellmc_2)="Value, Cells/µl (2):*must provide value"
label(Clinical$es_lab_cd4_v_109l_2)="Value, 10^9/L (2):*must provide value"
label(Clinical$es_lab_cd4_d_3)="Date of CD4 cell measurement (3):*must provide value"
label(Clinical$es_lab_cd4_u_3)="Unit (3):"
label(Clinical$es_lab_cd4_v_cellmc_3)="Value, Cells/µl (3):*must provide value"
label(Clinical$es_lab_cd4_v_109l_3)="Value, 10^9/L (3):*must provide value"
label(Clinical$es_lab_cd4_d_4)="Date of CD4 cell measurement (4):*must provide value"
label(Clinical$es_lab_cd4_u_4)="Unit (4):"
label(Clinical$es_lab_cd4_v_cellmc_4)="Value, Cells/µl (4):*must provide value"
label(Clinical$es_lab_cd4_v_109l_4)="Value, 10^9/L (4):*must provide value"
label(Clinical$es_lab_cd4_d_5)="Date of CD4 cell measurement (5):*must provide value"
label(Clinical$es_lab_cd4_u_5)="Unit (5):"
label(Clinical$es_lab_cd4_v_cellmc_5)="Value, Cells/µl (5):*must provide value"
label(Clinical$es_lab_cd4_v_109l_5)="Value, 10^9/L (5):*must provide value"
label(Clinical$es_lab_cd4_d_6)="Date of CD4 cell measurement (6):*must provide value"
label(Clinical$es_lab_cd4_u_6)="Unit (6):"
label(Clinical$es_lab_cd4_v_cellmc_6)="Value, Cells/µl (6):*must provide value"
label(Clinical$es_lab_cd4_v_109l_6)="Value, 10^9/L (6):*must provide value"
label(Clinical$section_b2_cd4_cd8_and_hivrna_complete)="Complete?"
label(Clinical$es_lab_viro_hcvr_y)="Has the patient had HCV-RNA measured?*must provide value"
label(Clinical$es_lab_viro_hcvr_d_1)="Date (1):*must provide value"
label(Clinical$es_lab_viro_hcvr_r_1)="Result (1):*must provide value"
label(Clinical$es_lab_viro_hcvr_test_1)="Type of test (1):*must provide value"
label(Clinical$es_lab_viro_hcvr_u_1)="Unit (1):*must provide value"
label(Clinical$es_lab_viro_hcvr_v_1)="Value (1):*must provide value"
label(Clinical$es_lab_viro_hcvr_ll_1)="Detection limit (1):"
label(Clinical$es_lab_viro_hcvr_d_2)="Date (2):"
label(Clinical$es_lab_viro_hcvr_r_2)="Result (2):"
label(Clinical$es_lab_viro_hcvr_test_2)="Type of test (2):"
label(Clinical$es_lab_viro_hcvr_u_2)="Unit (2):"
label(Clinical$es_lab_viro_hcvr_v_2)="Value (2):"
label(Clinical$es_lab_viro_hcvr_ll_2)="Detection limit (2):"
label(Clinical$es_lab_viro_hcvr_d_3)="Date (3):"
label(Clinical$es_lab_viro_hcvr_r_3)="Result (3):"
label(Clinical$es_lab_viro_hcvr_test_3)="Type of test (3):"
label(Clinical$es_lab_viro_hcvr_u_3)="Unit (3):"
label(Clinical$es_lab_viro_hcvr_v_3)="Value (3):"
label(Clinical$es_lab_viro_hcvr_ll_3)="Detection limit (3):"
label(Clinical$es_lab_viro_hcvg_y)="Has the patient had HCV antigen measured?"
label(Clinical$es_lab_viro_hcvg_d_1)="Date:"
label(Clinical$es_lab_viro_hcvg_r_1)="Result:"
label(Clinical$es_lab_viro_hcvg_d_2)="Date:"
label(Clinical$es_lab_viro_hcvg_r_2)="Result:"
label(Clinical$section_b3_hepatitis_virology_and_fibrosis_screeni_complete)="Complete?"
label(Clinical$section_b4_covid19_complete)="Complete?"
label(Clinical$es_art)="Has the patient ever received antiretrovirals?*must provide value"
label(Clinical$es_art_id_oth_1)="Other, please specify(1)"
label(Clinical$es_art_id_oth_2)="Other, please specify (2)"
label(Clinical$es_art_id_oth_3)="Other, please specify (3)"
label(Clinical$es_art_id_oth_4)="Other, please specify (4)"
label(Clinical$section_c1_antiretroviral_treatment_complete)="Complete?"
label(Clinical$section_c2_medication_related_to_cardiovascular_di_complete)="Complete?"
label(Clinical$section_c3_treatment_against_hepatitis_c_complete)="Complete?"
label(Clinical$es_dis)="Any previous or new severe opportunistic infections (including AIDS defining)?*must provide value"
label(Clinical$section_d_severe_opportunistic_infections_and_sexu_complete)="Complete?"
label(Clinical$status_complete)="Complete?"


#Setting Factors(will create new variable for factors)
Clinical$es_bas_gender.factor = factor(Clinical$es_bas_gender,levels=c("1","2","3","4","5","9"))
Clinical$section_a1_demography_and_hiv_status_complete.factor = factor(Clinical$section_a1_demography_and_hiv_status_complete,levels=c("0","1","2"))
Clinical$info_weight_height.factor = factor(Clinical$info_weight_height,levels=c("0","1"))
Clinical$blood_pressure.factor = factor(Clinical$blood_pressure,levels=c("0","1"))
Clinical$vis_smoking_y.factor = factor(Clinical$vis_smoking_y,levels=c("0","1","9"))
Clinical$section_a2_basic_clinical_information_complete.factor = factor(Clinical$section_a2_basic_clinical_information_complete,levels=c("0","1","2"))
Clinical$es_lab_alt_y.factor = factor(Clinical$es_lab_alt_y,levels=c("0","1","9"))
Clinical$lab_alt_u_2.factor = factor(Clinical$lab_alt_u_2,levels=c("U_L"))
Clinical$lab_alt_u_3.factor = factor(Clinical$lab_alt_u_3,levels=c("U_L"))
Clinical$es_lab_thr_y.factor = factor(Clinical$es_lab_thr_y,levels=c("0","1","9"))
Clinical$es_lab_thr_u_2.factor = factor(Clinical$es_lab_thr_u_2,levels=c("10_3_mc_L","10_9_L"))
Clinical$es_lab_thr_u_3.factor = factor(Clinical$es_lab_thr_u_3,levels=c("10_3_mc_L","10_9_L"))
Clinical$es_lab_haem_inr_y.factor = factor(Clinical$es_lab_haem_inr_y,levels=c("0","1","9"))
Clinical$es_lab_haem_y.factor = factor(Clinical$es_lab_haem_y,levels=c("0","1","9"))
Clinical$lab_haem_u_1.factor = factor(Clinical$lab_haem_u_1,levels=c("mmol_L","g_L"))
Clinical$lab_ldl_hdl_trig_chol_y.factor = factor(Clinical$lab_ldl_hdl_trig_chol_y,levels=c("0","1","9"))
Clinical$lab_chol_y.factor = factor(Clinical$lab_chol_y,levels=c("0","1","9"))
Clinical$es_lab_fa_chol_1.factor = factor(Clinical$es_lab_fa_chol_1,levels=c("0","1","9"))
Clinical$lab_chol_u_1.factor = factor(Clinical$lab_chol_u_1,levels=c("mmol_L","mg_dL"))
Clinical$es_lab_fa_chol_2.factor = factor(Clinical$es_lab_fa_chol_2,levels=c("0","1","9"))
Clinical$lab_chol_u_2.factor = factor(Clinical$lab_chol_u_2,levels=c("mmol_L","mg_dL","mg_L"))
Clinical$es_lab_fa_chol_3.factor = factor(Clinical$es_lab_fa_chol_3,levels=c("0","1","9"))
Clinical$lab_chol_u_3.factor = factor(Clinical$lab_chol_u_3,levels=c("mmol_L","mg_dL","mg_L"))
Clinical$es_lab_hba1c_y.factor = factor(Clinical$es_lab_hba1c_y,levels=c("0","1","9"))
Clinical$es_lab_hba1c_u_1.factor = factor(Clinical$es_lab_hba1c_u_1,levels=c("mmolm","percentage"))
Clinical$section_b1_laboratory_values_complete.factor = factor(Clinical$section_b1_laboratory_values_complete,levels=c("0","1","2"))
Clinical$es_lab_cd4_u_all.factor = factor(Clinical$es_lab_cd4_u_all,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_le_u_1.factor = factor(Clinical$es_lab_cd4_le_u_1,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_artstart_u_1.factor = factor(Clinical$es_lab_cd4_artstart_u_1,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_u_1.factor = factor(Clinical$es_lab_cd4_u_1,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_u_2.factor = factor(Clinical$es_lab_cd4_u_2,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_u_3.factor = factor(Clinical$es_lab_cd4_u_3,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_u_4.factor = factor(Clinical$es_lab_cd4_u_4,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_u_5.factor = factor(Clinical$es_lab_cd4_u_5,levels=c("cells_mcl","10_9_L"))
Clinical$es_lab_cd4_u_6.factor = factor(Clinical$es_lab_cd4_u_6,levels=c("cells_mcl","10_9_L"))
Clinical$section_b2_cd4_cd8_and_hivrna_complete.factor = factor(Clinical$section_b2_cd4_cd8_and_hivrna_complete,levels=c("0","1","2"))
Clinical$es_lab_viro_hcvr_y.factor = factor(Clinical$es_lab_viro_hcvr_y,levels=c("0","1","9"))
Clinical$es_lab_viro_hcvr_r_1.factor = factor(Clinical$es_lab_viro_hcvr_r_1,levels=c("1","0","9"))
Clinical$es_lab_viro_hcvr_test_1.factor = factor(Clinical$es_lab_viro_hcvr_test_1,levels=c("1","2"))
Clinical$es_lab_viro_hcvr_u_1.factor = factor(Clinical$es_lab_viro_hcvr_u_1,levels=c("copies_mL","IU_mL"))
Clinical$es_lab_viro_hcvr_r_2.factor = factor(Clinical$es_lab_viro_hcvr_r_2,levels=c("1","0","9"))
Clinical$es_lab_viro_hcvr_test_2.factor = factor(Clinical$es_lab_viro_hcvr_test_2,levels=c("1","2"))
Clinical$es_lab_viro_hcvr_u_2.factor = factor(Clinical$es_lab_viro_hcvr_u_2,levels=c("copies_mL","IU_mL"))
Clinical$es_lab_viro_hcvr_r_3.factor = factor(Clinical$es_lab_viro_hcvr_r_3,levels=c("1","0","9"))
Clinical$es_lab_viro_hcvr_test_3.factor = factor(Clinical$es_lab_viro_hcvr_test_3,levels=c("1","2"))
Clinical$es_lab_viro_hcvr_u_3.factor = factor(Clinical$es_lab_viro_hcvr_u_3,levels=c("copies_mL","IU_mL"))
Clinical$es_lab_viro_hcvg_y.factor = factor(Clinical$es_lab_viro_hcvg_y,levels=c("0","1","9"))
Clinical$es_lab_viro_hcvg_r_1.factor = factor(Clinical$es_lab_viro_hcvg_r_1,levels=c("1","0","9"))
Clinical$es_lab_viro_hcvg_r_2.factor = factor(Clinical$es_lab_viro_hcvg_r_2,levels=c("1","0","9"))
Clinical$section_b3_hepatitis_virology_and_fibrosis_screeni_complete.factor = factor(Clinical$section_b3_hepatitis_virology_and_fibrosis_screeni_complete,levels=c("0","1","2"))
Clinical$section_b4_covid19_complete.factor = factor(Clinical$section_b4_covid19_complete,levels=c("0","1","2"))
Clinical$es_art.factor = factor(Clinical$es_art,levels=c("0","1","9"))
Clinical$section_c1_antiretroviral_treatment_complete.factor = factor(Clinical$section_c1_antiretroviral_treatment_complete,levels=c("0","1","2"))
Clinical$section_c2_medication_related_to_cardiovascular_di_complete.factor = factor(Clinical$section_c2_medication_related_to_cardiovascular_di_complete,levels=c("0","1","2"))
Clinical$section_c3_treatment_against_hepatitis_c_complete.factor = factor(Clinical$section_c3_treatment_against_hepatitis_c_complete,levels=c("0","1","2"))
Clinical$es_dis.factor = factor(Clinical$es_dis,levels=c("0","1","9"))
Clinical$section_d_severe_opportunistic_infections_and_sexu_complete.factor = factor(Clinical$section_d_severe_opportunistic_infections_and_sexu_complete,levels=c("0","1","2"))
Clinical$status_complete.factor = factor(Clinical$status_complete,levels=c("0","1","2"))

levels(Clinical$es_bas_gender.factor)=c("Male","Female","Transgender male","Transgender female","Other","Unknown")
levels(Clinical$section_a1_demography_and_hiv_status_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$info_weight_height.factor)=c("No","Yes")
levels(Clinical$blood_pressure.factor)=c("No","Yes")
levels(Clinical$vis_smoking_y.factor)=c("No","Yes","Unknown")
levels(Clinical$section_a2_basic_clinical_information_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$es_lab_alt_y.factor)=c("No","Yes","Unknown")
levels(Clinical$lab_alt_u_2.factor)=c("IU/L (also called U/L or mU/mL)")
levels(Clinical$lab_alt_u_3.factor)=c("IU/L (also called U/L or mU/mL)")
levels(Clinical$es_lab_thr_y.factor)=c("No","Yes","Unknown")
levels(Clinical$es_lab_thr_u_2.factor)=c("10^3/µL","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_thr_u_3.factor)=c("10^3/µL","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_haem_inr_y.factor)=c("No","Yes","Unknown")
levels(Clinical$es_lab_haem_y.factor)=c("No","Yes","Unknown")
levels(Clinical$lab_haem_u_1.factor)=c("mmol/L","g/L")
levels(Clinical$lab_ldl_hdl_trig_chol_y.factor)=c("No","Yes","Unknown")
levels(Clinical$lab_chol_y.factor)=c("No","Yes","Unknown")
levels(Clinical$es_lab_fa_chol_1.factor)=c("No","Yes","Unknown")
levels(Clinical$lab_chol_u_1.factor)=c("mmol/L","mg/dL")
levels(Clinical$es_lab_fa_chol_2.factor)=c("No","Yes","Unknown")
levels(Clinical$lab_chol_u_2.factor)=c("mmol/L","mg/dL","mg/L")
levels(Clinical$es_lab_fa_chol_3.factor)=c("No","Yes","Unknown")
levels(Clinical$lab_chol_u_3.factor)=c("mmol/L","mg/dL","mg/L")
levels(Clinical$es_lab_hba1c_y.factor)=c("No","Yes","Unknown")
levels(Clinical$es_lab_hba1c_u_1.factor)=c("mmol/mol","%")
levels(Clinical$section_b1_laboratory_values_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$es_lab_cd4_u_all.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_le_u_1.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_artstart_u_1.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_u_1.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_u_2.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_u_3.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_u_4.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_u_5.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$es_lab_cd4_u_6.factor)=c("Cells/µl (also called Cells/mm3)","10^9/L (also called cells/nL or G/L)")
levels(Clinical$section_b2_cd4_cd8_and_hivrna_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$es_lab_viro_hcvr_y.factor)=c("No","Yes","Unknown")
levels(Clinical$es_lab_viro_hcvr_r_1.factor)=c("Positive","Negative","Unknown")
levels(Clinical$es_lab_viro_hcvr_test_1.factor)=c("Quantitative","Qualitative")
levels(Clinical$es_lab_viro_hcvr_u_1.factor)=c("Copies/mL","IU/mL")
levels(Clinical$es_lab_viro_hcvr_r_2.factor)=c("Positive","Negative","Unknown")
levels(Clinical$es_lab_viro_hcvr_test_2.factor)=c("Quantitative","Qualitative")
levels(Clinical$es_lab_viro_hcvr_u_2.factor)=c("Copies/mL","IU/mL")
levels(Clinical$es_lab_viro_hcvr_r_3.factor)=c("Positive","Negative","Unknown")
levels(Clinical$es_lab_viro_hcvr_test_3.factor)=c("Quantitative","Qualitative")
levels(Clinical$es_lab_viro_hcvr_u_3.factor)=c("Copies/mL","IU/mL")
levels(Clinical$es_lab_viro_hcvg_y.factor)=c("No","Yes","Unknown")
levels(Clinical$es_lab_viro_hcvg_r_1.factor)=c("Positive","Negative","Unknown")
levels(Clinical$es_lab_viro_hcvg_r_2.factor)=c("Positive","Negative","Unknown")
levels(Clinical$section_b3_hepatitis_virology_and_fibrosis_screeni_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$section_b4_covid19_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$es_art.factor)=c("No","Yes","Unknown")
levels(Clinical$section_c1_antiretroviral_treatment_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$section_c2_medication_related_to_cardiovascular_di_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$section_c3_treatment_against_hepatitis_c_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$es_dis.factor)=c("No","Yes","Unknown")
levels(Clinical$section_d_severe_opportunistic_infections_and_sexu_complete.factor)=c("Incomplete","Unverified","Complete")
levels(Clinical$status_complete.factor)=c("Incomplete","Unverified","Complete")

