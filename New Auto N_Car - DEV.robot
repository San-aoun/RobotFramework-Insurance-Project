*** Settings ***
Documentation     Modified by : Piyathida S.
...               Date : 25-10-2018
...
...               _End to End flow for IOS NEW AUTO NORMAL_
Test Teardown     Close Browser
Force Tags
Default Tags      Normal
Library           Selenium2Library
Library           BuiltIn
Library           String
Library           Collections
Library           ExcelLibrary
Library           CSVLibrary
Library           openpyxl.reader.excel
Library           ../Resource/sortcell.py
Library           DateTime
Library           OperatingSystem
Resource          ../Resource/Utillities.robot
Resource          ../Resource/commonFunction1.robot
Library           DatabaseLibrary
Resource          ../Resource/connectDatabase.robot
Resource          ../Resource/MS_IOS.robot

*** Variables ***
${USER}           
${PASSWORD}       
${URL}            
${PATH_EXCEL_New-Auto-N}    ${CURDIR}\\Template_2.E2E-IOS-New_Auto_N.xls

*** Test Cases ***
Normal_110_Cash
    [Documentation]    *STEP* :
    ...
    ...    1. IOS -> ใบเสนอราคา รถเก๋ง -> print QT (compare Data store)
    ...
    ...    2. Verify (QV) (compare Data store) -> Sale support -> Print
    ...
    ...    *RESULT* : Data QV and QT on file log
    [Tags]    เงินสด
    Open Excel    ${PATH_EXCEL_New-Auto-N}
    ${rowCnt}    Get Row Count    ข้อมูลรถเก๋ง
    : FOR    ${indx}    IN RANGE    1    ${rowCnt}
    \    #Get row from excel
    \    ${VehicleData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลรถเก๋ง    ${indx}
    \    ${CustData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลลูกค้าเก๋ง    ${indx}
    \    ${LoanData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลสินเชื่อ    ${indx}
    \    ${NewCus}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลเพิ่มลูกค้าใหม่    ${indx}
    \    #####
    \    Login    #HO
    \    ConnectDB    #connect DB DEV
    \    Comment    Click Element    107    #IOS
    \    Click Element    m_201    #ใบเสนอราคา
    \    ${car_registion1}=    Random CarId_1    #ทะเบียนหน้า
    \    ${car_registion2}=    Random CarId_2    #ทะเบียนหลัง
    \    ${ChassisNo}=    Random Get chassis    #Chassis
    \    ${Telephone}=    Random Telephone    #TelePhone
    \    ${Name}=    Random Name    #First Name
    \    ### 1. QUOTE ###
    \    Quote-ข้อมูลรถลูกค้า_Auto    ${VehicleData[0][1]}    ${VehicleData[1][1]}    ${VehicleData[2][1]}    ${VehicleData[3][1]}    ${VehicleData[4][1]}
    \    ...    ${VehicleData[5][1]}    ${car_registion1}    ${car_registion2}    ${VehicleData[10][1]}    ${VehicleData[11][1]}
    \    ...    ${VehicleData[12][1]}    ${VehicleData[13][1]}    ${CustData[30][1]}
    \    Quote-ข้อมูลผู้เอาประกัน    ${CustData[0][1]}    ${CustData[3][1]}${Name}    08${Telephone}    ${CustData[4][1]}    ${CustData[1][1]}
    \    #รายการติดตาม
    \    รายงานการติดตาม    ${CustData[3][1]}${Name}
    \    ${lead no}    Execute Javascript    return $('[onclick^=openRequestDetailHistory]').html()
    \    ${QT}    Execute Javascript    return $('[title^=QT18]').text()
    \    Comment    #Call ST & Keep R
    \    Comment    Process keep results QT    ${QT}    New Auto Normal Car_Rework\\110_Cash\\QT
    \    ### 2. IOS VERIFY ###
    \    Execute Javascript    $('[src="/img/R.png"]').click()    #Click verify
    \    Lead on IOS-Customer Information(Licence)    ${CustData[1][1]}    ${CustData[2][1]}    ${CustData[4][1]}    ${CustData[5][1]}    ${car_registion1}
    \    ...    ${car_registion2}
    \    Lead on IOS-Comparision_page
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา    ${VehicleData[9][1]}    ${ChassisNo}    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลความคุ้มครอง
    \    #ข้อมูลชำระเงิน
    \    Pay type_ เงินสด
    \    ### 3. IOS Approved###
    \    Work List    ${CustData[3][1]}${Name}
    \    verify by sale support : Rework    ${CustData[3][1]}${Name}
    \    ### 4. Rework ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()    #Open Jobs
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า_Revise    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_Revise    ${VehicleData[9][1]}    sdfsdf874987897    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Execute Javascript    $('.buttonNext').click()
    \    Sleep    2s
    \    #Save
    \    Comment    Execute Javascript    $('.buttonFinish').click()
    \    Comment    Alert Should Be Present    ยืนยันการบันทึกข้อมูล?    ACCEPT    20s
    \    Comment    Alert Should Be Present    ทำการบันทึกข้อมูลเรียบร้อย    ACCEPT    20s
    \    #ยืนยันการ revise
    \    Execute Javascript    $('#btn_wf_Confirm').click()
    \    Sleep    2s
    \    Execute Javascript    $('#txtFreeComment').val('Reworking Finished')    #comment
    \    Sleep    2s
    \    Execute Javascript    $('#btnSendWorkFlow').click()    #บันทึก
    \    Alert Should Be Present    \    ACCEPT    60s
    \    ###5. Approved ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()
    \    verify by sale support
    \    Sleep    2s
    \    Select Frame    //iframe[1]
    \    #### 6. Print ####
    \    IOS Print    ${CustData[3][1]}${Name}
    \    Disconnect From Database
    [Teardown]    # End of process

Normal_110_CV
    [Documentation]    *STEP* :
    ...
    ...    1. IOS -> ใบเสนอราคา รถเก๋ง -> print QT (compare Data store)
    ...
    ...    2. Verify (QV) (compare Data store) -> Sale support -> Print
    ...
    ...    *RESULT* : Data QV and QT on file log
    [Tags]    CV
    Open Excel    ${PATH_EXCEL_New-Auto-N}
    ${rowCnt}    Get Row Count    ข้อมูลรถเก๋ง
    : FOR    ${indx}    IN RANGE    1    ${rowCnt}
    \    #Get row from excel
    \    ${VehicleData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลรถเก๋ง    ${indx}
    \    ${CustData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลลูกค้าเก๋ง    ${indx}
    \    ${LoanData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลสินเชื่อ    ${indx}
    \    ${NewCus}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลเพิ่มลูกค้าใหม่    ${indx}
    \    #####
    \    Login    #HO
    \    ConnectDB    #connect DB DEV
    \    Comment    Click Element    107    #IOS
    \    Click Element    m_201    #ใบเสนอราคา
    \    ${car_registion1}=    Random CarId_1    #ทะเบียนหน้า
    \    ${car_registion2}=    Random CarId_2    #ทะเบียนหลัง
    \    ${ChassisNo}=    Random Get chassis    #Chassis
    \    ${Telephone}=    Random Telephone    #TelePhone
    \    ${Name}=    Random Name    #First Name
    \    ### 1. QUOTE ###
    \    Quote-ข้อมูลรถลูกค้า_Auto    ${VehicleData[0][1]}    ${VehicleData[1][1]}    ${VehicleData[2][1]}    ${VehicleData[3][1]}    ${VehicleData[4][1]}
    \    ...    ${VehicleData[5][1]}    ${car_registion1}    ${car_registion2}    ${VehicleData[10][1]}    ${VehicleData[11][1]}
    \    ...    ${VehicleData[12][1]}    ${VehicleData[13][1]}    ${CustData[30][1]}
    \    Quote-ข้อมูลผู้เอาประกัน    ${CustData[0][1]}    ${CustData[3][1]}${Name}    08${Telephone}    ${CustData[4][1]}    ${CustData[1][1]}
    \    #รายการติดตาม
    \    รายงานการติดตาม    ${CustData[3][1]}${Name}
    \    ${lead no}    Execute Javascript    return $('[onclick^=openRequestDetailHistory]').html()
    \    ${QT}    Execute Javascript    return $('[title^=QT18]').text()
    \    #Call ST & Keep R
    \    Comment    Process keep results QT    ${QT}    New Auto Normal Car_Rework\\110_CV\\QT
    \    ### 2. IOS VERIFY ###
    \    Execute Javascript    $('[src="/img/R.png"]').click()    #Click verify
    \    Lead on IOS-Customer Information(Licence)    ${CustData[1][1]}    ${CustData[2][1]}    ${CustData[4][1]}    ${CustData[5][1]}    ${car_registion1}
    \    ...    ${car_registion2}
    \    Lead on IOS-Comparision_page
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา    ${VehicleData[9][1]}    ${ChassisNo}    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลความคุ้มครอง
    \    #ข้อมูลชำระเงิน
    \    Pay type_ CV
    \    ### 3. IOS Approved###
    \    Work List    ${CustData[3][1]}${Name}
    \    verify by sale support : Rework    ${CustData[3][1]}${Name}
    \    ### 4. Rework ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()    #Open Jobs
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า_Revise    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_Revise    ${VehicleData[9][1]}    sdfsdf874987897    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Execute Javascript    $('.buttonNext').click()
    \    Send revise
    \    ###5. Approved ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()
    \    verify by sale support
    \    Sleep    3.5s
    \    Select Frame    //iframe[1]
    \    #### 6. Print ####
    \    IOS Print    ${CustData[3][1]}${Name}
    \    Disconnect From Database
    [Teardown]

Normal_110_Credit
    [Documentation]    *STEP* :
    ...
    ...    1. IOS -> ใบเสนอราคา รถเก๋ง -> print QT (compare Data store)
    ...
    ...    2. Verify (QV) (compare Data store) -> Sale support -> Print
    ...
    ...    *RESULT* : Data QV and QT on file log
    [Tags]    Credit
    Open Excel    ${PATH_EXCEL_New-Auto-N}
    ${rowCnt}    Get Row Count    ข้อมูลรถเก๋ง
    : FOR    ${indx}    IN RANGE    1    ${rowCnt}
    \    #Get row from excel
    \    ${VehicleData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลรถเก๋ง    ${indx}
    \    ${CustData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลลูกค้าเก๋ง    ${indx}
    \    ${LoanData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลสินเชื่อ    ${indx}
    \    ${NewCus}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลเพิ่มลูกค้าใหม่    ${indx}
    \    #####
    \    Login    #HO
    \    ConnectDB    #connect DB DEV
    \    Comment    Click Element    107    #IOS
    \    Click Element    m_201    #ใบเสนอราคา
    \    ${car_registion1}=    Random CarId_1    #ทะเบียนหน้า
    \    ${car_registion2}=    Random CarId_2    #ทะเบียนหลัง
    \    ${ChassisNo}=    Random Get chassis    #Chassis
    \    ${Telephone}=    Random Telephone    #TelePhone
    \    ${Name}=    Random Name    #First Name
    \    ### 1. QUOTE ###
    \    Quote-ข้อมูลรถลูกค้า_Auto    ${VehicleData[0][1]}    ${VehicleData[1][1]}    ${VehicleData[2][1]}    ${VehicleData[3][1]}    ${VehicleData[4][1]}
    \    ...    ${VehicleData[5][1]}    ${car_registion1}    ${car_registion2}    ${VehicleData[10][1]}    ${VehicleData[11][1]}
    \    ...    ${VehicleData[12][1]}    ${VehicleData[13][1]}    ${CustData[30][1]}
    \    Quote-ข้อมูลผู้เอาประกัน    ${CustData[0][1]}    ${CustData[3][1]}${Name}    08${Telephone}    ${CustData[4][1]}    ${CustData[1][1]}
    \    #รายการติดตาม
    \    รายงานการติดตาม    ${CustData[3][1]}${Name}
    \    ${lead no}    Execute Javascript    return $('[onclick^=openRequestDetailHistory]').html()
    \    ${QT}    Execute Javascript    return $('[title^=QT18]').text()
    \    #Call ST & Keep R
    \    Comment    Process keep results QT    ${QT}    New Auto Normal Car_Rework\\110_Credit\\QT
    \    ### 2. IOS VERIFY ###
    \    Execute Javascript    $('[src="/img/R.png"]').click()    #Click verify
    \    Lead on IOS-Customer Information(Licence)    ${CustData[1][1]}    ${CustData[2][1]}    ${CustData[4][1]}    ${CustData[5][1]}    ${car_registion1}
    \    ...    ${car_registion2}
    \    Lead on IOS-Comparision_page
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา    ${VehicleData[9][1]}    ${ChassisNo}    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลความคุ้มครอง
    \    #ข้อมูลชำระเงิน
    \    Paytype_Credit    ${LoanData[8][1]}
    \    ### 3. IOS Approved###
    \    Work List    ${CustData[3][1]}${Name}
    \    verify by sale support : Rework    ${CustData[3][1]}${Name}
    \    ### 4. Rework ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()    #Open Jobs
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า_Revise    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_Revise    ${VehicleData[9][1]}    sdfsdf874987897    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Execute Javascript    $('.buttonNext').click()
    \    Send revise
    \    ###5. Approved ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()
    \    verify by sale support
    \    Sleep    3.5s
    \    Select Frame    //iframe[1]
    \    #### 6. Print ####
    \    IOS Print    ${CustData[3][1]}${Name}
    \    Disconnect From Database
    [Teardown]

Normal_110_Installment
    [Documentation]    *STEP* :
    ...
    ...    1. IOS -> ใบเสนอราคา รถเก๋ง -> print QT (compare Data store)
    ...
    ...    2. Verify (QV) (compare Data store) -> Sale support -> Print
    ...
    ...    *RESULT* : Data QV and QT on file log
    [Tags]    เงินผ่อน
    Open Excel    ${PATH_EXCEL_New-Auto-N}
    ${rowCnt}    Get Row Count    ข้อมูลรถเก๋ง
    : FOR    ${indx}    IN RANGE    1    ${rowCnt}
    \    #Get row from excel
    \    ${VehicleData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลรถเก๋ง    ${indx}
    \    ${CustData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลลูกค้าเก๋ง    ${indx}
    \    ${LoanData}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลสินเชื่อ    ${indx}
    \    ${NewCus}    GetExcelRowData    ${PATH_EXCEL_New-Auto-N}    ข้อมูลเพิ่มลูกค้าใหม่    ${indx}
    \    #####
    \    Login    #HO
    \    ConnectDB    #connect DB DEV
    \    Comment    Click Element    107    #IOS
    \    Click Element    m_201    #ใบเสนอราคา
    \    ${car_registion1}=    Random CarId_1    #ทะเบียนหน้า
    \    ${car_registion2}=    Random CarId_2    #ทะเบียนหลัง
    \    ${ChassisNo}=    Random Get chassis    #Chassis
    \    ${Telephone}=    Random Telephone    #TelePhone
    \    ${Name}=    Random Name    #First Name
    \    ### 1. QUOTE ###
    \    Quote-ข้อมูลรถลูกค้า_Auto    ${VehicleData[0][1]}    ${VehicleData[1][1]}    ${VehicleData[2][1]}    ${VehicleData[3][1]}    ${VehicleData[4][1]}
    \    ...    ${VehicleData[5][1]}    ${car_registion1}    ${car_registion2}    ${VehicleData[10][1]}    ${VehicleData[11][1]}
    \    ...    ${VehicleData[12][1]}    ${VehicleData[13][1]}    ${CustData[30][1]}
    \    Quote-ข้อมูลผู้เอาประกัน    ${CustData[0][1]}    ${CustData[3][1]}${Name}    08${Telephone}    ${CustData[4][1]}    ${CustData[1][1]}
    \    #รายการติดตาม
    \    รายงานการติดตาม    ${CustData[3][1]}${Name}
    \    ${lead no}    Execute Javascript    return $('[onclick^=openRequestDetailHistory]').html()
    \    ${QT}    Execute Javascript    return $('[title^=QT18]').text()
    \    #Call ST & Keep R
    \    Comment    Process keep results QT    ${QT}    New Auto Normal Car_Rework\\110_Installment\\QT
    \    ### 2. IOS VERIFY ###
    \    Execute Javascript    $('[src="/img/R.png"]').click()    #Click verify
    \    Lead on IOS-Customer Information(Licence)    ${CustData[1][1]}    ${CustData[2][1]}    ${CustData[4][1]}    ${CustData[5][1]}    ${car_registion1}
    \    ...    ${car_registion2}
    \    Lead on IOS-Comparision_page
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา    ${VehicleData[9][1]}    ${ChassisNo}    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลความคุ้มครอง
    \    #ข้อมูลชำระเงิน
    \    Paytype_CL
    \    ### 3. IOS Approved###
    \    Work List    ${CustData[3][1]}${Name}
    \    verify by sale support : Rework    ${CustData[3][1]}${Name}
    \    ### 4. Rework ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()    #Open Jobs
    \    #ข้อมูลลูกค้า
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า_Revise    ${CustData[2][1]}    ${CustData[9][1]}    ${CustData[10][1]}    ${CustData[11][1]}    ${CustData[12][1]}
    \    ...    ${CustData[13][1]}    ${CustData[14][1]}    ${CustData[15][1]}    ${CustData[16][1]}    ${CustData[17][1]}
    \    ...    ${CustData[18][1]}    ${CustData[19][1]}    ${CustData[20][1]}    ${CustData[8][1]}
    \    #ข้อมูลใบเสนอราคา
    \    Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_Revise    ${VehicleData[9][1]}    sdfsdf874987897    ${VehicleData[11][1]}    ${VehicleData[12][1]}    ${VehicleData[13][1]}
    \    #ข้อมูลความคุ้มครอง
    \    Execute Javascript    $('.buttonNext').click()
    \    Send revise
    \    ###5. Approved ###
    \    Work List    ${CustData[3][1]}${Name}
    \    Execute Javascript    $('[src="img/external-link.png"]').click()
    \    verify by sale support
    \    Sleep    3.5s
    \    Select Frame    //iframe[1]
    \    #### 6. Print ####
    \    IOS Print    ${CustData[3][1]}${Name}
    \    Disconnect From Database
    [Teardown]

*** Keywords ***
for loop data
    FOR
