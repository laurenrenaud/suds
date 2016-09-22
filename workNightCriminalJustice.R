# load dplyr library for filtering
library(dplyr)

# open the file into a variable
survey.full <- read.delim("36164-0001-Data.tsv")

# simplified with less variables
# if you want to add a variable into simplified version, just add it to the list here
survey <- select(survey.full, ORI9, AGENCYID, BJS_AGENCYNAME, CITY, ZIPCODE, POP2012, FTSWORN,
                 FTCIV, PTSWORN, PTCIV, PERS_PDSW_MFT:PERS_FTS_UNK, PERS_RESP_PATRL:PERS_RESP_OTHR,
                 PERS_SUP_CHF_M:PERS_SUP_SGT_F, PAY_SAL_EXC_MAX, PAY_SAL_SGT_MIN:PAY_SAL_OFCR_MAX,
                 PAY_INCT_EDU, PAY_INCT_LANG, PAY_INCT_SD, PAY_INCT_RINC, PAY_INCT_MRT, PAY_OUT, PAY_RST_NO,
                 PAY_RST_HRS, PAY_RST_TYPE, PAY_RST_SPEC, PAY_BARG, PAY_SBARG, PAY_RMB_UNF, PAY_RMB_ARMR,
                 PAY_RMB_FIRE, PAY_FUNC_CRT, HIR_NBR_DRCT_FT, HIR_NBR_DRCT_PT, HIR_EDU_NO:HIR_EDU_OTHR, 
                 HIR_MIL, HIR_BD_VAR, HIR_SEP_LAYOFF, HIR_SEP_DIS, BDGT_TTL, BDGT_PCT_SW, COM_MIS:COM_PTNR,
                 COM_BT:COM_NBT, TECH_TYP_VPUB:TECH_EAC_MREC, TECH_WHO_EXTR:TECH_OUT_OTHR, 
                 TECH_WEB_JUR:TECH_WEB_OTHR, VEH_OPRT_MK:VEH_OPRT_UNMK, SAFE_AUTH_SOFT:SAFE_AUTH_LEG,
                 SAFE_DOC_DISF:SAFE_FINC, SAFE_FTTL, ISSU_ADDR_BIAS, ISSU_ADDR_DPV, ISSU_ADDR_TERR, ISSU_ADDR_TRAF,
                 ISSU_ADDR_DUI, ISSU_ADDR_JUV, ISSU_ADDR_GANG
                 )

# only Pennsylvania Departments, selected variables
# to get simplified varibles, switch "survey" below to "survey.full"
survey.pa <- filter(survey, STATECODE=="PA")

# only Allegheny County, selected variables
# to get simplified varibles, switch "survey" below to "survey.full"
survey.ac <- filter(survey, BJS_AGENCYNAME=="ALLEGHENY COUNTY SHERIFFS DEPT" |
                      BJS_AGENCYNAME=="ELIZABETH TWP POLICE DEPT" |
                      BJS_AGENCYNAME=="FAWN TWP POLICE DEPT" |
                      BJS_AGENCYNAME=="FOREST HILLS POLICE DEPT" | 
                      BJS_AGENCYNAME=="HEIDELBERG POLICE DEPT" |
                      BJS_AGENCYNAME=="MCKEES ROCKS POLICE DEPT" |
                      BJS_AGENCYNAME=="MOUNT OLIVER POLICE DEPT" |
                      BJS_AGENCYNAME=="OAKMONT POLICE DEPT" |
                      BJS_AGENCYNAME=="PITTSBURGH BUREAU OF POLICE" |
                      BJS_AGENCYNAME=="SOUTH FAYETTE TWP POLICE DEPT" |
                      BJS_AGENCYNAME=="SPRINGDALE BORO POLICE DEPT" |
                      BJS_AGENCYNAME=="SPRINGDALE TWP POLICE DEPT" |
                      BJS_AGENCYNAME=="TURTLE CREEK POLICE DEPT" |
                      BJS_AGENCYNAME=="WEST VIEW BOROUGH POLICE DEPT")


# If you want to export out to use Excel
write.table(survey, "survey_selected.csv", row.names = FALSE, sep=",")
write.table(survey.pa, "pennsylvania.csv", row.names = FALSE, sep=",")
write.table(survey.ac, "alleghenyCounty.csv", row.names = FALSE, sep=",")
