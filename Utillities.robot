*** Settings ***
Library           sortcell.py
Library           ExcelLibrary
Library           String
Library           Selenium2Library
Library           DateTime
Library           OperatingSystem

*** Keywords ***
WaitElementVisible
    [Arguments]    ${locator}
    Comment    Page Should Contain Element    ${locator}
    Wait Until Element Is Visible    ${locator}    15s
    Set Selenium Implicit Wait    15s
    sleep    1s

SelectDatePicker
    [Arguments]    ${locator}    ${date}
    ${chooseMonth}    Set Variable    2
    ${arrDate}    Split String    ${date}    /
    ${m1}    Set Variable    01    มกราคม    ม.ค.
    ${m2}    Set Variable    02    กุมภาพันธ์    ก.พ.
    ${m3}    Set Variable    03    มีนาคม    มี.ค.
    ${m4}    Set Variable    04    เมษายน    เม.ย.
    ${m5}    Set Variable    05    พฤษภาคม    พ.ค.
    ${m6}    Set Variable    06    มิถนายน    มิ.ย.
    ${m7}    Set Variable    07    กรกฎาคม    ก.ค.
    ${m8}    Set Variable    08    สิงหาคม    ส.ค.
    ${m9}    Set Variable    09    กันยายน    ก.ย.
    ${m10}    Set Variable    10    ตุลาคม    ต.ค.
    ${m11}    Set Variable    11    พฤศจิกายน    พ.ย.
    ${m12}    Set Variable    12    ธันวาคม    ธ.ค.
    ${month}    Set Variable    ${m1}    ${m2}    ${m3}    ${m4}    ${m5}
    ...    ${m6}    ${m7}    ${m8}    ${m9}    ${m10}    ${m11}
    ...    ${m12}
    ${myMonth}    Set Variable    ${EMPTY}
    ${length}    Get Length    ${month}
    : FOR    ${indx}    IN RANGE    0    ${length}
    \    log to console    ${month[${indx}][0]}
    \    Run Keyword If    '${month[${indx}][0]}'!='${arrDate[1]}'    Continue For Loop
    \    ${myMonth}    Set Variable    ${month[${indx}]}
    \    Exit For Loop
    Click Element    ${locator}
    Click Element    xpath=//*[@class='ui-datepicker-month']/option[contains(text(),${myMonth[${chooseMonth}]})]
    Click Element    xpath=//*[@class='ui-datepicker-year']/option[contains(text(),${arrDate[2]})]
    Click Element    xpath=//*[@class='ui-state-default' and text()=${arrDate[0]}]

ClickElem
    [Arguments]    ${locator}
    sleep    3s
    WaitElementVisible    ${locator}
    Click Element    ${locator}
    Sleep    1s

DropdownSelect
    [Arguments]    ${locator}    ${value}
    clickelem    ${locator}/option[contains(text(),'${value}')]

DropdownSelect2
    [Arguments]    ${locator}    ${value}
    clickelem    ${locator}
    clickelem    //*[@class='ui-menu-item-wrapper' and text()='${value}']

EncodeString
    [Arguments]    ${value}
    ${bytes}    Encode String To Bytes    ${value}    utf-8
    ${text}    Decode Bytes To String    ${bytes}    utf-8

GetExcelRowData
    [Arguments]    ${Path}    ${SheetName}    ${rowIndx}
    Open Excel    ${Path}
    ${row}    Get Row Values    ${SheetName}    ${rowIndx}
    Run Keyword If    '${row[0][1]}'==''    Continue For Loop
    ${rowData}    Set Variable    ${row}
    ${sorted}    Sort Cell    ${rowData}
    [Return]    ${sorted}

ScrollTo
    [Arguments]    ${x}    ${y}
    Execute Javascript    window.scrollTo(${x},${y})

ScrollIntoView
    [Arguments]    ${elemId}
    Comment    WaitElementVisible    ${elemId}
    Execute Javascript    document.getElementById('${elemId}').scrollIntoView(true)

MyInputText
    [Arguments]    ${locator}    ${value}
    WaitElementVisible    ${locator}
    Set Focus To Element    ${locator}
    input text    ${locator}    ${value}

CheckBox
    [Arguments]    ${Id}    ${Value}
    WaitElementVisibleJs    ${Id}
    Execute Javascript    $("#${Id}").attr("checked",${Value})

Textbox
    [Arguments]    ${Id}    ${Value}
    WaitElementVisibleJs    ${Id}
    Execute Javascript    $("#${Id}").val("${Value}")

WaitElementVisibleJs
    [Arguments]    ${Id}
    Set Selenium Implicit Wait    20s
    Page Should Contain Element    //*[@id='${Id}']
    Wait Until Element Is Visible    //*[@id='${Id}']

Select Datepicker Date
    [Arguments]    ${dateElem}    ${expectedMonthYear}    ${clickElement}
    [Documentation]    Select given day from datepicker
    Input Text    ${dateElem}    ${Empty}    # open the datepicker
    ${monthyear}=    Get Datepicker MonthYear
    : FOR    ${Index}    IN RANGE    1    31
    \    Run Keyword If    '${monthyear}' == '${expectedMonthYear}'    Exit For Loop
    \    Click Link    //*/div[@id='ui-datepicker-div']//*/a[contains(@class, 'ui-datepicker-prev')]
    \    ${monthyear}=    Get Datepicker MonthYear
    Click Link    ${clickElement}

Get Datepicker MonthYear
    [Documentation]    Return current month + year from datepicker
    ${month}=    Get Element Text    //*/div[@id='ui-datepicker-div']//*/div[@class='ui-datepicker-title']/span[@class='ui-datepicker-month']
    ${year}=    Get Element Text    //*/div[@id='ui-datepicker-div']//*/div[@class='ui-datepicker-title']/span[@class='ui-datepicker-year']
    ${monthyear}=    Catenate    ${month}    ${year}
    [Return]    ${monthyear}

Random Name
    ${Name}=    Execute Javascript    return function carID(){var text=""; var possible = "ภถคตจขชฎพฑธณรนญยฐบลฅฃฤฟฆหฏกดฌษศสซวงผปฉฮอทฒมฬฦฝ"; for(var i=0; i<5; i++){text += possible.charAt(Math.random() * possible.length)}; return text;}()
    log    ${Name}
    [Return]    ${Name}

Random Telephone
    ${Tel}=    Execute Javascript    return function carID(){var text=""; var possible = "0123456789"; for(var i=0; i<8; i++){text += possible.charAt(Math.random() * possible.length)}; return text;}()
    log    ${Tel}
    [Return]    ${Tel}

Random Get chassis
    ${Cassis}=    Execute Javascript    return function carID(){var text=""; var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"; for(var i=0; i<19; i++){text += possible.charAt(Math.random() * possible.length)}; return text;}()
    log    ${Cassis}
    [Return]    ${Cassis}

Random CarId_1
    ${CarID1}=    Execute Javascript    return function carID(){var text=""; var possible = "ภถคตจขชฎฑพธณรนยญฐบลฅฃฤฟฆหฏกดฌษศสซวงผปฉฮอทมฬฝ0123456789"; for(var i=0; i<4; i++){text += possible.charAt(Math.random() * possible.length)}; return text;}()
    log    ${CarID1}
    [Return]    ${CarID1}    # ทะเบียนรถ1

Random CarId_2
    ${CarID2}=    Execute Javascript    return function carID(){var text=""; var possible = "0123456789"; for(var i=0; i<4; i++){text += possible.charAt(Math.random() * possible.length)}; return text;}()
    log    ${CarID2}
    [Return]    ${CarID2}    # ทะเบียนรถ2

Random Cityzen
    [Documentation]    Results : Get Cityzen number
    ${Cityzen}=    Execute Javascript    return function cityzen(){ var id = ""; var d1=(Math.floor(Math.random()*10)).toString(); var d2=(Math.floor(Math.random()*10)).toString(); var d3=(Math.floor(Math.random()*10)).toString(); var d4=(Math.floor(Math.random()*10)).toString(); var d5=(Math.floor(Math.random()*10)).toString(); var d6=(Math.floor(Math.random()*10)).toString(); var d7=(Math.floor(Math.random()*10)).toString(); var d8=(Math.floor(Math.random()*10)).toString(); var d9=(Math.floor(Math.random()*10)).toString(); var d10=(Math.floor(Math.random()*10)).toString(); var d11=(Math.floor(Math.random()*10)).toString(); var d12=(Math.floor(Math.random()*10)).toString(); var n13=11-(((d1*13)+(d2*12)+(d3*11)+(d4*10)+(d5*9)+(d6*8)+(d7*7)+(d8*6)+(d9*5)+(d10*4)+(d11*3)+(d12*2))%11); if(n13==10) {var d13=0;} else if(n13==11) \ {var d13=1;} else {var d13=n13;} id = d1+d2+d3+d4+d5+d6+d7+d8+d9+d10+d11+d12; return id; }()
    log    ${Cityzen}
    [Return]    ${Cityzen}    # เลขบัตรประชาชน

Random Credit
    ${Tel}=    Execute Javascript    return function carID(){var text=""; var possible = "123456789"; for(var i=0; i<16; i++){text += possible.charAt(Math.random() * possible.length)}; return text;}()
    log    ${Tel}

Get Values and Modify Spreadsheet
    Open Excel Current Directory    ExcelRobotTest.xlsx
    ${Names}=    Get Sheet Names
    Set Suite Variable    ${Names}
    ${Num}=    Get Number of Sheets
    Set Suite Variable    ${Num}
    ${Col}=    Get Column Count    TestSheet1
    ${Row}=    Get Row Count    TestSheet1
    ${ColVal}=    Get Column Values    TestSheet2    1
    ${RowVal}=    Get Row Values    TestSheet2    1
    ${Sheet}=    Get Sheet Values    DataSheet
    Log    ${Sheet}
    ${Workbook}=    Get Workbook Values    False
    Log    ${Workbook}
    ${ByName}=    Read Cell Data By Name    GraphSheet    B2
    ${ByCoords}=    Read Cell Data By Coordinates    GraphSheet    1    1
    Check Cell Type    TestSheet1    0    1
    Put Number To Cell    TestSheet1    1    1    90
    Put String To Cell    TestSheet3    1    1    yellow
    Put Date To Cell    TestSheet2    1    1    1.4.1989
    Put Date To Cell    TestSheet2    1    2    12.10.1991
    Save Excel    ${Excel_File_Path}TestExcel.xlsx

Add Date To Sheet
    Open Excel    ${Excel_File_Path}TestExcel.xlsx
    Add To Date    TestSheet2    1    2    5
    Check Cell Type    TestSheet2    1    2
    Save Excel    ${Excel_File_Path}NewDateExcel.xlsx

Perform Function and Change Date
    Open Excel    ${Excel_File_Path}NewDateExcel.xlsx
    Modify Cell With    TestSheet1    1    1    *    45
    Subtract From Date    TestSheet2    1    1    1
    Save Excel    ${Excel_File_Path}FunctionExcel.xlsx

Create a New Excel
    Create Excel Workbook    NewExcelSheet
    Save Excel    ${Excel_File_Path}NewExcel.xlsx

Add a New Sheet
    Open Excel    ${Excel_File_Path}FunctionExcel.xlsx
    Add New Sheet    ${NewSheetName}
    Save Excel    ${Excel_File_Path}NewSheetExcel.xlsx

Check New Sheet Values
    Open Excel    ${Excel_File_Path}NewSheetExcel.xlsx
    ${NewNames}=    Get Sheet Names
    ${NewNum}=    Get Number of Sheets
    Should Not Be Equal As Strings    ${Names}    ${NewNames}
    Should Not Be Equal As Integers    ${Num}    ${NewNum}
    ${Sheet}=    Get Sheet Values    TestSheet3    False
    Log    ${Sheet}
    ${stringList}=    Convert To String    ${Sheet}
    Should Contain    ${stringList}    yellow

datatimetest
    ${d}=    get time
    log    ${d}
    ${date} =    Convert Date    ${d}    result_format=%d%m%Y
    ${time}=    Convert Date    ${d}    result_format=%H.%M
    ${DATA}    Set Variable    ${date}_${time}
    Log Many    ${date}    ${time}    ${DATA}
    [Return]    ${DATA}
