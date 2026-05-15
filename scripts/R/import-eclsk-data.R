# Ram and Grimm ECLAK eclsk_dataa

#set filepath for eclsk_data file
filepath <- "https://raw.githubusercontent.com/LRI-2/Data/main/GrowthModeling/ECLS_Science.dat"
#read in the text eclsk_data file using the url() function
eclsk_data <- read.table(file=url(filepath),na.strings = ".") 

names(eclsk_data) <- c("id", "s_g3", "r_g3", "m_g3", "s_g5", "r_g5", "m_g5", "s_g8", 
                "r_g8", "m_g8", "st_g3", "rt_g3", "mt_g3", "st_g5", "rt_g5", 
                "mt_g5", "st_g8", "rt_g8", "mt_g8")

write.csv(eclsk_data, file = "data/eclsk_data.csv")

rm(filepath)
