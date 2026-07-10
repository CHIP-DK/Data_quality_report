------------------------------------------------------------------
This git repository contains the code and datafiles to produce an anonymized data quality report as described in the paper: "Real-time monitoring of REDCap data using R Markdown to increase data quality and ease quality assurance"
------------------------------------------------------------------

The anonymized data quality report (a simplified example of the one used for data quality assurance in the MISTRAL study) can be created by opening the R project file ("Project_data_quality_report.Rproj"). This should open the main R Markdown script ("R/Data_quality_report.Rmd") which can be knit to render the HTML report ("output/Data_quality_report.html").


## How to adapt report to new study

In order to adapt this framework to a new study collecting data through REDCap, the following steps should be followed:
1) API tokens should be generated for each REDCap project to be included in the report.
2) New data formatting scripts should be downloaded from REDCap and modified if new variables should be included in the report.
3) The main R Markdown script (Data_quality_report.Rmd) should be modified to the new file names from REDCap.
4) Child scripts should be modified to customize what is included in the data quality report.
5) Knit the main R Markdown script to render the modified HTML report (output/Data_quality_report.html).


## The folder contains the following files:

### Folder: Data-quality-report_Project-folder
#### R project file (the file to open when working with the project)

- QA_report_for_oublication.Rproj
---------------------------------

### Folder: data
#### Files containing the randomized and anonymized csv formatted data

- Clinical_API_download_randomised.csv
- Visits_API_download_randomised.csv
- FreezeLab_randomised.csv
- ShippedSamples_randomised.csv
---------------------------------


### Folder: R
#### Script to create the report - this is the file to open and run when you create the report

- Data_quality_report.Rmd (the document to knit)
---------------------------------


### Folder: R/formatting_scripts
#### Scripts to format the API download datasets (in this example case, the files in the data folder)

- DataFormatting_Clinical.R
- DataFormatting_Visits.R
---------------------------------


### Folder: R/child_scripts
#### Scripts to create the sub-sections (child documents) of the report - these are not run on their own

- Child_VisitsForm.Rmd (called within QA_report_main.Rmd)
- Child_ClinicalForm.Rmd (called within QA_report_main.Rmd)
- Child_SampleTracking.Rmd (called within Child_VisitsForm.Rmd)
---------------------------------


### Folder: assets
#### Files required to run the report

- MISTRAL_CSS_style.css (to create the right style of the report)
- logo-mistral-hor-hr.jpg (MISTRAL logo)
---------------------------------

### Folder: data/derived
HTML report and R data files used internally in the report

- .RData
- Visit1.Rmd
- Visit2.Rmd
---------------------------------

### Folder: output
#### The HTML data quality report

- Data_quality_report.html (the report to view)
---------------------------------

### Folder: renv
---------------------------------

---------------------------------
