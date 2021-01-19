# THHCalculator

## Background
Use ML to predict Thailand's last three digit of the first prize lottery number. The ML model was generated using Apple's CreateML framework.  Thailand 30 year historical lottery data was downloaded from the internet.

## Data Preprocessing
Accuracy of the 30-year historical lottery raw data was not investigated. However, the data table itself has some mis-information that need correcting.  Some issues that I ran into when trying to directly process the original data were:
<ul>
  <li>numbers in the first prize column something has fewer or more digits that actual</li>
  <li>string data that got converted to int will be incorrect when the hundredth digit is 0 -- cause data drop</li>
</ul>
Original data were copied into csv format using Pandas. It was then split into 2 groups. They are:
<ul>
  <li></li>
</ul>
All these data files are stored in the <a href="./Data">Data</a> folder of this repository.

## Data Processing

    
