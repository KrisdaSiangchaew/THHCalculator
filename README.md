# THHCalculator

## Background
Use ML to predict Thailand's last three digit of the first prize lottery number. The ML model was generated using Apple's CreateML framework.  Thailand 30 year historical lottery data was downloaded from the internet.

## Data Preprocessing
<p>Accuracy of the 30-year historical lottery raw data was not investigated. However, the data table itself has some mis-information that need correcting.  Some issues that I ran into when trying to directly process the original data were:</p>

<ul>
  <li>numbers in the first prize column something has fewer or more digits that actual</li>
  <li>string data that got converted to int will be incorrect when the hundredth digit is 0 -- cause data drop</li>
</ul>

<p>All data files are included in the <a href="./Data">Data</a> 
  folder of this repository. Following are file names and a brief description.</p>

### 30Y_preproc.csv
<p>This is a csv file with 739 entries of the official Thailand lottery entries from 2533 to 2563. The file 
contains Day, Month, Year, and 1St columns of the original file.  The file additionally contains 4 columns of "hundredth", 
"tenth", "oneth", and "sum" that are etracted place digits from 1St number and the sum of those digits. The file also has unnamed first column which represents the row index.</p>

### 30Y_preproc_training.csv
<p>This is 90% of randomly selected rows from "30Y_preproc.csv". This file is intended to be 
used as a training file for the ML model. Note the unnamed first column can cross-reference to the first column rows of "30Y_preproc.csv" file.</p>

### 30Y_preproc_eval.csv
<p>This is 10% of remaining rows. Note the unnamed first column can cross-reference to the first column row of "30Y_preproc.csv" file.</p>

### 30Y_preproc.json
<p>This is the same file as 30Y_preproc.csv. It is used by the iOS app for lookup of historical info.</p>

## Data Processing
Machine learning work was done through Apple's Create ML framework. The model was created using Tabular Classification method. The project file and resultant 3 models for the prediction of the 3 digit places are saved in <a href="./Model">Model</a> folder.

## Data Visualizaton
This is an on-going work to visualize the model prediction capability.

### THH Calculator (iOS App)
Project file is included here. The app has inputs for day, month, and year (in Buddhist year). The app then look up the historical 3-digits winning numbers, if there is one. The app also provide the probability that each numbers 0-9 can occur in each place of the 3-digits winning number.  

    
