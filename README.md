# PluvioDataRio
## Description
### Automated R script to download pluviometric data from the "alertatio" database.
The code starts by loading the dplyr and httr libraries.
The purpose of the code is to download zip files containing pluviometric data for a range of years from a specific URL. Link: http://alertario.rio.rj.gov.br/download/dados-pluviometricos/

The first step is to create the base URL for the POST request and the body of the request. The base_url variable is a character string containing the URL to which the request will be sent. The chromebody variable is a character string that contains a CSRF token and a series of checkboxes and input fields that correspond to the years for which data is to be downloaded. This string is constructed by pasting together a repeated sequence of integers from 1 to 33 (corresponding to the number of checkboxes) with the appropriate suffixes to create the names of the input fields and checkboxes. The years variable is not defined in the code provided, but it must be a vector of the years for which data is to be downloaded. The years vector is used to set the values for the input fields.

The heads variable contains a list of HTTP headers that are sent with the POST request. These headers specify properties such as the type of data that can be accepted in the response, the language preferences of the client, and the user agent string that identifies the client. The headers also include a cookie that is used to authenticate the client with the server.

The for loop iterates over a sequence of integers from 2000 to 2005. For each iteration, the year variable is set to the current year. The code then updates the chromebody string to set the value of the input field for the current year. This is done by splitting the chromebody string into a vector of substrings using the strsplit function, converting the vector to a data frame, separating the name and value of each input field into separate columns using the tidyr::separate function, replacing the value of the appropriate input field with the current year using the mutate function, extracting the updated values as a named list using the pull function, and converting the list back to a character string using as.list().

The file_name variable is then set to a string that contains the name of the output file that will be created for the current year. The file name is constructed by pasting together a prefix, the current year, and a suffix.

Finally, the code sends a POST request to the URL specified in base_url using the updated chromebody string as the body of the request and the headers specified in heads. The response from the server is saved to the file specified by file_name using the httr::write_disk function. A message is printed to the console to indicate that the data for the current year has been downloaded.

Overall, the code is a simple example of how to use the httr library to send HTTP requests and download files. However, the code does rely on knowledge of the structure of the target website and may require modification if the website's structure changes.


![Screenshot 2023-05-04 141713](https://user-images.githubusercontent.com/16205334/236201369-08d1803f-b7e8-4f8d-ab3a-d25616ce1c78.png| width=50)

More insights here: https://stackoverflow.com/questions/76167426/rselenium-click-checkbox-files

## Usage
This is a stand alone code to download the historical rainfall database for Rio de Janeiro. Please keep in mind the request rate in the server. You may possibly define the loop in a few years interval and run it a few times, modifying the interval in the loop (see code). 

## Contributing
Fell free to contribute and customize this template as needed to fit the specifics of your project. You can add more sections, modify the headings, or include additional information as necessary.
