library(haven)
library(tidyverse)
derive13 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive13.sas7bdat") %>% select(c(ID,BMI01,V1DATE01,V1AGE01))
derive2_10 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive2_10.sas7bdat") %>% select(c(ID,BMI21,V2DATE21, V2AGE22))
derive37 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive37.sas7bdat") %>% select(c(ID,BMI32,V3DATE31, V3AGE31))
derive46 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive46.sas7bdat") %>% select(c(ID,BMI41,V4DATE41,V4AGE41,GENDER))
# derive52 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive52.sas7bdat") %>% select(c(ID,BMI51,V5DATE51,V5AGE51))
# derive61 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive61.sas7bdat")%>% select(c(ID,BMI61,V6DATE61,V6AGE61))
# derive71 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/derive71.sas7bdat") %>% select(c(ID,BMI71,V7DATE71,V7AGE71,GENDER,RES_DNA))
# status71 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/status71.sas7bdat")
ictder01 <- read_sas("/ddn/home2/r2725/projects/jeannette/data/ictder01.sas7bdat")

Time_BMI_data_early_life <- derive13 %>% left_join(derive2_10, by="ID") %>% left_join(derive37, by = "ID") %>% left_join(derive46, by="ID")  %>% mutate(Z_1 =0, Z_2 = as.numeric(difftime(V2DATE21,V1DATE01,units = "weeks")), Z_3 = as.numeric(difftime(V3DATE31,V1DATE01,units = "weeks")), Z_4 = as.numeric(difftime(V4DATE41,V1DATE01,units = "weeks"))) %>% select(-c(V1DATE01, V2DATE21,V3DATE31,V4DATE41)) %>% mutate(has_na = is.na(BMI01)+is.na(BMI21)+is.na(BMI32)+is.na(BMI41)) %>% left_join(ictder01, by = "ID") %>% filter(RES_DNA != "No use/storage DNA")


# Time_BMI_data_late_life <- derive52 %>% left_join(derive61, by="ID") %>% left_join(derive71, by = "ID") %>% mutate(TIME1 =12*26, TIME2 = 30*12, TIME3 = 32*12, TIME4 = 10*12) %>% mutate(Z_1=0, Z_2=as.numeric(difftime(V6DATE61,V5DATE51)), Z_3=as.numeric(difftime(V7DATE71,V5DATE51)))%>% select(-c(V5DATE51, V6DATE61,V7DATE71)) %>% mutate(has_na = is.na(BMI51)+is.na(BMI61)+is.na(BMI71)) %>% left_join(ictder01, by = "ID") %>% mutate( consent=if_else(is.na(RES_DNA.y), RES_DNA.y, RES_DNA.y)) %>% filter(consent != "No use/storage DNA")

Time_BMI_data_early_life <- Time_BMI_data_early_life %>% filter(has_na != 4)

# Time_BMI_data_late_life <- Time_BMI_data_late_life %>% filter(has_na != 3)



AA_id <- read_sas("/ddn/home2/r2725/projects/jeannette/data/id_map_pcs_aa.sas7bdat")
EA_id <- read_sas("/ddn/home2/r2725/projects/jeannette/data/id_map_pcs_ea.sas7bdat")

Time_BMI_data_early_life_AA_ID <- Time_BMI_data_early_life %>% inner_join(AA_id, by = c("ID" = "subjectid") )

Time_BMI_data_early_life_EA_ID <- Time_BMI_data_early_life %>% inner_join(EA_id, by = c("ID" = "subjectid") )

write(Time_BMI_data_early_life_AA_ID$topid, "/ddn/home2/r2725/projects/jeannette/data/AA_gwas_id.txt")
write(Time_BMI_data_early_life_EA_ID$topid, "/ddn/home2/r2725/projects/jeannette/data/EA_gwas_id.txt")


# data for early life AA
file.phe.long_early_AA <- Time_BMI_data_early_life_AA_ID %>% select(gwasid,BMI01,BMI21,BMI32,BMI41) %>% rename(ID=gwasid, Y_1=BMI01, Y_2=BMI21, Y_3 = BMI32, Y_4 = BMI41)


file.phe.time_early_AA <- Time_BMI_data_early_life_AA_ID %>% select(gwasid, Z_1:Z_4) 
file.phe.time_early_AA <- file.phe.time_early_AA%>% rename(ID=gwasid) %>% mutate(Z_1 = if_else(is.na(Z_1), median(file.phe.time_early_AA$Z_1, na.rm = TRUE), Z_1),Z_2 = if_else(is.na(Z_2), median(file.phe.time_early_AA$Z_2, na.rm = TRUE), Z_2),
	Z_3 = if_else(is.na(Z_3), median(file.phe.time_early_AA$Z_3, na.rm = TRUE), Z_3),Z_4 = if_else(is.na(Z_4), median(file.phe.time_early_AA$Z_4, na.rm = TRUE), Z_4))

file.phe.cov_early_AA <- Time_BMI_data_early_life_AA_ID %>% select(gwasid, V1AGE01,pc1:pc10) %>% rename(ID=gwasid, X_1=V1AGE01, X_2 = pc1, X_3=pc2,X_4=pc3,X_5=pc4,X_6=pc5,X_7=pc6,X_8=pc7,X_9=pc8, X_10=pc9, X_11=pc10)

file.phe.cov_early_AA <- file.phe.cov_early_AA %>% mutate(X_2 = if_else(is.na(X_2), mean(file.phe.cov_early_AA$X_2,na.rm = TRUE), X_2), X_3 = if_else(is.na(X_3), mean(file.phe.cov_early_AA$X_3,na.rm = TRUE), X_3), X_4 = if_else(is.na(X_4), 
	mean(file.phe.cov_early_AA$X_4,na.rm = TRUE), X_4), X_5 = if_else(is.na(X_5), mean(file.phe.cov_early_AA$X_5,na.rm = TRUE), X_5), X_6 = if_else(is.na(X_6), mean(file.phe.cov_early_AA$X_6,na.rm = TRUE), X_6), X_7 = if_else(is.na(X_7), 
	mean(file.phe.cov_early_AA$X_7,na.rm = TRUE), X_7), X_8 = if_else(is.na(X_8), mean(file.phe.cov_early_AA$X_8,na.rm = TRUE), X_8), X_9 = if_else(is.na(X_9), mean(file.phe.cov_early_AA$X_9,na.rm = TRUE), X_9), X_10 = if_else(is.na(X_10), 
	mean(file.phe.cov_early_AA$X_10,na.rm = TRUE), X_10), X_11 = if_else(is.na(X_11), mean(file.phe.cov_early_AA$X_11,na.rm = TRUE), X_11))
# Femail is 0, maile is 1
file.phe.long_early_AA[1:nrow(file.phe.long_early_AA),2:5] <- (is.na(file.phe.long_early_AA)[1:nrow(file.phe.long_early_AA),2:5])*rowMeans(file.phe.long_early_AA[1:nrow(file.phe.long_early_AA),2:5], na.rm=TRUE)+ 
	replace(file.phe.long_early_AA[1:nrow(file.phe.long_early_AA), 2:5], is.na(file.phe.long_early_AA[1:nrow(file.phe.long_early_AA),2:5]), rnorm(1))


write_csv(file.phe.long_early_AA, "/ddn/home2/r2725/projects/jeannette/data/file.phe.long_early_AA.csv")
write_csv(file.phe.time_early_AA, "/ddn/home2/r2725/projects/jeannette/data/file.phe.time_early_AA.csv")
write_csv(file.phe.cov_early_AA, "/ddn/home2/r2725/projects/jeannette/data/file.phe.cov_early_AA.csv")


# data for early life EA

file.phe.long_early_EA <- Time_BMI_data_early_life_EA_ID %>% select(gwasid,BMI01,BMI21,BMI32,BMI41) %>% rename(ID=gwasid, Y_1=BMI01, Y_2=BMI21, Y_3 = BMI32, Y_4 = BMI41)


file.phe.time_early_EA <- Time_BMI_data_early_life_EA_ID %>% select(gwasid, Z_1:Z_4)
file.phe.time_early_EA <- file.phe.time_early_EA%>% rename(ID=gwasid) %>% mutate(Z_1 = if_else(is.na(Z_1), median(file.phe.time_early_EA$Z_1, na.rm = TRUE), Z_1),Z_2 = if_else(is.na(Z_2), median(file.phe.time_early_EA$Z_2, na.rm = TRUE), Z_2),
        Z_3 = if_else(is.na(Z_3), median(file.phe.time_early_EA$Z_3, na.rm = TRUE), Z_3),Z_4 = if_else(is.na(Z_4), median(file.phe.time_early_EA$Z_4, na.rm = TRUE), Z_4))

file.phe.cov_early_EA <- Time_BMI_data_early_life_EA_ID %>% select(gwasid, V1AGE01,pc1:pc10) %>% rename(ID=gwasid, X_1=V1AGE01, X_2 = pc1, X_3=pc2,X_4=pc3,X_5=pc4,X_6=pc5,X_7=pc6,X_8=pc7,X_9=pc8, X_10=pc9, X_11=pc10)

file.phe.cov_early_EA <- file.phe.cov_early_EA %>% mutate(X_2 = if_else(is.na(X_2), mean(file.phe.cov_early_EA$X_2,na.rm = TRUE), X_2), X_3 = if_else(is.na(X_3), mean(file.phe.cov_early_EA$X_3,na.rm = TRUE), X_3), X_4 = if_else(is.na(X_4),
        mean(file.phe.cov_early_EA$X_4,na.rm = TRUE), X_4), X_5 = if_else(is.na(X_5), mean(file.phe.cov_early_EA$X_5,na.rm = TRUE), X_5), X_6 = if_else(is.na(X_6), mean(file.phe.cov_early_EA$X_6,na.rm = TRUE), X_6), X_7 = if_else(is.na(X_7),
        mean(file.phe.cov_early_EA$X_7,na.rm = TRUE), X_7), X_8 = if_else(is.na(X_8), mean(file.phe.cov_early_EA$X_8,na.rm = TRUE), X_8), X_9 = if_else(is.na(X_9), mean(file.phe.cov_early_EA$X_9,na.rm = TRUE), X_9), X_10 = if_else(is.na(X_10),
        mean(file.phe.cov_early_EA$X_10,na.rm = TRUE), X_10), X_11 = if_else(is.na(X_11), mean(file.phe.cov_early_EA$X_11,na.rm = TRUE), X_11))
# Femail is 0, maile is 1

#ind <- which(is.na(file.phe.long_early_EA[1:nrow(file.phe.long_early_EA),2:5]), arr.ind=TRUE)
#file.phe.long_early_EA[1:nrow(file.phe.long_early_EA),2:5][ind] <- rowMeans(file.phe.long_early_EA[1:nrow(file.phe.long_early_EA),2:5],  na.rm = TRUE)[ind[,1]] + rnorm(1)

file.phe.long_early_EA[1:nrow(file.phe.long_early_EA),2:5] <- (is.na(file.phe.long_early_EA)[1:nrow(file.phe.long_early_EA),2:5])*rowMeans(file.phe.long_early_EA[1:nrow(file.phe.long_early_EA),2:5], na.rm=TRUE)+
        replace(file.phe.long_early_EA[1:nrow(file.phe.long_early_EA), 2:5], is.na(file.phe.long_early_EA[1:nrow(file.phe.long_early_EA),2:5]), rnorm(1))

write_csv(file.phe.long_early_EA, "/ddn/home2/r2725/projects/jeannette/data/file.phe.long_early_EA.csv")
write_csv(file.phe.time_early_EA, "/ddn/home2/r2725/projects/jeannette/data/file.phe.time_early_EA.csv")
write_csv(file.phe.cov_early_EA, "/ddn/home2/r2725/projects/jeannette/data/file.phe.cov_early_EA.csv")
