# get VERSION from system date

isEmpty(VERSION) {
  win32-msvc*: {
    # 
    # Windows XP date command only has one argument, /t
    # and it can print the date in various localized formats. 
    # This code will detect MM/DD/YYYY, YYYY/MM/DD, and DD/MM/YYYY
    #
    SYSDATE = $$system(date /t)
    SYSDATE = $$replace(SYSDATE,"/",".")
    SYSDATE ~= s/[A-Za-z]*// # remove name of day
    DATE_SPLIT=$$split(SYSDATE, ".")
    DATE_X=$$member(DATE_SPLIT, 0)
    DATE_Y=$$member(DATE_SPLIT, 1)
    DATE_Z=$$member(DATE_SPLIT, 2)
    TEST1=$$find(DATE_X, [0-9]{4} )
    TEST2=$$find(DATE_Z, [0-9]{4} )

    QDATE = $$_DATE_
    QDATE_SPLIT = $$split(QDATE)
    QDAY = $$member(QDATE_SPLIT,2)
    
    !isEmpty(TEST1) { 
      contains( QDAY, $$DATE_Z ) { 
        # message("Assuming YYYY/MM/DD format")
        VERSION_YEAR = $$DATE_X 
        VERSION_MONTH = $$DATE_Y
        VERSION_DAY = $$DATE_Z
      } 
    } else {
      !isEmpty(TEST2) { 
        contains( DATE_X, $$QDAY ) {
          # message("Assuming DD/MM/YYYY format" $$DATE_X $$DATE_Y $$DATE_Z )
          VERSION_DAY = $$DATE_X
          VERSION_MONTH = $$DATE_Y
          VERSION_YEAR = $$DATE_Z
        } else {
          # message("Assuming MM/DD/YYYY format" $$DATE_X $$DATE_Y $$DATE_Z )
          VERSION_MONTH = $$DATE_X
          VERSION_DAY = $$DATE_Y
          VERSION_YEAR = $$DATE_Z
        }
      } else {
        # test1 and test2 both empty
        error("Couldn't parse Windows date. please run 'qmake VERSION=YYYY.MM.DD' with todays date")
      }
    } # isEmpty(TEST1)
    VERSION = $$VERSION_YEAR"."$$VERSION_MONTH"."$$VERSION_DAY
    # message("YMD Version:" $$VERSION)
  } else { 
    # Unix/Mac 
    VERSION = $$system(date "+%Y.%m.%d")
    VERSION_SPLIT=$$split(VERSION, ".")
    VERSION_YEAR=$$member(VERSION_SPLIT, 0)
    VERSION_MONTH=$$member(VERSION_SPLIT, 1)
    VERSION_DAY=$$member(VERSION_SPLIT, 2)
  }
}
