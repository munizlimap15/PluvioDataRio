library(dplyr)
library(httr)

# Create the base URL and body for the POST request
base_url <- "http://websempre.rio.rj.gov.br/dados/pluviometricos/plv/"
chromebody <- paste0("csrfmiddlewaretoken=pZOjhFqzBVeajAXAWhuNOctqSJ1GU04t&", paste0(rep(seq(1:33), length(years)), "-check=on&", paste0(rep(seq(1:33), length(years)), "-choice=", years, collapse = "&"), collapse = "&"))

# Create headers for the request
heads <- add_headers(c(
  Accept="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
  `Accept-Encoding`="gzip, deflate",
  `Accept-Language`="en-US,en;q=0.9",
  `Cache-Control`="max-age=0",
  Connection="keep-alive",
  Cookie="_ga=GA1.4.856843378.1683144629; _gid=GA1.4.1868063308.1683144629; _gat=1; BIGipServer~interno~pool_websempre_http=rd1o00000000000000000000ffff0a02df72o80; TS01a4bab6=01a427213d59269d7c5c5786c4e31eb85e255c954942cbdc35eef8018262ac13b6852857ef0c654e412681b104aa44a4962091e7352e34338e28f74cd80e4856cf86705e54; TS97dc297c027=087c8a1c25ab2001d80e586f48bcd94dd8b861f67ab2f6791bcc83cfd93a01b01d36fddcc19b973a08ae4bf3f211300008ca4399aa2b8c0ad52ff748804cba793ea0af1daa5e9b0b374cba62001313ecab8ca3cd8268dd0a9172e0dc4788c29e",
  Host="websempre.rio.rj.gov.br",
  Origin="http://websempre.rio.rj.gov.br",
  Referer="http://websempre.rio.rj.gov.br/dados/pluviometricos/plv/",
  `User-Agent`="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
))

# Loop through the years and download the data
for (year in 2000:2005) {
  # Update the body with the current year
  body <- strsplit(chromebody, "&")[[1]] %>%
    data.frame(init=.) %>%
    tidyr::separate(init, into = c("name", "value"), sep = "=") %>%
    mutate(value = ifelse(name == "1-choice", year, value)) %>%
    pull(value, name) %>%
    as.list()
  
  # Update the file name with the current year
  file_name <- paste0("D:/data_", year, ".zip")
  
  # Download the data for the current year
  post_response <- httr::POST(base_url, body = body, config = heads, httr::write_disk(path = file_name, overwrite = TRUE))
  
  # Print a message to indicate which year was downloaded
  cat("Data for year", year, "downloaded.\n")
}
                              
