*** Settings ***
Library           Selenium2Library
Library           sortcell.py
Library           ExcelLibrary
Library           String
Library           Selenium2Library
Resource          ../Resource/Utillities.robot

*** Keywords ***
Login
    Open Browser    ${URL}    Chrome
    Input Text    //input[@type='text'][@name='UserName']    ${USER}
    Input Password    //input[@type='password'][@name='Password']    ${PASSWORD}
    ClickElem    //button[text()='Sign in']

Login_IOS-Branch
    ###Login
    Open Browser    ${URL}    gc
    Input Text    //input[@type='text'][@name='UserName']    
    Input Password    //input[@type='password'][@name='Password']    
    ClickElem    //button[text()='Sign in']

Login_IOS-Admin(Sale support)
    ###Login
    Open Browser    ${URL}    gc
    Input Text    //input[@type='text'][@name='UserName']    
    Input Password    //input[@type='password'][@name='Password']    
    ClickElem    //button[text()='Sign in']

Upsale_เลือกผลิตภัณฑ์
    #เลือกปุ่มอัพเซล
    sleep    1s
    Click Element    imgPdtGroupKey8
    sleep    3s
    ScrollIntoView    wizard
    sleep    3s
    ClickElem    xpath=//img[contains(@src,'img/product/SCI.png')]
    sleep    3s
    ClickElem    xpath=//img[contains(@src,'img/product/PA50.png')]
    Comment    Upsale_History

Upsale_รายละเอียดผลิตภัณฑ์
    Sleep    2s
    Click Element    xpath=//*[@id="step-3"]/table/tbody/tr[1]/td/div/table/tbody/tr[1]/td[4]/button
    Sleep    2s
    ClickElem    btnCheckInfo
    sleep    2s
    Alert Should Be Present    \    ACCEPT

Upsale_History
    Wait Until Page Contains    History
    Select Frame    //iframe[1]
    sleep    2s
    Comment    Comment    ClickElem    //*[@id='grid']/div[2]/table/tbody/tr/td[1]
    Click Element    xpath=//*[@id="ctl00_RadAjaxPanel"]/table/tbody/tr/td[3]/button

Upsale_ชำระค่าเบี้ยประกัน
    [Documentation]    - *ชำระเบี้ยประกัน* ในกรณีกำหนดค่า Promotion
    Click Element    //*[@class='buttonNext']
    sleep    2s
    ClickElem    //*[@id="sumary_panel"]/table/tbody/tr[7]/td[2]/span/span/span[2]/span
    Comment    ClickElem    //*[@id="ddlPayType_listbox"]/li[contains(text(),'Promotion')]
    ClickElem    //*[@id="divPayTypeOptions"]/button
    sleep    3s
    #Campaign Option(กรอกข้อมูล)
    ClickElem    //*[@id="tblCampaign"]/tbody/tr[2]/td[2]/span/span/span[2]/span
    sleep    5s
    Click Element    //*[@id="ddlPromotion_listbox"]/li[2]
    #click OK
    Click Element    //*[@id="tblCampaign"]/tbody/tr[7]/td/button[1]
    Sleep    2s
    ClickElem    xpath=//*[@id="sumary_panel"]/table/tbody/tr[11]/td[2]/span
    #เสร็จสิ้น
    ClickElem    xpath=//*[@id="wizard"]/div[2]/a[1]
    ClickElem    xpath=//span[contains(text(),'OK')]

WorkList-print
    [Arguments]    ${print_ID}
    [Documentation]    - ขั้นตอน print เพื่อจบงาน
    Click element    ${print_ID}
    sleep    2s
    Click element    xpath=//span[contains(text(),'OK')]
    sleep    2s

Menu_Cancel Document
    [Arguments]    ${RunningNo}
    [Documentation]    1. ทำการค้นหาเลข Running No.
    ...    2. กดยืนยันการยกเลิกเอกสาร
    Select Frame    //iframe[1]
    Input Text    RunningNo    ${RunningNo}
    Click Element    xpath=//*[@id="ctl00_RadAjaxPanel"]/div[2]/table/tbody/tr/td[3]/button
    #ยืนยันการยกเลิกเอกสาร
    Mouse Over    css=button.btn.btn-inverse
    Mouse Out    css=button.btn.btn-inverse
    sleep    3s
    Click Element    btnCancelDoc
    ClickElem    xpath=//span[contains(text(),'OK')]
    Wait Until Page Contains    การยกเลิกเอกสารเสร็จเรียบร้อย
    ClickElem    xpath=//span[contains(text(),'OK')]

Menu_Cancel Overdue Document
    [Arguments]    ${RunningNo}
    [Documentation]    1. ทำการค้นหาเลข Running No.
    ...    2. กดยืนยันการยกเลิกเอกสาร
    ...
    ...    Pass .153
    Select Frame    //iframe[1]
    Input Text    RunningNo    ${RunningNo}
    Click Element    xpath=//*[@id="ctl00_RadAjaxPanel"]/div[2]/table/tbody/tr/td[3]/button
    Wait Until Page Contains    คุณกำลังทำรายการยกเลิกข้ามวันโปรดตรวจสอบ
    sleep    3s
    Alert Should Be Present    \    ACCEPT
    #ยืนยันการยกเลิกเอกสาร
    Mouse Over    css=button.btn.btn-inverse
    Mouse Out    css=button.btn.btn-inverse
    sleep    3s
    Click Element    btnCancelDoc
    ClickElem    xpath=//span[contains(text(),'OK')]
    Wait Until Page Contains    การยกเลิกเอกสารเสร็จเรียบร้อย
    ClickElem    xpath=//span[contains(text(),'OK')]

IOS-CCS
    [Arguments]    ${Card_ID}    ${Name_customer}    ${Lastname_customer}
    sleep    3s
    Select Frame    //iframe[1]
    Input Text    txtCitizenId    ${Card_ID}
    Comment    Click Element    ctl00_ContentPlaceHolder1_ucPersonCCS1_ddlTitle_Arrow
    Comment    Click Element    //*[@id="ctl00_ContentPlaceHolder1_ucPersonCCS1_ddlTitle_DropDown"]/div/ul/li[3]
    Input Text    txtFirstName    ${Name_customer}
    Input Text    txtLastName    ${Lastname_customer}
    ClickElem    ContentPlaceHolder1_btnSearch

IOS-สมัครผลิตภัณฑ์ประกัยภัย
    [Arguments]    ${relation_person}
    Click Element    //input[@value='สมัครผลิตภัณฑ์ประกันภัย']
    #IOS page
    Execute Javascript    $('#Checkbox2').click()
    Execute Javascript    $('.buttonNext').click()
    Upsale_เลือกผลิตภัณฑ์
    Upsale_รายละเอียดผลิตภัณฑ์
    Input Text    Field65    ${relation_person}
    Click Element    //*[@class='buttonNext']
    Upsale-ชำระค่าเบี้ยประกัน    2000
    WorkList-print    ctl00_ContentPlaceHolder1_RadGrid1_ctl00_ctl06_gbccolumn2

Auto_Special_รถอื่นๆ
    [Arguments]    ${registion}    ${car_type}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    #ประเภทรถ
    Click Element    //option[contains(text(),'${car_type}')]
    Click Element    //option[contains(text(),'${registion}')]
    ##ข้อมูลประกัน##
    Sleep    3s
    Click Element    //*[@id="chk-all-instab1SMK"]
    Sleep    3s
    ScrollIntoView    group-input-car-brandtab1
    #ยี่ห้อ
    Sleep    5s
    Click Element    //*[@id="group-input-car-brandtab1"]/div/span/span
    Click Element    xpath=//div[contains(text(),'${brand}')]
    #รุ่น
    Click Element    //*[@id="group-input-car-modeltab1"]/div/span/span
    Click Element    //div[contains(text(),'${model}')]
    #วันจดทะเบียน
    Click Element    //option[contains(text(),'${year}')]
    #รุ่นย่อย
    Click Element    //*[@id="group-input-car-model-subtab1"]/div/span/span
    Click Element    //div[contains(text(),'${sub_model}')]
    #เลขทะเบียน
    Input Text    input-regis-no-pretab1    ${car_registion1}
    Input Text    input-regis-no-posttab1    ${car_registion2}
    #จังหวัด
    Click Element    xpath=//option[contains(text(),'กรุงเทพมหานคร')]
    #เลขตัวถัง
    Input Text    input-chassis-notab1    ${Engin_no}
    #เลขเครื่องยนต์
    Input Text    input-engine-notab1    ${Engin_no2}
    #ขนาดเครื่องยนต์
    Input Text    input-engine-sizetab1    ${size_engin}
    #น้ำหนักรวม
    Input Text    input-weighttab1    ${weight}
    Sleep    5s
    ScrollIntoView    sizeTotal_tab1
    #Attach File
    Choose File    xpath=//*[@id="file01tab1"]    ${CURDIR}\\pic01.jpg
    Input Text    comment_file01tab1    สำเนาบัตรประชาชน
    Choose File    xpath=//*[@id="file02tab1"]    ${CURDIR}\\pic02.jpg
    Input Text    comment_file02tab1    สำเนาเล่มทะเบียน
    Choose File    xpath=//*[@id="file03tab1"]    ${CURDIR}\\pic03.jpg
    Input Text    comment_file03tab1    รูปหน้ารถ
    Choose File    xpath=//*[@id="file04tab1"]    ${CURDIR}\\pic04.jpg
    Input Text    comment_file04tab1    รูปหลังรถ
    Choose File    xpath=//*[@id="file05tab1"]    ${CURDIR}\\pic05.jpg
    Input Text    comment_file05tab1    รูปด้านขวา
    Choose File    xpath=//*[@id="file06tab1"]    ${CURDIR}\\pic06.jpg
    Input Text    comment_file06tab1    รูปด้านซ้าย
    #remark
    Input Text    input-remark    Day2 Specail เก๋ง 110 Case 1

Auto_Special_รถบรรทุก_หัวลาก
    [Arguments]    ${registion}    ${car_type}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    [Tags]    รถบรรทุก
    log Many
    #ประเภทรถ
    sleep    2s
    Click Element    //option[contains(text(),'${car_type}')]
    Click Element    //option[contains(text(),'${registion}')]
    #ใบเสนอราคา1
    ##ข้อมูลประกัน##
    Sleep    2s
    Click Element    //*[@id="chk-all-instab1SMK"]
    Sleep    2s
    รถบรรทุก_ใบเสนอราคา1    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    ...    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    #ใบเสนอราคา2
    Comment    Wait Until Element Is Visible    li-tab2
    Comment    รถบรรทุก_ใบเสนอราคา2    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}
    ...    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    ##Save##
    Execute Javascript    $('#btn-save').click()
    #remark
    Input Text    input-remark    Day2 Specail บรรทุก 320 Case 1

Auto_Special_รถบรรทุก_หางพ่วง
    [Arguments]    ${registion}    ${car_type}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    ...    ${license_trailer}
    #ประเภทรถ
    sleep    5s
    Click Element    //option[contains(text(),'${car_type}')]
    Click Element    //option[contains(text(),'${registion}')]
    #ใบเสนอราคา1
    Comment    Execute Javascript    window.scrollTo(0,2000)
    Sleep    2s
    ScrollIntoView    tab1_chk-ins_BKI_MINC0000001
    Sleep    2s
    Click Element    tab1_chk-ins_SMK_MINC0000001
    Sleep    3s
    รถบรรทุก_ใบเสนอราคา1    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    ...    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    #หางพ่วง
    รถบรรทุก_หางพ่วง    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    ...    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}    ${license_trailer}
    ##Save##
    Execute Javascript    $('#btn-save').click()

รถบรรทุก_หางพ่วง
    [Arguments]    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    ...    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}    ${license_trailer}
    ###เลขทะเบียนหาง####
    ${lis1}    Get Substring    ${license_trailer}    \    3
    ${getlis2}    Get Substring    ${license_trailer}    3
    ${lis2}    Strip String    ${getlis2}
    ##########
    #ยี่ห้อ
    Click Element    li-subtab2tab1
    Comment    Execute Javascript    $('#li-subtab2tab1').click()
    Sleep    2s
    Click Element    //*[@id="group-input-car-brandsubtab2tab1"]/div/span/span
    Sleep    2s
    ${getBrandID}    Execute Javascript    return $($('#ui-id-3 div:contains("${brand}")')).attr("id")
    Click Element    ${getBrandID}
    Sleep    2s
    #รุ่น
    Execute Javascript    $("#input-car-modelsubtab2tab1").val('${model}')
    Execute Javascript    $("#txt-input-car-modelsubtab2tab1").val($("#input-car-modelsubtab2tab1 :selected").text())
    #รุ่นย่อย
    Execute Javascript    $("#input-car-modelsubtab2tab1").trigger('change')
    Execute Javascript    $('#input-car-model-subsubtab2tab1 option').filter(function () { return $(this).html() == "${sub_model}"; }).attr('selected', 'selected');
    Execute Javascript    $("#txt-input-car-model-subsubtab2tab1").val($('#input-car-model-subsubtab2tab1 :selected').text())
    #วันจดทะเบียน
    Click Element    //*[@id="input-register-yearsubtab2tab1"]/option[contains(text(),'${year}')]
    #เลขทะเบียน
    Input Text    input-regis-no-presubtab2tab1    ${lis1}
    Input Text    input-regis-no-postsubtab2tab1    ${lis2}
    #จังหวัด
    Execute Javascript    $('#input-provincesubtab2tab1').val('1')
    #เลขตัวถัง
    Input Text    input-chassis-nosubtab2tab1    ${Engin_no}
    Execute Javascript    window.scrollTo(0,2000)
    ScrollIntoView    input-weightsubtab2tab1
    #ลักษณะการใช้งาน
    Execute Javascript    $('#input-use-casesubtab2tab1').val('07')    #บรรทุกของที่มีความเสี่ยงสูง
    #น้ำหนักรวม
    Input Text    input-weightsubtab2tab1    ${weight}
    Execute Javascript    $('#input-car-model-subsubtab2tab1 option').filter(function () { return $(this).html() == "${sub_model}"; }).attr('selected', 'selected');
    Sleep    5s
    Comment    Alert Should Be Present    \    ACCEPT

Quote-ข้อมูลผู้เอาประกัน
    [Arguments]    ${customer_type}    ${name}    ${tele_No}    ${Lname}    ${Id}
    Run Keyword If    '${customer_type}'=='บุคคลธรรมดา'    Quote-ข้อมูลผู้เอาประกัน_บุคคลธรรมดา    ${customer_type}    ${name}    ${tele_No}    ${Lname}
    ...    ${Id}
    Run Keyword If    '${customer_type}'=='นิติบุคคล'    Quote-ข้อมูลผู้เอาประกัน_นิติบุคคล    ${customer_type}    ${name}    ${tele_No}    ${Lname}
    ...    ${Id}
    Alert Should Be Present    \    ACCEPT    120s

Quote-ข้อมูลผู้เอาประกัน_บุคคลธรรมดา
    [Arguments]    ${customer_type}    ${name}    ${tele_No}    ${Lname}    ${Id}
    #Input Info
    Sleep    0.5s
    Execute Javascript    window.scrollTo(0,1500)
    Execute Javascript    $('#modal-input-customerTypeCode_P').click()
    Input Text    //input[@placeholder="ชื่อ"]    ${name}
    Input Text    modal-input-lname    ${Lname}
    Execute Javascript    window.scrollTo(0,1000)
    Input Text    modal-input-phone    ${tele_No}
    Execute Javascript    $('#btn-print-normal').click()
    Comment    ${alert}    Set Variable    Page Should Contain    พบข้อมูลซ้ำกับ เลขที่ใบเสนอราคา
    Comment    Run Keyword If    ${alert} != ""    Click ยกเลิก
    Comment    Run Keyword If    ${alert} == ""    verify againt
    #verify againt
    Alert Should Be Present    \    ACCEPT    120s

Quote-ข้อมูลผู้เอาประกัน_นิติบุคคล
    [Arguments]    ${customer_type}    ${name}    ${tele_No}
    #Input Info
    Execute Javascript    window.scrollTo(0,1000)
    Click Element    modal-input-customerTypeCode_C
    Input Text    //input[@placeholder="ชื่อ"]    ${name}
    Input Text    modal-input-phone    ${tele_No}
    Click Element    btn-print-normal
    #verify againt
    Alert Should Be Present    \    ACCEPT

Quote-Input_ข้อมูลรถ
    [Arguments]    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    [Tags]    รถกระบะ    รถตู้
    #ยี่ห้อ
    Sleep    1s
    Click Element    //*[@id="group-input-car-brandtab1"]/div/span
    Click Element    xpath=//div[contains(text(),'${brand}')]
    #รุ่น
    Click Element    //*[@id="group-input-car-modeltab1"]/div/span
    Click Element    xpath=//div[contains(text(),'${model}')]
    #วันจดทะเบียน
    Click Element    xpath=//option[contains(text(),'${year}')]
    #รุ่นย่อย
    Sleep    1s
    Click Element    //*[@id="group-input-car-model-subtab1"]/div/span/span
    Click Element    xpath=//div[contains(text(),'${sub_model}')]
    #เลขทะเบียน
    Input Text    input-regis-no-pretab1    ${car_registion1}
    Input Text    input-regis-no-posttab1    ${car_registion2}

Quote-Input_ข้อมูลรถยนต์
    [Arguments]    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    [Tags]    รถยนต์
    #ยี่ห้อ
    Sleep    1s
    Click Element    //*[@id="group-input-car-brandtab1"]/div/span
    Click Element    xpath=//div[contains(text(),'${brand}')]
    #รุ่น
    Click Element    //*[@id="group-input-car-modeltab1"]/div/span
    Click Element    xpath=//div[contains(text(),'${model}')]
    #วันจดทะเบียน
    Click Element    xpath=//option[contains(text(),'${year}')]
    #รุ่นย่อย
    Sleep    1s
    Click Element    //*[@id="group-input-car-model-subtab1"]/div/span/span
    Click Element    xpath=//div[contains(text(),'${sub_model}')]
    #เลขทะเบียน
    Input Text    input-regis-no-pretab1    ${car_registion1}
    Input Text    input-regis-no-posttab1    ${car_registion2}
    #ระบุคนขับ
    Execute Javascript    $('#input-driver-agetab1').val('MDDA0000002')
    #ประเภทการซ่อม
    Execute Javascript    $('#input-cliam-type-Atab1').click()    #ซ่อมห้าง

Quote-Auto_รถเก๋ง
    [Arguments]    ${registion}    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}
    ...    ${car_registion2}    ${remark}
    [Documentation]    *Results* : Prints Quotation
    [Tags]    สร้างใบเสนอราคา    เก๋ง    # ทดสอบข้อมูลรถเก๋ง
    Wait Until Element Is Visible    iframe_content    120s
    Sleep    5s
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Comment    Click Element    //*[@id='opt-default-case']
    Execute Javascript    $('[name="optCarType"][id="opt-default-case"][value="MQCT0000008"]').click()    #ประเภทรถ
    Execute Javascript    $('[name="optCarType"][id="opt-default-case"][value="MQCT0000008"]').trigger('change')    #ประเภทรถ
    Sleep    2s
    Execute Javascript    window.scrollTo(0,500)
    #ประเภทการจดทะเบียน
    Sleep    2s
    Execute Javascript    $('#input-car-propertiestab1').val('MQCP0000004')
    Execute Javascript    $('#input-car-propertiestab1').trigger('change')
    Quote-Input_ข้อมูลรถยนต์    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    #ค้นหา
    Execute Javascript    $('#btn-searchtab1').click()
    #เลือกประเภทประกัน
    Wait Until Element Is Visible    //*[@id="result0"]/div/div[2]/div[1]/div/div[1]/span/img    30s
    Wait Until Element Is Visible    div-search-result    60s
    Execute Javascript    window.scrollTo(0,2000)
    #เลือกประกัน
    Execute Javascript    $('[src="img/check-circle-outline-blank.png"]')[0].click()
    #หมายเหตุ
    Input Text    input-remark    ทดสอบรถเก๋ง Normal ระบุคนขับและ ซ่อมห้าง
    #Print
    Execute Javascript    $('#btn-print').click()
    [Teardown]

Quote-Auto_รถกระบะ
    [Arguments]    ${registion}    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}
    ...    ${car_registion2}    ${remark}
    [Documentation]    *Results* : Prints Quotation
    [Tags]    สร้างใบเสนอราคา    กระบะ
    Wait Until Element Is Visible    iframe_content    120s
    Sleep    5s
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Comment    Click Element    opt-pickup-case
    Execute Javascript    $('[name="optCarType"][id="opt-pickup-case"][value="MQCT0000005"]').click()    #ประเภทรถ
    Execute Javascript    $('[name="optCarType"][id="opt-pickup-case"][value="MQCT0000005"]').trigger('change')    #ประเภทรถ
    Sleep    2s
    Execute Javascript    window.scrollTo(0,500)
    #ประเภทการจดทะเบียน
    sleep    2s
    ClickElem    xpath=//option[contains(text(),'${registion}')]
    ScrollIntoView    txt-input-car-brandtab1
    Quote-Input_ข้อมูลรถ    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    #ค้นหา
    Execute Javascript    $('#btn-searchtab1').click()
    #เลือกประเภทประกัน
    Wait Until Element Is Visible    xpath=//img[contains(@src,'img/check-circle-outline-blank.png')]    30s
    Wait Until Element Is Visible    div-search-result    60s
    Execute Javascript    window.scrollTo(0,2000)
    #เลือกประกัน
    Execute Javascript    $('[src="img/check-circle-outline-blank.png"]')[1].click()
    #หมายเหตุ
    Input Text    input-remark    ${remark}
    #Print
    Execute Javascript    $('#btn-print').click()

Quote-Auto_รถตู้ส่วนบุคคล
    [Arguments]    ${registion}    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}
    ...    ${car_registion2}    ${remark}
    [Documentation]    *Results* : Prints Quotation
    [Tags]    สร้างใบเสนอราคา    ตู้
    Wait Until Element Is Visible    iframe_content    90s
    Sleep    10s
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Comment    Click Element    //*[@id='opt-default-case']
    Execute Javascript    $('[name="optCarType"][id="opt-van-case"][value="MQCT0000003"]').click()    #ประเภทรถ
    Execute Javascript    $('[name="optCarType"][id="opt-van-case"][value="MQCT0000003"]').trigger('change')    #ประเภทรถ
    Sleep    1s
    Execute Javascript    window.scrollTo(0,500)
    #ประเภทการจดทะเบียน
    sleep    1s
    ClickElem    xpath=//option[contains(text(),'${registion}')]
    ScrollIntoView    txt-input-car-brandtab1
    Quote-Input_ข้อมูลรถ    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    #ค้นหา
    Execute Javascript    $('#btn-searchtab1').click()
    #เลือกประเภทประกัน
    Wait Until Element Is Visible    xpath=//img[contains(@src,'img/check-circle-outline-blank.png')]    30s
    ScrollIntoView    btn-search-result
    Sleep    5s
    Comment    Click Element    xpath=//img[contains(@src,'img/check-circle-outline-blank.png')]
    Execute Javascript    $('[src="img/check-circle-outline-blank.png"]')[1].click()
    #หมายเหตุ
    Input Text    input-remark    ${remark}
    #Print
    Execute Javascript    $('#btn-print').click()

Quote-ข้อมูลรถลูกค้า_Auto
    [Arguments]    ${car_type}    ${registion}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    ...    ${remark}
    #ระบุประเภทรถ
    Log    '${car_type}'
    Run Keyword If    '${car_type}'== 'รถเก๋ง'    Quote-Auto_รถเก๋ง    ${registion}    ${brand}    ${model}    ${year}
    ...    ${sub_model}    ${car_registion1}    ${car_registion2}    ${remark}
    Run Keyword If    '${car_type}' == 'รถกระบะ'    Quote-Auto_รถกระบะ    ${registion}    ${brand}    ${model}    ${year}
    ...    ${sub_model}    ${car_registion1}    ${car_registion2}    ${remark}
    Run Keyword If    '${car_type}'== 'รถตู้ส่วนบุคคล'    Quote-Auto_รถตู้ส่วนบุคคล    ${registion}    ${brand}    ${model}    ${year}
    ...    ${sub_model}    ${car_registion1}    ${car_registion2}    ${remark}
    Run Keyword If    '${car_type}'== 'บรรทุก'    Quote-ข้อมูลรถลูกค้า_Auto_Special
    Sleep    0.5s
    [Teardown]

Quote-ข้อมูลรถลูกค้า_Auto_Special
    [Arguments]    ${car_type}    ${registion}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    Comment    Select Frame    //iframe[1]
    ${register_val}    Get Substring    ${registion}    \    3
    log many    ${car_type}    ${registion}    ${brand}    ${model}    ${register_val}
    Wait Until Element Is Visible    iframe_content    90s
    Sleep    10s
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Unselect Frame
    Select Frame    //iframe[@id='iframe_content']
    Sleep    5s
    Click Element    opt-special-case
    Sleep    3s
    Run Keyword If    '${car_type}' != 'รถบรรทุก'    Auto_Special_รถอื่นๆ    ${registion}    ${car_type}    ${brand}    ${model}
    ...    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}
    ...    ${size_engin}    ${weight}
    Run Keyword If    '${car_type}' == 'รถบรรทุก' and '${register_val}' == '320' or '${register_val}' == '420' or '${register_val}' == '340'    Auto_Special_รถบรรทุก_หัวลาก    ${registion}    ${car_type}    ${brand}    ${model}
    ...    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}
    ...    ${size_engin}    ${weight}
    Run Keyword If    '${car_type}' == 'รถบรรทุก' and '${register_val}' == '520' or '${register_val}' == '540'    Auto_Special_รถบรรทุก_หางพ่วง    ${registion}    ${car_type}    ${brand}    ${model}
    ...    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}
    ...    ${size_engin}    ${weight}    กด 2563

Quote_ข้อมูลรถลูกค้า_Auto_สวัสดิการพนักงาน
    [Arguments]    ${car_type}    ${registion}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    Sleep    5s
    ${register_val}    Get Substring    ${registion}    \    3
    log many    ${car_type}    ${registion}    ${brand}    ${model}    ${register_val}
    Click Element    opt-employee-case
    Sleep    3s
    Auto_Special_รถอื่นๆ    ${registion}    ${car_type}    ${brand}    ${model}    ${year}    ${sub_model}
    ...    ${car_registion1}    ${car_registion2}    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}

รถบรรทุก_ใบเสนอราคา1
    [Arguments]    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    ...    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    log many    ${brand}    ${car_registion1}    ${car_registion2}    ${Engin_no}
    ScrollIntoView    subtabtab1
    #ยี่ห้อ
    Sleep    5s
    Click Element    //*[@id="group-input-car-brandsubtab1tab1"]/div/span/span
    Click Element    xpath=//div[contains(text(),'${brand}')]
    #รุ่น
    Click Element    //*[@id="group-input-car-modelsubtab1tab1"]/div/span/span
    Click Element    //div[contains(text(),'${model}')]
    #วันจดทะเบียน
    sleep    2s
    Click Element    //*[@id="input-register-yearsubtab1tab1"]/option[contains(text(),'${year}')]
    #รุ่นย่อย
    Click Element    //*[@id="group-input-car-model-subsubtab1tab1"]/div/span/span
    Click Element    //div[contains(text(),'${sub_model}')]
    sleep    5s
    #เลขทะเบียน
    Input Text    input-regis-no-presubtab1tab1    ${car_registion1}
    Input Text    input-regis-no-postsubtab1tab1    ${car_registion2}
    #จังหวัด
    Click Element    xpath=//option[contains(text(),'กรุงเทพมหานคร')]
    #เลขตัวถัง
    Input Text    input-chassis-nosubtab1tab1    ${Engin_no}
    #เลขเครื่องยนต์
    Input Text    input-engine-nosubtab1tab1    ${Engin_no2}
    #ขนาดเครื่องยนต์
    Input Text    input-engine-sizesubtab1tab1    ${size_engin}
    #น้ำหนักรวม
    Input Text    input-weightsubtab1tab1    ${weight}
    Sleep    5s
    #ลักษณะการใช้งาน
    Execute Javascript    $('#input-use-casesubtab1tab1').val('06')
    ##เอกสารแนบ##
    ScrollIntoView    file01tab1
    Choose File    xpath=//*[@id="file01tab1"]    ${CURDIR}\\pic01.jpg
    Input Text    comment_file01tab1    สำเนาบัตรประชาชน
    Choose File    xpath=//*[@id="file02tab1"]    ${CURDIR}\\pic02.jpg
    Input Text    comment_file02tab1    สำเนาเล่มทะเบียน
    Choose File    xpath=//*[@id="file03tab1"]    ${CURDIR}\\pic03.jpg
    Input Text    comment_file03tab1    รูปหน้ารถ
    Choose File    xpath=//*[@id="file04tab1"]    ${CURDIR}\\pic04.jpg
    Input Text    comment_file04tab1    รูปหลังรถ
    Choose File    xpath=//*[@id="file05tab1"]    ${CURDIR}\\pic05.jpg
    Input Text    comment_file05tab1    รูปด้านขวา
    Choose File    xpath=//*[@id="file06tab1"]    ${CURDIR}\\pic06.jpg
    Input Text    comment_file06tab1    รูปด้านซ้าย
    Sleep    2s
    ScrollIntoView    div-file-attachtab1
    #remark
    Input Text    input-remark    Day2 Specail เก๋ง 110 Case 1

รถบรรทุก_ใบเสนอราคา2
    [Arguments]    ${brand}    ${model}    ${year}    ${sub_model}    ${car_registion1}    ${car_registion2}
    ...    ${Engin_no}    ${Engin_no2}    ${size_engin}    ${weight}
    #เพิ่มใบเสนอราคา
    ScrollIntoView    chk-alltab1
    Click Element    btnAdd
    Sleep    10s
    ##ข้อมูลประกัน##
    Sleep    3s
    Click Element    //*[@id="chk-all-instab2SMK"]
    Sleep    3s
    ScrollIntoView    subtab1tab2
    #ยี่ห้อ
    Sleep    5s
    Click Element    //*[@id="group-input-car-brandsubtab1tab2"]/div/span/span/i
    sleep    10s
    Click Element    //div[contains(text(),'CAMC')]
    #รุ่น
    Click Element    //*[@id="group-input-car-modelsubtab1tab2"]/div/span/span
    Click Element    //div[contains(text(),'${model}')]
    #วันจดทะเบียน
    Click Element    //option[contains(text(),'${year}')]
    #รุ่นย่อย
    Click Element    //*[@id="group-input-car-model-subsubtab1tab2"]/div/span/span
    Click Element    //div[contains(text(),'${sub_model}')]
    sleep    5s
    #เลขทะเบียน
    Input Text    input-regis-no-presubtab1tab2    325
    Input Text    input-regis-no-postsubtab1tab2    5263
    #จังหวัด
    Click Element    xpath=//option[contains(text(),'กรุงเทพมหานคร')]
    #เลขตัวถัง
    Input Text    input-chassis-nosubtab1tab2    ${Engin_no}
    ScrollIntoView    input-weightsubtab1tab2
    #น้ำหนักรวม
    Input Text    input-weightsubtab1tab2    ${weight}
    Sleep    5s
    #ลักษณะการใช้งาน
    Click Element    //*[@id="input-use-casesubtab1tab2"]/option[2]
    ##เอกสารแนบ##
    ScrollIntoView    file01tab2
    Choose File    xpath=//*[@id="file01tab2"]    ${CURDIR}\\pic09.jpg
    Input Text    comment_file01tab2    สำเนาบัตรประชาชน
    Choose File    xpath=//*[@id="file02tab2"]    ${CURDIR}\\pic10.jpg
    Input Text    comment_file02tab2    สำเนาเล่มทะเบียน
    Choose File    xpath=//*[@id="file03tab2"]    ${CURDIR}\\pic11.jpg
    Input Text    comment_file03tab2    รูปหน้ารถ
    Choose File    xpath=//*[@id="file04tab2"]    ${CURDIR}\\pic12.jpg
    Input Text    comment_file04tab2    รูปหลังรถ
    Choose File    xpath=//*[@id="file05tab2"]    ${CURDIR}\\pic13.jpg
    Input Text    comment_file05tab2    รูปด้านขวา
    Choose File    xpath=//*[@id="file06tab2"]    ${CURDIR}\\pic14.jpg
    Input Text    comment_file06tab2    รูปด้านซ้าย
    Choose File    file99_01tab2    ${CURDIR}\\pic15.jpg
    Input Text    comment_file99_01tab2    อื่นๆ 01

Select Menu
    [Arguments]    ${main_Menu}    ${sub_Menu}
    ClickElem    xpath=//a[contains(text(),'${main_Menu}')]
    Run Keyword If    '${sub_menu}'=='ใบเสนอราคา'    Menu_ใบเสนอราคา    รถบรรทุกและอื่นๆ    320 เพื่อการพาณิชย์    FUSO    10 ล้อ
    ...    2555    10 ล้อ เกิน 12 ตัน (2017)    22    5552    6546SDFS5464    6546SDFS5464
    ...    1200    2000
    Run Keyword If    '${sub_menu}'=='Lead on IOS'    Lead on IOS-รายงานการติดตาม

Lead on IOS-สร้างรายการ Lead ใหม่
    [Arguments]    ${Lead_Channel}    ${dateAppointment}
    Sleep    2s
    Execute Javascript    $('[src="/img/correct.png"]').click()
    Wait Until Element Is Visible    gbox_jqgTable
    sleep    2s
    #Key data
    Execute Javascript    $('#ContentPlaceHolder1_ddlTopic').val("5")    #หัวข้อ
    Sleep    2s
    Execute Javascript    $('#ContentPlaceHolder1_ddlChannel').val("1")    #ช่องทาง
    Sleep    2s
    Execute Javascript    $('#txtNextScheduleDate').datepicker('setDate', "${dateAppointment}")
    Sleep    2s
    Execute Javascript    $('#btnSave').click()
    Sleep    5s
    Alert Should Be Present    \    ACCEPT    40s

Lead on IOS-รายงานการติดตาม
    [Arguments]    ${LeadNo}
    #input Lead no.
    Sleep    2s
    Select Frame    //iframe[1]
    Input Text    txtSearchLeadCode    ${LeadNo}
    ClickElem    rdoAllBranchsItemType    #ทุกสาขา
    Sleep    3s
    Click Element    btnSearch
    Sleep    2s

Lead on IOS-Customer Information(Licence)
    [Arguments]    ${id_card}    ${sex}    ${sername}    ${date}    ${car_prefix}    ${car_no}
    [Tags]    Card application
    Wait Until Page Contains    Customer Information    120s
    log many    ${car_prefix}    ${car_no}
    Sleep    2s
    #Check on card
    Comment    ${file3}    Run Keyword And Return Status    Page Should Contain Element    txtCustCitizenId
    Execute Javascript    $('[data-btn="on"]').click()    #เปิด On card
    Sleep    1s
    Wait Until Element Is Visible    txtCustCitizenId    20s
    #เลขประจำตัวประชาชน
    ${check_card}    Get Value    txtCustCitizenId
    Run Keyword If    '${check_card}'==''    Input Text    txtCustCitizenId    ${id_card}
    Sleep    1s
    #เลขทะเบียนรถ
    #หน้า
    Comment    log many    ${car_prefix}    ${car_no}
    Comment    Input Text    //*[@id="customerInfo"]/div/div[2]/div[2]/div/input[1]    ${car_prefix}
    Comment    Sleep    1s
    #หลัง
    Comment    Input Text    //*[@id="customerInfo"]/div/div[2]/div[2]/div/input[2]    ${car_no}
    Comment    Sleep    1s
    #คำนำหน้า
    ${check_sex}    Get Text    //*[@id="customerInfo"]/div/div[2]/div[3]/div/select/option[1]
    Run Keyword If    '${check_sex}'=='เลือกคำนำหน้า'    Click Element    //*[@id="customerInfo"]/div/div[2]/div[3]/div/select/option[contains(text(),"${sex}")]
    #นามสกุล
    ${check_sername}    Get Value    txtCustLastNameTH
    Run Keyword If    '${check_sername}'==''    Input Text    txtCustLastNameTH    ${sername}
    #วันเดือนปีเกิด
    Execute Javascript    $('.hasDatepicker').datepicker('setDate', "01/07/2534")
    Comment    Run Keyword And Ignore Error    Alert Should Be Present    ไม่มีสิทธิ์ใช้งานหน้าจอใบเสนอราคา    ACCEPT    1s
    Execute Javascript    $('#btModalSave').click()    #บันทึกข้อมูล

Lead on IOS-Customer Information(No-licence)
    [Arguments]    ${id_card}    ${sex}    ${sername}    ${date}
    WaitElementVisible    modalSmartCard
    Sleep    5s
    Execute Javascript    $('[data-btn="on"]').click()
    Sleep    2s
    #เลขประจำตัวประชาชน
    ${check_card}    Get Value    txtCustCitizenId
    Run Keyword If    '${check_card}'==''    Input Text    txtCustCitizenId    ${id_card}
    #คำนำหน้า
    ${check_sex}    Get Text    //*[@id="customerInfo"]/div/div[2]/div[3]/div/select/option[1]
    Run Keyword If    '${check_sex}'=='เลือกคำนำหน้า'    Click Element    //*[@id="customerInfo"]/div/div[2]/div[3]/div/select/option[contains(text(),"${sex}")]
    #นามสกุล
    ${check_sername}    Get Value    txtCustLastNameTH
    Run Keyword If    '${check_sername}'==''    Input Text    txtCustLastNameTH    ${sername}
    #วันเดือนปีเกิด
    Execute Javascript    $('.hasDatepicker').datepicker('setDate', "01/07/2534")
    Comment    Run Keyword And Ignore Error    Alert Should Be Present    ไม่มีสิทธิ์ใช้งานหน้าจอใบเสนอราคา    ACCEPT    1s

Lead on IOS-Comparision_page
    Wait Until Page Contains    เปรียบเทียบใบเสนอราคา    90s
    Wait Until Element Is Visible    btnVerify    120s
    Execute Javascript    window.scrollTo(0,2000)
    Sleep    5s
    Execute Javascript    $('#btnSelected').first().click()
    Sleep    3s
    Click Element    btnVerify
    sleep    20s

Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า
    [Arguments]    ${status}    ${business}    ${currier}    ${exp}    ${acc}    ${finance}
    ...    ${use}    ${freq}    ${addr}    ${prov}    ${aump}    ${tumb}
    ...    ${post}    ${marital}
    [Documentation]    1.ข้อมูลลูกค้า
    ###### Flow Step####
    Wait Until Page Contains    IOS VERIFY INPUT : VERIFY NO. -    120s
    ScrollIntoView    liStep1
    ##ข้อมูลทั่วไป##
    Sleep    1s
    ${Check_info}    Get Text    //*[@id="tdPeople2"]/span
    ${status_val}    Get Substring    ${Check_info}    \    -7
    Log many    ${Check_info}    ${status_val}
    Run Keyword If    '${status_val}' == 'เลือกข้อมูล'    ข้อมูลลูกค้า-ข้อมูลทั่วไป    ${status}    ${business}    ${currier}    ${exp}
    ...    ${acc}    ${finance}    ${use}    ${freq}    ${marital}
    #ที่อยู่
    Sleep    1s
    ScrollIntoView    txtCustomerCurrentAddress
    Log Many    ${addr}    ${prov}    ${aump}    ${tumb}    ${post}
    ${addr_Val}    Get Value    txtCustomerCurrentAddress
    Run Keyword If    "${addr_Val}"==""    Verify_ข้อมูลลูกค้า_ที่อยู่    ${addr}    ${prov}    ${aump}    ${tumb}
    ...    ${post}
    ${Driver}    Run Keyword And Return Status    Page Should Contain Element    chkDriver
    Run Keyword If    ${Driver}    รายละเอียดผู้ขับขี่
    #Next
    Sleep    2s
    Click Element    xpath=//*[@id="wizard"]/div[2]/a[2]

Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา
    [Arguments]    ${CarRegProvince}    ${ChassisNo}    ${EngineNo}    ${CarCC}    ${CarWeight}
    #ข้อมูลรถ
    ScrollIntoView    lblQuoteTypeName
    ##GetId
    ${getId}    Execute Javascript    return $($("input[id*='txtCarLicence']").get()).attr("id")
    ${subId}    Get Substring    ${getId}    14
    Log To Console    ==========${subId}====
    Sleep    5s
    #จังหวัดที่จดทะเบียน
    Execute Javascript    $('#ddlCarRegisProvince_${subId}').data("kendoDropDownList").value(1);
    #เลขตัวถัง
    ${ChassisNo_ch}    Get Value    txtChassisNo_${subId}
    Log    ${ChassisNo_ch}
    Run Keyword If    '${ChassisNo_ch}'==''    Input Text    txtChassisNo_${subId}    ${ChassisNo}
    Sleep    2s
    #เลขเครื่องยนต์
    ${EngineNo_ch}    Get Value    txtEngineNo_${subId}
    Run Keyword If    '${ChassisNo_ch}'==''    Input Text    txtEngineNo_${subId}    ${EngineNo}
    Sleep    2s
    #ขนาดเครื่องยนต์
    ${CarCC_ch}    Get Value    txtCarCC_${subId}
    Run Keyword If    '${CarCC_ch}'==''    Input Text    txtCarCC_${subId}    ${CarCC}
    Sleep    2s
    #น้าหนักรวม(Kg)
    ${CarWeight_ch}    Get Value    txtWeight_${subId}
    Run Keyword If    '${CarWeight_ch}'==''    Input Text    txtWeight_${subId}    ${CarWeight}
    #####ข้อมูลไฟล์แนบ
    ${File}=    Execute Javascript    return $('#tblMasterFileRequest tbody tr').length
    Run Keyword If    '${File}'=='7'    MasterFileRequest_FULL
    ...    ELSE    MasterFileRequest
    ##Next
    Execute Javascript    $('.buttonNext').click()

Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_รถบรรทุก
    [Arguments]    ${CarRegProvince}    ${ChassisNo}    ${EngineNo}    ${CarCC}    ${CarWeight}
    #ข้อมูลรถ
    ScrollIntoView    lblQuoteTypeName
    ##GetId
    ${getId}    Execute Javascript    return $($("input[id*='txtCarLicence']").get()).attr("id")
    ${subId}    Get Substring    ${getId}    14
    Log To Console    ==========${subId}====
    Sleep    5s
    #จังหวัดที่จดทะเบียน
    Execute Javascript    $('#ddlCarRegisProvince_${subId}').data("kendoDropDownList").value(1);
    #เลขตัวถัง
    ${ChassisNo_ch}    Get Value    txtChassisNo_${subId}
    Log    ${ChassisNo_ch}
    Run Keyword If    '${ChassisNo_ch}'==''    Input Text    txtChassisNo_${subId}    ${ChassisNo}
    Sleep    2s
    #เลขเครื่องยนต์
    ${EngineNo_ch}    Get Value    txtEngineNo_${subId}
    Run Keyword If    '${ChassisNo_ch}'==''    Input Text    txtEngineNo_${subId}    ${EngineNo}
    Sleep    2s
    #ขนาดเครื่องยนต์
    ${CarCC_ch}    Get Value    txtCarCC_${subId}
    Run Keyword If    '${CarCC_ch}'==''    Input Text    txtCarCC_${subId}    ${CarCC}
    Sleep    2s
    #น้าหนักรวม(Kg)
    ${CarWeight_ch}    Get Value    txtWeight_${subId}
    Run Keyword If    '${CarWeight_ch}'==''    Input Text    txtWeight_${subId}    ${CarWeight}
    #####ข้อมูลไฟล์แนบ
    Comment    #สำเนาบัตรประชาชน
    Comment    ${file1}    Run Keyword And Return Status    Page Should Contain    สำเนาบัตรประชาชน
    Comment    Run Keyword If    ${file1}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_01    ${CURDIR}\\pic01.jpg
    ...    AND    Input Text    Commentfile_01    สำเนาบัตรประชาชน
    Comment    Execute Javascript    alert('ตรวจสอบสำเนาบัตรประชาชน')
    Comment    Sleep    2s
    Comment    Alert Should Be Present    \    ACCEPT
    Comment    #สำเนาเล่มทะเบียน
    Comment    ${file2}    Run Keyword And Return Status    Page Should Contain    สำเนาเล่มทะเบียน
    Comment    Set Selenium Speed    0.1s
    Comment    Run Keyword If    ${file2}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_02    ${CURDIR}\\pic02.jpg
    ...    AND    Input Text    Commentfile_02    สำเนาเล่มทะเบียน
    Comment    Set Selenium Speed    0.1s
    Comment    Execute Javascript    alert('ตรวจสอบสำเนาเล่มทะเบียน')
    Comment    Sleep    2s
    Comment    Alert Should Be Present    \    ACCEPT
    Comment    #รูปหน้ารถ
    Comment    ${file3}    Run Keyword And Return Status    Page Should Contain    รูปหน้ารถ
    Comment    Set Selenium Speed    0.1s
    Comment    Run Keyword If    ${file3}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_03    ${CURDIR}\\pic03.jpg
    ...    AND    Input Text    Commentfile_03    รูปหน้ารถ
    Comment    Set Selenium Speed    0.1s
    Comment    Execute Javascript    alert('ตรวจสอบรูปหน้ารถ')
    Comment    Sleep    2s
    Comment    Alert Should Be Present    \    ACCEPT
    Comment    #รูปหลังรถ
    Comment    ${file4}    Run Keyword And Return Status    Page Should Contain    รูปหน้ารถ
    Comment    Run Keyword If    ${file4}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_04    ${CURDIR}\\pic04.jpg
    ...    AND    Input Text    Commentfile_04    รูปหลังรถ
    Comment    Execute Javascript    alert('ตรวจสอบรูปหลังรถ')
    Comment    Sleep    2s
    Comment    Alert Should Be Present    \    ACCEPT
    Comment    #รูปด้านขวา
    Comment    ${file5}    Run Keyword And Return Status    Page Should Contain    รูปด้านขวา
    Comment    Run Keyword If    ${file5}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_05    ${CURDIR}\\pic05.jpg
    ...    AND    Input Text    Commentfile_05    รูปด้านขวา
    Comment    Execute Javascript    alert('ตรวจสอบรูปด้านขวา')
    Comment    Sleep    2s
    Comment    Alert Should Be Present    \    ACCEPT
    Comment    #รูปด้านซ้าย
    Comment    ${file6}    Run Keyword And Return Status    Page Should Contain    รูปด้านซ้าย
    Comment    Run Keyword If    ${file6}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_06    ${CURDIR}\\pic06.jpg
    ...    AND    Input Text    Commentfile_06    รูปด้านซ้าย
    Comment    Execute Javascript    alert('ตรวจสอบรูปด้านซ้าย')
    Comment    Sleep    2s
    Comment    Alert Should Be Present    \    ACCEPT
    Comment    #เอกสารอื่นๆ 1
    Comment    ${file_other}    Run Keyword And Return Status    Page Should Contain    เอกสารไฟล์แนบอื่นๆ
    Comment    Run Keyword If    ${file_other}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_99_1    ${CURDIR}\\pic07.jpg
    ...    AND    Input Text    Commentfile_99_1    เอกสารอื่นๆ 1
    ##Next
    Execute Javascript    $('.buttonNext').click()

Lead on IOS-VERIFY INPUT Page->ข้อมูลความคุ้มครอง
    WaitElementVisible    xpath=//*[@id="step-3"]
    ##รายละเอียดผู้ขาย
    Execute Javascript    $('#btnCheckLicense').click()    #ตรวจสอบใบอนุญาต
    ##Next
    Execute Javascript    $('.buttonNext').click()

Lead on IOS-VERIFY INPUT Page->ข้อมูลชำระเงิน
    [Arguments]    ${pay_type}    ${credit_type}    ${credit_no}
    WaitElementVisible    xpath=//*[@id="step-4"]
    ClickElem    //*[@id="div2"]/table/tbody/tr[1]/td/div/input[1]    #ข้อมูลผู้รับผลประโยชน์
    ##ประเภทการชำระเงิน
    Run Keyword If    '${pay_type}'=='เงินสด'    ClickElem    radPaymentType_1
    Run Keyword If    '${pay_type}'=='บัตรเครดิต'    Run Keywords    ClickElem    radPaymentType_2
    ...    AND    Input Text    txtCreditCardNo    ${credit_no}
    ...    AND    Choose File    filePayType_13    ${CURDIR}\\pic09.jpg
    Run Keyword If    '${pay_type}'=='หักเงินเดือน'    Run Keywords    ClickElem    radPaymentType_4
    ...    AND    Input Text    txtEmployeeId    CF301591
    ...    AND    Execute Javascript    $k('#divSalaryOption div div select[data-role="dropdownlist"]').data('kendoDropDownList').value('Fri Aug 31 2018 00:00:00 GMT+0700 (Indochina Time)')
    Run Keyword If    '${pay_type}'=='หักยอดสินเชื่อ (CV/On Top)'    Run Keywords    ClickElem    radPaymentType_5
    ...    AND    Execute Javascript    $('[name="radIsLoan"]').click()
    ...    AND    Choose File    filePayType_07    ${CURDIR}\\pic02.jpg
    Run Keyword If    '${pay_type}'=='โครงการผ่อนชำระเงินสด'    ClickElem    radPaymentType_8
    ###SAVE
    Sleep    2s
    Execute Javascript    $('.buttonFinish').click()
    Alert Should Be Present    \    ACCEPT    90s
    Alert Should Be Present    \    ACCEPT    90s

ข้อมูลลูกค้า-ข้อมูลทั่วไป
    [Arguments]    ${status}    ${business}    ${currier}    ${exp}    ${acc}    ${finance}
    ...    ${use}    ${freq}    ${marital}
    ${status_set}=    Set variable if    '${marital}'=='โสด'    2    '${marital}'=='สมรส'    3    '${marital}'=='หย่าร้าง'
    ...    4    '${marital}'=='หม้าย'    5
    log many    ${status_set}    ${marital}    ${business}    ${currier}
    #สถานะ
    Execute Javascript    $("#ddlMARITAL_STATUS").data("kendoDropDownList").value(1)
    ##กลุ่มธุรกิจ##
    Execute Javascript    $("#ddlBUSSINESS_GROUP").data("kendoDropDownList").value(1);
    ##อาชีพ##
    Execute Javascript    $("#ddlOCCUPATION").data("kendoDropDownList").value('02');
    #ประสบการณ์การขับรถ
    Execute Javascript    $('[name="radDriveExprerience"][value="01"]').click()
    # ปีที่ผ่านมาเกิดอุบัติเหตุหรือไม่
    Execute Javascript    $('[name="radFreqInAccident"][value="01"]').click()
    #ปัจจุบันรถคันนี้ทำ Finance หรือไม่
    Comment    ${fin_set}    Set Variable If    '${finance}'=='ไม่ทำ'    1    '${finance}'=='ทำ'    2
    Comment    ClickElem    xpath=//*[@id="Table1"]/tbody/tr[6]/td/div/input[${fin_set}]
    #ลักษณะการใช้รถ
    Execute Javascript    $('[name="radUsingCharacteristicID"][value="01"]').click()
    #ความถี่ในการใช้รถ
    Execute Javascript    $('[name="radUseType"][value="01"]').click()

Verify_ข้อมูลลูกค้า_ที่อยู่
    [Arguments]    ${addr}    ${prov}    ${aump}    ${tumb}    ${post}
    Input Text    txtCustomerCurrentAddress    ${addr}
    Sleep    3s
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[1]/span/span/span/span    #จังหวัด
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentProvince_listbox"]/li[contains(text(),'${prov}')]
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[2]/span/span/span/span    #อำเภอ
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentDistrict_listbox"]/li[contains(text(),'${aump}')]
    Sleep    2s
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[3]/span/span/span/span    #ตำบล
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentSubDistrict_listbox"]/li[contains(text(),'${tumb}')]
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[4]/span/span/span/span    #Post
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentZipCode_listbox"]/li[contains(text(),'${post}')]
    Click Element    chkDupAddressToMaillingAddress    #เหมือนที่อยู่ปัจจุบัน

Lead on IOS-เพิ่มลูกค้า
    [Arguments]    ${name}    ${tele}
    Select Frame    //iframe[1]
    Sleep    2s
    Execute Javascript    $('#btnAdd').click()    #เพิ่มลูกค้า
    #Key data
    Sleep    1s
    Input Text    txtFirstName    ${name}
    Sleep    1s
    Input Text    txtTel1    ${tele}
    Sleep    1s
    #บันทึก
    Click Element    btnSaveCustomer
    Sleep    1s
    Alert Should Be Present    \    ACCEPT    90s

Lead on IOS-กรอกข้อมูลส่ง IOS
    [Arguments]    ${product}    ${group}
    sleep    1s
    Click Element    btnFollowGroupRequestDetail    #กรอกข้อมูลส่ง IOS
    #Get Id
    ${getid}    Get Element Attribute    xpath=//*[@title='History']    onclick
    ${subid}    Get Substring    ${getid}    25    32
    #กรอกข้อมูล
    Sleep    1s
    Click Element    //*[@id="trRequestDetail${subid}"]/td[2]/select/option[contains(text(),'${product}')]    #กลุ่มผลิตภัณฑ์
    Sleep    1s
    Click Element    //*[@id="trRequestDetail${subid}"]/td[3]/select/option[contains(text(),'${group}')]    #กลุ่มย่อย
    #บันทึก
    Execute Javascript    $('#btnLeadDetailSubmit').click()
    Alert Should Be Present    \    ACCEPT    90s

Lead on IOS-สร้างใบเสนอราคา
    Input Text    //*[@id="customerInfo"]/div/div[2]/div[2]/div/input[1]    222
    Input Text    //*[@id="customerInfo"]/div/div[2]/div[2]/div/input[2]    7777
    #บันทึกข้อมูล
    Click Element    btModalSave
    #.: Insurance Quotation :.
    Sleep    2s

Lead on IOS-นัดวันเวลา
    [Arguments]    ${status}    ${date_appointment}    ${timeHr}    ${timeMin}    ${product}    ${group}
    ...    ${remark}
    Sleep    2s
    Click Element    btnFollowGroupFollow
    Sleep    2s
    ${statusVal}=    Set Variable If    '${status}'=='ติดต่อลูกค้า แล้วรอลูกค้าตัดสินใจ'    2    '${status}'=='ติดต่อไม่ได้/ไม่รับสาย/ปิดเครื่อง'    3    '${status}'=='ไม่สะดวกคุย/ติดธุระ'
    ...    4    '${status}'=='รอลูกค้าชำระเงิน'    5
    log many    ${statusVal}    ${status}
    ClickElem    //*[@id="ddlLeadDetailFollowStatus"]/option[${statusVal}]    #เลือกสถานะ
    Sleep    2s
    #นัดหมายครั้งต่อไป
    Execute Javascript    $('.hasDatepicker').datepicker('setDate', "${date_appointment}")    #date
    Click Element    //*[@id="ddlLeadDetailNextScheduleHour"]/option[contains(text(),'${timeHr}')]    #เวลา hour
    Click Element    //*[@id="ddlLeadDetailNextScheduleMinute"]/option[contains(text(),'${timeMin}')]    #เวลา min
    Input Text    txtLeadDetailRemark    ${remark}
    #Get Id
    ${getid}    Get Element Attribute    xpath=//*[@title='History']    onclick
    ${subid}    Get Substring    ${getid}    25    32
    #กรอกข้อมูล
    Sleep    2s
    Click Element    //*[@id="trRequestDetail${subid}"]/td[2]/select/option[contains(text(),'${product}')]    #กลุ่มผลิตภัณฑ์
    Click Element    //*[@id="trRequestDetail${subid}"]/td[3]/select/option[contains(text(),'${group}')]    #กลุ่มย่อย
    #บันทึก
    ClickElem    btnLeadDetailSubmit
    Sleep    2s
    Alert Should Be Present    \    ACCEPT

Lead on IOS-ส่งงาน
    [Arguments]    ${status}    ${team}    ${empId}    ${branch}    ${remark}    ${product}
    ...    ${group}
    Sleep    2s
    Click Element    btnFollowGroupForward    #ส่งงาน
    log    ${status}
    ##CHECK CONDITION##
    Run Keyword If    '${status}'=='ส่งพนักงาน (ติดตาม)'    Run Keywords    Sleep    2s
    ...    AND    Click Element    //*[@id="ddlLeadDetailFollowStatus"]/option[2]
    ...    AND    Sleep    2s
    ...    AND    Input Text    txtLeadDetailUserId    ${empId}
    ...    ELSE IF    '${status}'=='ส่งสาขา (ติดตาม)'    Run Keywords    Sleep    3s
    ...    AND    Click Element    //*[@id="ddlLeadDetailFollowStatus"]/option[3]
    ...    AND    Sleep    3s
    ...    AND    Click Element    //*[@id="ContentPlaceHolder1_ddlLeadDetailBranch"]/option[contains(text(),'${branch}')]
    ...    ELSE IF    '${status}'=='ส่งทีม (ติดตาม)'    Run Keywords    Sleep    3s
    ...    AND    Click Element    //*[@id="ddlLeadDetailFollowStatus"]/option[4]
    ...    AND    Sleep    2s
    ...    AND    Click Element    //*[@id="ContentPlaceHolder1_ddlLeadDetailTeam"]/option[@value="${team}"]
    ...    ELSE    Log To Console
    ## หมายเหตุ ##
    Input Text    txtLeadDetailRemark    ${remark}
    #Get Id
    ${getid}    Get Element Attribute    xpath=//*[@title='History']    onclick
    ${subid}    Get Substring    ${getid}    25    32
    #กรอกข้อมูล
    Sleep    2s
    Click Element    //*[@id="trRequestDetail${subid}"]/td[2]/select/option[contains(text(),'${product}')]    #กลุ่มผลิตภัณฑ์
    Click Element    //*[@id="trRequestDetail${subid}"]/td[3]/select/option[contains(text(),'${group}')]    #กลุ่มย่อย
    #บันทึก
    Execute Javascript    $('#btnLeadDetailSubmit').click()
    Alert Should Be Present    \    ACCEPT

Lead on IOS-ยกเลิก/ไม่ติดตาม
    [Arguments]    ${status}    ${remark}
    Sleep    2s
    Click Element    btnFollowGroupClose    #ยกเลิก/ไม่ติดตาม
    Click Element    //*[@id="ddlLeadDetailCancelReason"]/option[2]
    Input Text    txtLeadDetailRemark    ${remark}
    Click Element    btnLeadDetailSubmit    #บันทึก
    Alert Should Be Present    \    ACCEPT

ข้อมูลชำระเงิน-ประเภทการชำระเงิน
    [Arguments]    ${pay_type}    ${installment}    ${card_no}
    [Documentation]    1. Click ประเภทการชำระเงิน
    ...    2. ใส่รายละเอียดประเภทชำระเงิน
    #Click ประเภทการชำระเงิน
    Sleep    2s
    Run Keyword If    '${pay_type}'=='เงินสด'    Click Element    radPaymentType_1
    ...    ELSE IF    '${pay_type}'=='บัตรเครดิต'    Click Element    radPaymentType_2
    ...    ELSE IF    '${pay_type}'=='หักเงินเดือน'    Click Element    radPaymentType_4
    ...    ELSE IF    '${pay_type}'=='Bill payment'    Click Element    radPaymentType_7
    ...    ELSE IF    '${pay_type}'=='หักยอดสินเชื่อ (CV/On Top)'    Click Element    radPaymentType_5
    ...    ELSE    Click Element    radPaymentType_8
    Comment    #ชำระผ่านบัตรเครดิต
    Comment    Run Keyword If    '${pay_type}'=='บัตรเครดิต'    ชำระผ่านบัตรเครดิต    ${installment}    ${card_no}
    ...    ELSE IF    '${pay_type}'=='หักยอดสินเชื่อ (CV/On Top)'    Choose File    tdShowFile_07    ${CURDIR}\\pic01.jpg
    ...    ELSE    ClickElem    //*[@id="wizard"]/div[2]/a[1]    #เอกสารยินยอมให้ตัดบัตรเครดิต*

ชำระผ่านบัตรเครดิต
    [Arguments]    ${pay}    ${credit_no}
    #ประเภทการชำระ :#
    Run Keyword If    '${pay}'=='ผ่อนชำระ '    Click Element    //*[@id="tr1Credit"]/td[2]/input[1]
    ...    ELSE    Click Element    //*[@id="tr1Credit"]/td[2]/input[2]
    log    ${pay}
    #ประเภทบัตรเครดิต :#
    Comment    ClickElem    //*[@id="tr2Credit"]/td[2]/span/span/span[2]
    Comment    Click Element    //*[@id="ddlCardType_listbox"]/li[contains(text(),'${credit}')]
    #เลขที่บัตรเครดิต :#
    Input Text    txtCreditCardNo    ${credit_no}
    ScrollIntoView    tdShowFile_13
    #เอกสารไฟล์แนบ (Request*)#
    Choose File    //*[@id="filePayType_13"]    ${CURDIR}\\pic01.jpg    #เอกสารยินยอมให้ตัดบัตรเครดิต*
    ClickElem    //*[@id="wizard"]/div[2]/a[1]

โครงการชำระเงิน
    [Arguments]    ${no}
    Click Element    //*[@id="table_installment_term"]/tbody/tr/td[2]/span[2]/span/span[2]
    Click Element    //*[@id="ddlInstallmentTerm_202120_listbox"]/li[2]
    ClickElem    //*[@id="wizard"]/div[2]/a[1]

import
    [Arguments]    ${chanal}    ${team}    ${content}
    ClickElem    btnImport
    Sleep    2s
    Click Element    //*[@id="ContentPlaceHolder1_ddlChannel"]/option[contains(text(),'${chanal}')]    #ช่องทาง
    Click Element    //*[@id="ContentPlaceHolder1_ddlTeam"]/option[contains(text(),'${team}')]    #ทีม
    Click Element    //*[@id="ContentPlaceHolder1_ddlContent"]/option[contains(text(),'${content}')]    #หัวข้อ
    Sleep    2s
    Choose File    ContentPlaceHolder1_fuldImportCustomer    ${CURDIR}\\LEAD_UPLOAD_TEMPLATE_V2.xlsx    #File
    ClickElem    btnImportFake    #Import
    Sleep    3s
    Click Element    //img[@src="../img/excel.png"]    #download
    Sleep    3s

สรุปสถานะ-กลุ่มผลิตภัณฑ์
    [Arguments]    ${chal}
    #กลุ่มผลิตภัณฑ์
    ${val}    Set Variable If    '${chal}'=='ประกันภัยรถยนต์'    1    '${chal}'=='ประกันอุบัติเหตุ'    2    '${chal}'=='พ.ร.บ'
    ...    3    '${chal}'=='ต่อภาษีรถ'    4    '${chal}'=='ประกันมะเร็ง'    5    '${chal}'=='ประกันค้ำจุนลูกจ้าง'
    ...    6    '${chal}'=='สวัสดิการพนักงาน_ประกันPA'    7    '${chal}'=='สวัสดิการพนักงาน_ประกันมะเร็ง'    8    '${chal}'=='สวัสดิการพนักงาน_ประกันรถยนต์'
    ...    9
    log many    ${val}    ${chal}
    ##Actions##
    Click Element    btnSubGroupByProduct
    Execute Javascript    window.scrollTo(0,2000)
    Sleep    3s
    Execute Javascript    $($('#ContentPlaceHolder1_pnSearchProduct > div > div')[0]).addClass("optWrapper okCancelInMulti multiple open")
    Sleep    10s
    Focus    //*[@id="ContentPlaceHolder1_pnSearchProduct"]/div/div/ul/li[${val}]/span/i
    Click Element    //*[@id="ContentPlaceHolder1_pnSearchProduct"]/div/div/ul/li[${val}]/span/i
    Sleep    5s
    Click Element    //*[@id="ContentPlaceHolder1_pnSearchProduct"]/div/div/div/p[1]
    Sleep    5s
    Click Element    imgExportExcel
    Sleep    2s

สรุปสถานะ-ประเภทรายการ
    [Arguments]    ${chal}
    #ประเภทรายการ
    ${val}    Set Variable If    '${chal}'=='ซื้อใหม่'    1    '${chal}'=='ต่ออายุ'    2
    log many    ${val}    ${chal}
    ##Actions##
    ClickElem    btnSubGroupByLeadType
    Sleep    3s
    Execute Javascript    $($('#ContentPlaceHolder1_pnSearchLeadType > div > div')[0]).addClass("optWrapper okCancelInMulti multiple open")
    Sleep    10s
    Focus    //*[@id="ContentPlaceHolder1_pnSearchLeadType"]/div/div/ul/li[1]/span/i
    Click Element    //*[@id="ContentPlaceHolder1_pnSearchLeadType"]/div/div/ul/li[1]/span/i
    Sleep    7s
    Click Element    //*[@id="ContentPlaceHolder1_pnSearchLeadType"]/div/div/div/p[1]
    Sleep    5s
    Click Element    imgExportExcel
    Sleep    2s

สรุปสถานะ-ช่องทาง
    [Arguments]    ${chal}
    [Documentation]    1. Unselect channal is't need show on table.
    #ช่องทาง
    ${val}    Set Variable If    '${chal}'=='Walk-IN'    1    '${chal}'=='Telesale'    2    '${chal}'=='Call Center'
    ...    3    '${chal}'=='BAY REFFERRAL'    4
    log many    ${val}    ${chal}
    ##Actions##
    ClickElem    btnSubGroupByChannel
    Sleep    3s
    Execute Javascript    $($('#ContentPlaceHolder1_pnSearchChannel > div > div')[0]).addClass("optWrapper okCancelInMulti multiple open")
    Sleep    10s
    Focus    //*[@id="ContentPlaceHolder1_pnSearchChannel"]/div/div/ul/li[${val}]/span/i
    Click Element    //*[@id="ContentPlaceHolder1_pnSearchChannel"]/div/div/ul/li[${val}]/span/i
    Sleep    5s
    Click Element    //*[@id="ContentPlaceHolder1_pnSearchChannel"]/div/div/div/p[1]
    Sleep    5s
    Click Element    imgExportExcel
    Sleep    2s

Lead on IOS- ส่ง IOS page ->ข้อมูลลูกค้า
    [Arguments]    ${status}    ${province}    ${aumpor}    ${tumbon}    ${post}    ${add}
    ##ข้อมูลทั่วไป##
    #สถานะ
    Sleep    2s
    Comment    ClickElem    //*[@id="CustomerView"]/table/tbody/tr[1]/td/div[2]/table/tbody/tr[1]/td/table/tbody/tr[2]/td[3]/span/span/span
    log many    ${status}    ${province}    ${aumpor}    ${tumbon}    ${post}    ${add}
    ${statusVal}=    Set variable if    '${status}'=='โสด'    1    '${status}'=='สมรส'    2    '${status}'=='หย่าร้าง'
    ...    3    '${status}'=='หม้าย'    4
    Execute Javascript    $k("#MARITAL_STATUS").data("kendoComboBox").selectedIndex = ${statusVal}
    Execute Javascript    $k("#MARITAL_STATUS").data("kendoComboBox").value('${status}')
    ##ที่อยู่ปัจจุบัน##
    ScrollIntoView    MAILING_ADDRESS_0
    ${addr_chk}    Get Value    CONTACT_ADDRESS_1
    Run Keyword If    "${addr_chk}"==""    ข้อมูลลูกค้า-ที่อยู่    ${province}    ${aumpor}    ${tumbon}    ${post}
    ...    ${add}
    Sleep    2s
    Execute Javascript    $('.buttonNext').click()

Lead on IOS- ส่ง IOS page ->ประกันภายและรายละเอียดผลิตภัณฑ์
    [Arguments]    ${carType}    ${sub_CarType}    ${brand}    ${classC}    ${license}    ${province}
    ...    ${CC}    ${weight}
    Wait Until Page Contains    กลุ่มผลิตภัณฑ์
    Sleep    2s
    ${product}    Execute Javascript    return $($('.productItem img')).attr('id')
    Run Keyword If    '${product}'=='imgPdtGroupKey14'    Non-Auto_พรบ    ${carType}    ${sub_CarType}    ${brand}    ${classC}
    ...    ${license}
    ...    ELSE IF    '${product}'=='imgPdtGroupKey15'    Non-Auto_ภาษี    ${carType}    ${sub_CarType}    ${brand}
    ...    ${classC}    ${province}    ${CC}    ${weight}
    ...    ELSE IF    '${product}'=='imgPdtGroupKey8'    Non-Auto_ประกันภัย
    ...    ELSE IF    '${product}'=='imgPdtGroupKey16'    Non-Auto_มะเร็ง
    ...    ELSE IF    '${product}'=='imgPdtGroupKey20'    Non-Auto_สวัสดิการประกัน PA
    ...    ELSE IF    '${product}'=='imgPdtGroupKey21'    Non-Auto_สวัสดิการประกันมะเร็ง
    #ตรวจสอบการทำประกัน
    Execute Javascript    $('#btnCheckInfo').click()
    sleep    10s
    Alert Should Be Present    \    ACCEPT

Lead on IOS- ส่ง IOS page ->ชำระเบี้ยประกัน
    [Arguments]    ${pay_type}    ${credit_no}
    Execute Javascript    $('.buttonNext').click()
    #รวมสุทธิ
    ${Amount}    Execute Javascript    return $('#lblSumTotalAmount').html()
    Sleep    2s
    #ชำระ
    Comment    Input Text    txtCashPayment    ${Amount}
    #วิธีชำระเงิน(799)
    Run Keyword If    '${pay_type}'=='เงินสด'    Run Keywords    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").value(1)
    ...    AND    ClickElem    //*[@id="sumary_panel"]/table/tbody/tr[11]/td[2]/span/span/input[1]
    ...    AND    Input Text    txtCashPayment    ${Amount}
    Run Keyword If    '${pay_type}'=='บัตรเครดิต'    Run Keywords    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").value(2)
    ...    AND    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").trigger('change')
    ...    AND    ClickElem    //*[@id="divPayTypeOptions"]/button
    ...    AND    Input Text    txtCreditCardNo    ${credit_no}
    ...    AND    ClickElem    //*[@id="tblCreditCard"]/tbody/tr[6]/td/button[1]
    Run Keyword If    '${pay_type}'=='หักเงินเดือน'    Run Keywords    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").value(4)
    ...    AND    Sleep    2s
    ...    AND    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").trigger('change')
    ...    AND    Execute Javascript    $('#btnSalaryOption').click()
    ...    AND    Input Text    txtEmployeeId    CF301591
    ...    AND    Execute Javascript    $k('#divSalaryOption div div select[data-role="dropdownlist"]').data('kendoDropDownList').value('Fri Aug 31 2018 00:00:00 GMT+0700 (Indochina Time)')
    ...    AND    Sleep    2s
    ...    AND    Execute Javascript    $('#divSalaryOption div div input[id="btnLicenseOk"]').click()
    Run Keyword If    '${pay_type}'=='Promotion'    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").value(6)
    Run Keyword If    '${pay_type}'=='Bill payment'    Run Keywords    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").value(7)
    ...    AND    ClickElem    //*[@id="sumary_panel"]/table/tbody/tr[11]/td[2]/span/span/input[1]
    ...    AND    Input Text    txtCashPayment    ${Amount}
    Run Keyword If    '${pay_type}'=='หักยอดสินเชื่อ (CV/On Top)'    Run Keywords    Execute Javascript    $k("#ddlPayType").data("kendoDropDownList").value(5)
    ...    AND    ClickElem    //*[@id="sumary_panel"]/table/tbody/tr[11]/td[2]/span/span/input[1]
    ...    AND    Execute Javascript    $('[name="radIsLoan"]').click()
    ...    AND    Input Text    txtCashPayment    ${Amount}
    #เสร็จสิ้น
    ClickElem    //*[@id="wizard"]/div[2]/a[1]
    sleep    5s
    ClickElem    xpath=//span[contains(text(),'OK')]

ข้อมูลลูกค้า-ที่อยู่
    [Arguments]    ${province}    ${aumpor}    ${tumbon}    ${post}    ${add}
    Execute Javascript    $k("#CONTACT_ADDRESS_COUNTRY").data("kendoComboBox").text('${province}')    #จังหวัด
    Execute Javascript    $k("#CONTACT_ADDRESS_COUNTRY").data("kendoComboBox").trigger('change')
    sleep    2s
    Execute Javascript    $k("#CONTACT_ADDRESS_CITY").data("kendoComboBox").text('${aumpor}')    #อำเภอ/เขต
    Execute Javascript    $k("#CONTACT_ADDRESS_CITY").data("kendoComboBox").trigger('change')
    sleep    2s
    Execute Javascript    $k("#CONTACT_ADDRESS_3").data("kendoComboBox").text('${tumbon}')    #ตำบล/แขวง
    Execute Javascript    $k("#CONTACT_ADDRESS_3").data("kendoComboBox").trigger('chnage')
    sleep    2s
    Execute Javascript    $k("#CONTACT_ZIP_CODE").data("kendoComboBox").text('${post}')    #รหัสไปรษณีย์
    Input Text    CONTACT_ADDRESS_1    ${add}    #บ้านเลขที่/ซอย/หมู่บ้าน
    Execute Javascript    $('#Checkbox2').click()    #ที่อยู่ส่งจดหมาย
    Execute Javascript    $('.buttonNext').click()

Non-Auto_ประกันภัย
    ###ผลิตภัฑณ์บริษัทประกัน
    sleep    1s
    Comment    Click Element    imgPdtGroupKey8
    Comment    ScrollIntoView    wizard
    Comment    ClickElem    xpath=//img[contains(@src,'img/product/SCI.png')]
    Comment    sleep    10s
    Click Element    xpath=//img[contains(@src,'img/product/PA50.png')]
    Comment    IOS-กลุ่มผลิตภัณฑ์-History
    ###รายละเอียดผลิตภัณ์
    #ตรวจสอบใบอนุญาต
    Wait Until Element Contains    txtSalesCode    \    90s
    Execute Javascript    $('[onclick="SalesCodeTextBoxOnChanged()"]').click()

Non-Auto_พรบ
    [Arguments]    ${carType}    ${sub_CarType}    ${brand}    ${classC}    ${license}
    ##ผลิตภัฑณ์บริษัทประกัน
    Comment    sleep    1s
    Comment    Click Element    xpath=//img[contains(@src,'img/product/CTP.png')]
    Comment    ScrollIntoView    wizard
    Comment    ClickElem    xpath=//img[contains(@src,'img/product/CTP.png')]
    ClickElem    //*[@id="ProductContainer"]/li[2]/img
    Sleep    5s
    #################
    ###รายละเอียดผลิตภัณ์
    Unselect Frame
    Select Frame    //iframe[1]
    #ตรวจสอบใบอนุญาต
    Sleep    3s
    ClickElem    //*[@class="btn btn-inverse"]
    #ประเภท
    ClickElem    //*[@id="FormContainer"]/table/tbody/tr[1]/td[2]/span/span[1]/span[2]
    ClickElem    //*[@id="Field46_listbox"]/li[contains(text(),'${carType}')]
    #ประเภทย่อย
    ClickElem    //*[@id="FormContainer"]/table/tbody/tr[2]/td[2]/span/span/span[2]
    ClickElem    //*[@id="Field45_listbox"]/li[contains(text(),'${sub_CarType}')]
    Input Text    Field40    ${license}
    #จังหวัดที่จดทะเบียน
    ClickElem    //*[@id="Field27"]/span/span[1]/span[2]
    ${province}    Execute Javascript    return $k('#Field27').cfgprovince({value:1})
    log    ${province}
    Comment    Click Element    ${province}
    #ยี่ห้อรถ
    ClickElem    //*[@id="FormContainer"]/table/tbody/tr[5]/td[2]/span/span/span[2]
    ClickElem    //*[@id="Field21_listbox"]/li[157]
    #หมายเลขคัสซี (เลขตัวถัง)
    Input Text    Field19    ${classC}

Non-Auto_ภาษี
    [Arguments]    ${carType}    ${sub_CarType}    ${brand}    ${classC}    ${province}    ${CC}
    ...    ${weight}
    ##ผลิตภัฑณ์บริษัทประกัน
    sleep    1s
    Comment    ClickElem    imgPdtGroupKey8
    Comment    ScrollIntoView    wizard
    Comment    ClickElem    xpath=//img[contains(@src,'img/product/SCI.png')]
    #ผลิตภัณฑ์
    ClickElem    xpath=//img[contains(@src,'img/product/TAX10.png')]
    #################
    #ตรวจสอบใบอนุญาต
    Execute Javascript    $('[onclick="SalesCodeTextBoxOnChanged()"]').click()
    #ประเภท
    Execute Javascript    $k('#ddl_FormContainer_CarType').data("kendoDropDownList").value(12);
    Execute Javascript    $k('#ddl_FormContainer_CarType').data("kendoDropDownList").trigger('change');
    #ประเภทย่อย
    Sleep    2s
    Execute Javascript    $k('#ddl_FormContainer_SubCarType').data("kendoDropDownList").value('1.30A');
    #จังหวัดที่จดทะเบียน
    Execute Javascript    $k('#ddl_FormContainer_CarProvince').data("kendoDropDownList").value(2);
    #วันที่จดทะเบียนรถ
    Execute Javascript    $k("#txt_FormContainer_CarRegisDate").cfgdatepicker({uiLocale: 'TH', culture: "th-TH", value: new Date(2015,10,15), format: "dd MMMM yyyy" })
    callDate_วันครบกำหนดเสียภาษี
    #ประเภทเชื้อเพลิง
    Execute Javascript    $k('#ddl_FormContainer_FuelType').data("kendoDropDownList").value('G');
    #ขนาดเครื่องยนต์
    Sleep    2s
    Execute Javascript    $k("#txt_FormContainer_CC").kendoNumericTextBox({step: 1,min: 1,decimals: 0,spinners: false,placeholder: "2000",value: 2000})
    #น้ำหนักรถ
    Sleep    2s
    Execute Javascript    $k("#txt_FormContainer_Weight").kendoNumericTextBox({step: 1,min: 1,decimals: 0,spinners: false,placeholder: "2000",value: 2000})
    #เลขตัวถัง
    Input Text    txt_FormContainer_Chessis    ${classC}
    #สำเนาทะเบียนรถ
    Sleep    2s
    Choose File    file_FormContainer_CarBook1    ${CURDIR}\\pic01.jpg    #(หน้ารายการจดทะเบียนและหน้าเจ้าของรถ):
    Click Element    btnfile_FormContainer_CarBook1
    Choose File    file_FormContainer_CarBook2    ${CURDIR}\\pic02.jpg    #(หน้ารายการเสียภาษี):
    Click Element    btnfile_FormContainer_CarBook2
    Choose File    file_FormContainer_CTP    ${CURDIR}\\pic03.jpg    #(พ.ร.บ.):
    Click Element    btnfile_FormContainer_CTP
    Sleep    10s
    Execute Javascript    if($('#btnCheckInfo').click()){$('#txt_FormContainer_CarAge').val(2);}

Non-Auto_มะเร็ง
    ###ผลิตภัฑณ์บริษัทประกัน
    Comment    ClickElem    imgPdtGroupKey8
    Comment    ScrollIntoView    wizard
    Comment    ClickElem    xpath=//img[contains(@src,'img/product/SCI.png')]
    ClickElem    xpath=//img[contains(@src,'img/product/CAN02.png')]
    sleep    3s
    #################
    ###รายละเอียดผลิตภัณ์
    Comment    Sleep    5s
    Comment    Unselect Frame
    Comment    Select Frame    //iframe[1]
    #ตรวจสอบใบอนุญาต
    Execute Javascript    $("[onclick='SalesCodeTextBoxOnChanged()']").click()

Non-Auto_สวัสดิการประกัน PA
    ###ผลิตภัฑณ์บริษัทประกัน
    Comment    Click Element    imgPdtGroupKey8
    Comment    ScrollIntoView    wizard
    Comment    ClickElem    xpath=//img[contains(@src,'img/product/SCI.png')]
    ClickElem    xpath=//img[contains(@src,'img/product/PA-799-(S).png')]
    #ตรวจสอบใบอนุญาต
    Execute Javascript    $('[onclick="SalesCodeTextBoxOnChanged()"]').click()

Non-Auto_สวัสดิการประกันมะเร็ง
    ###ผลิตภัฑณ์บริษัทประกัน
    Comment    ClickElem    imgPdtGroupKey8
    Comment    ScrollIntoView    wizard
    Comment    ClickElem    xpath=//img[contains(@src,'img/product/SCI.png')]
    ClickElem    xpath=//img[contains(@src,'img/product/SJNT2.png')]
    sleep    3s
    #ตรวจสอบใบอนุญาต
    Execute Javascript    $('[onclick="SalesCodeTextBoxOnChanged()"]').click()

IOS-กลุ่มผลิตภัณฑ์-History
    Wait Until Page Contains    History
    sleep    5s
    ${history_page}    Run Keyword And Return Status    Page Should Contain Element    //*[@class="rwTitleRow"]
    Log    ${history_page}
    Run Keyword If    ${history_page}== True    Run Keywords    Select Frame    //iframe
    ...    AND    Sleep    5s
    ...    AND    Click Element    //*[@id="ctl00_RadAjaxPanel"]/table/tbody/tr/td[1]/button
    ...    ELSE    Log    Not has History page
    Comment    Select Frame    //iframe
    Comment    Click Element    //*[@id="ctl00_RadAjaxPanel"]/table/tbody/tr/td[1]/button

Renew_Bill payment
    #รายละเอียดประกันเสนอลูกค้า
    Sleep    3s
    Comment    Click Element    //*[@id="tbPresentDetail"]/tbody/tr[1]/td[1]/input
    #ส่งงาน
    Comment    ClickElem    btnFollowGroupForward    #คลิ๊กส่งงาน
    Comment    ClickElem    //*[@id="ddlLeadDetailFollowStatus"]/option[2]    #เลือกสถานะ
    Comment    Input Text    txtLeadDetailUserId    cf301591
    Comment    Comment    ClickElem    //*[@value='HO']    #ระบุสาขา
    #ส่ง IOS
    Execute Javascript    window.scrollTo(0,500)
    Execute Javascript    $('#btnFollowGroupRequestDetail').click()
    #บันทึกส่งงาน
    Sleep    2s
    Execute Javascript    $('#btnLeadDetailSubmit').click()
    ###
    Sleep    30s
    Alert Should Be Present    \    ACCEPT

Renew_Bill payment NonAuto
    [Arguments]    ${type}
    #ส่งงาน
    Comment    ClickElem    btnFollowGroupForward    #คลิ๊กส่งงาน
    Comment    ClickElem    //*[@id="ddlLeadDetailFollowStatus"]/option[@value="5"]    #เลือกสถานะ
    Comment    ClickElem    //*[@id="ContentPlaceHolder1_ddlLeadDetailBranch"]/option[@value="HA"]
    Comment    Comment    Input Text    txtLeadDetailUserId    cf301591
    #รายละเอียดประกันเสนอลูกค้า
    Sleep    3s
    Click Element    //*[@id="tbPresentDetail"]/tbody/tr[1]/td[1]/input
    #ส่ง IOS
    Execute Javascript    window.scrollTo(0,500)
    Execute Javascript    $('#btnFollowGroupRequestDetail').click()
    #บันทึกส่งงาน
    Sleep    2s
    Execute Javascript    $('#btnLeadDetailSubmit').click()
    ###
    Sleep    30s
    Alert Should Be Present    \    ACCEPT

ข้อมูลไฟล์แนบ
    #สำเนาบัตรประชาชน
    ${file1}    Run Keyword And Return Status    Page Should Contain    สำเนาบัตรประชาชน
    Run Keyword If    ${file1}==True    Run Keywords    Choose File    xpath=//*[@id="file_01"]    ${CURDIR}\\pic01.jpg
    ...    AND    Input Text    Commentfile_01    สำเนาบัตรประชาชน
    #สำเนาเล่มทะเบียน
    ${file2}    Run Keyword And Return Status    Page Should Contain    สำเนาเล่มทะเบียน
    Run Keyword If    ${file2}==True    Run Keywords    Choose File    xpath=//*[@id="file_02"]    ${CURDIR}\\pic02.jpg
    ...    AND    Input Text    Commentfile_02    สำเนาเล่มทะเบียน
    #รูปหน้ารถ
    ${file3}    Run Keyword And Return Status    รูปหน้ารถ
    Run Keyword If    ${file3}==True    Run Keywords    Choose File    xpath=//*[@id="file_03"]    ${CURDIR}\\pic03.jpg
    ...    AND    Input Text    Commentfile_03    รูปหน้ารถ
    #รูปหน้ารถ
    ${file4}    Run Keyword And Return Status    รูปหน้ารถ
    Run Keyword If    ${file4}==True    Run Keywords    Choose File    xpath=//*[@id="file_04"]    ${CURDIR}\\pic04.jpg
    ...    AND    Input Text    Commentfile_04    รูปหน้ารถ
    #รูปด้านขวา
    ${file5}    Run Keyword And Return Status    รูปด้านขวา
    Run Keyword If    ${file5}==True    Run Keywords    Choose File    xpath=//*[@id="file_05"]    ${CURDIR}\\pic05.jpg
    ...    AND    Input Text    Commentfile_05    รูปด้านขวา
    #รูปด้านซ้าย
    ${file6}    Run Keyword And Return Status    รูปด้านซ้าย
    Run Keyword If    ${file6}==True    Run Keywords    Choose File    xpath=//*[@id="file_06"]    ${CURDIR}\\pic06.jpg
    ...    AND    Input Text    Commentfile_06    รูปด้านซ้าย
    #เอกสารอื่นๆ 1
    ${file_other}    Run Keyword And Return Status    เอกสารไฟล์แนบอื่นๆ
    Run Keyword If    ${file_other}==True    Run Keywords    Choose File    file_99_1    ${CURDIR}\\pic07.jpg
    ...    AND    Input Text    Commentfile_99_1    เอกสารอื่นๆ 1

Page_Update Status Bill Payment
    ##รายละเอียดส่วนที่ 1
    Wait Until Page Contains Element    liStep2
    Unselect Frame
    Select Frame    //iframe[1]
    focus    liStep2
    Sleep    5s
    Click Element    liStep2
    Click Element    //*[@id="div3"]/table/tbody/tr[3]/td[2]/span/span/span[2]    #ตำบล
    Comment    Click Element    //*[@id="ddlContactSubDistrict_listbox"]/li[5]
    Click Element    //*[@id="div3"]/table/tbody/tr[3]/td[4]/span/span/span[2]    #รหัสไปรณีย์
    Comment    Click Element    //*[@id="ddlContactZipcode_listbox"]/li[2]
    ClickElem    liStep2
    ##รายละเอียดส่วนที่ 2
    Sleep    5s
    ClickElem    //*[@id="wizard"]/div[2]/a[2]
    ##ชำระเงิน
    ClickElem    //*[@id="divLicenseDetail"]/table/tbody/tr/td[3]/button
    Sleep    5s
    ${Amount}    Execute Javascript    return $('#lblSumTotalAmount').html()
    Click Element    //*[@id="trPayCash"]/td[2]/span/span
    Sleep    2s
    Input Text    txtCashPayment    ${Amount}
    ScrollIntoView    txtCashPayment
    Sleep    2s
    ClickElem    //*[@id="wizard"]/div[2]/a[1]
    Alert Should Be Present    ยืนยันการบันทึกข้อมูล    ACCEPT
    Alert Should Be Present    \    ACCEPT

รายละเอียดความคุ้มครอง
    Select Frame    //iframe
    Sleep    15s
    ##set var##
    ${getID}    Execute Javascript    return $($("[id^='main_'][style!='display:none;']").get()).attr("id")
    ${QT}    Get Substring    ${getID}    5    16
    ${INS}    Get Substring    ${getID}    5    20
    ${INS_Type}    Get Substring    ${getID}    5
    log many    ${QT}    ${INS}    ${INS_Type}
    ###
    Comment    ScrollIntoView    div_form_${QT}
    Execute Javascript    window.scrollTo(0,1500)
    Sleep    2s
    Execute Javascript    $('#toggle_${INS}').trigger("click")
    Unselect Frame
    Select Frame    //iframe
    : FOR    ${n}    IN RANGE    1    20
    \    ${almost1}    Get Value    //*[@id="${INS_Type}"]/td[${n}]/input
    \    Run Keyword If    '${n}'!='18'    Run Keyword If    '${almost1}'=='0'    Input Text    //*[@id="${INS_Type}"]/td[${n}]/input
    \    ...    1
    ScrollIntoView    btnApplyData
    Execute Javascript    $('#btnApplyData').trigger("click")
    Wait Until Page Contains    ทำการบันทึกเรียบร้อย
    Sleep    10s
    Click Element    //*[@id="divMessage"]/button
    Comment    Execute Javascript    $('#divMessage button').trigger("click")
    #อนุมัติ
    Execute Javascript    $('#btn_wf_Approved').trigger("click")
    Run Keyword And Ignore Error    Alert Should Be Present    มีข้อมูลของบริษัทประกันบางเจ้า กรอกข้อมูลไม่สมบูรณ์ ต้องการทำรายการต่อหรือไม่ ?    ACCEPT    2s
    Sleep    2s
    ScrollIntoView    divWorkFlowActiveHeader
    #comment อนุมัติ
    Execute Javascript    $('#selectCommentCategory').val("1")
    Input Text    txtFreeComment    Test Pass
    Comment    ClickElem    btnSendWorkFlow
    Execute Javascript    $('#btnSendWorkFlow').trigger("click")
    Alert Should Be Present    \    ACCEPT

ประเภทชำระเงิน-บัตรเครดิต
    [Arguments]    ${cradit_type}    ${cradit_no}
    Click Element    radPaymentType_2
    ClickElem    //*[@name="radInstallment"]
    Comment    ClickElem    //*[@id="tr2Credit"]/td[2]/span/span/span[2]
    Comment    Wait Until Page Contains    VISA    15s
    Comment    ClickElem    //*[@id="ddlCardType_listbox"]/li[1]
    Comment    ClickElem    //*[@id="ddlCardType_listbox"]/li[contains(text(),'${cradit_type}')]
    Input Text    txtCreditCardNo    ${cradit_no}
    Choose File    filePayType_13    ${CURDIR}\\pic01.jpg

callDate_วันครบกำหนดเสียภาษี
    ${result}=    Execute Javascript    var carRegistDate = $k('#txt_FormContainer_CarRegisDate').cfgdatepicker("getDateValue");    var carRegistDate_year = carRegistDate.getFullYear();    var carRegistDate_month = carRegistDate.getMonth();    var carRegistDate_date = carRegistDate.getDate();    var coverenddate = new Date();
    ...    var today_date = coverenddate;    var today_year = today_date.getFullYear();    var today_month = today_date.getMonth();    var today_day = today_date.getDate();    var _carAge = today_year - carRegistDate_year;    if (today_month < carRegistDate_month){_carAge = _carAge - 1}
    ...    if ((carRegistDate_month == today_month) && (today_day < carRegistDate_date)) {_carAge = _carAge - 1;}    if (_carAge <= 0) {_carAge = _carAge + 1;}    $('#txt_FormContainer_CarAge').val(_carAge);    #push value on text box

loop check
    : FOR    ${n}    IN    1    20
    \    sleep    20s
    \    ${zipcode}    Execute Javascript    return $("#ddlMaillingZipCode").val()
    \    Log    ${zipcode}
    \    Run Keyword If    '${n}'=='${zipcode}'    Exit For Loop

Work List
    [Arguments]    ${name}
    Sleep    2s
    Click Element    m_112    #worklist page
    Select Frame    //iframe[1]
    Wait Until Element Is Visible    TotalWorkList    60s
    Click Element    TotalWorkList    #รายการค้าง/รับ-ส่งงาน
    Wait Until Element Is Visible    TableK2WolkList_filter    60s
    Input Text    //*[@id="TableK2WolkList_filter"]/label/input    ${name}    # search Jobs
    Comment    #Open Jobs
    Comment    Execute Javascript    $('[src="img/external-link.png"]').click()

verify by sale support
    Execute Javascript    window.scrollTo(0,2000)
    Sleep    5s
    Select Frame    //iframe
    Execute Javascript    $('#btn_wf_Approved').click()
    Sleep    2s
    Execute Javascript    $('#selectCommentCategory').val("1")
    Click Element    btnSendWorkFlow
    Alert Should Be Present    \    ACCEPT    120s

IOS Print
    [Arguments]    ${Name}
    Comment    Unselect Frame
    Comment    Select Frame    //iframe[1]
    Comment    WaitElementVisible    //div[@id='IOS_WorkList']/div[@id='ctl00_ContentPlaceHolder1_RadGrid1']/table
    Sleep    2s
    ${printId}    Execute Javascript    return $($($('#ctl00_ContentPlaceHolder1_RadGrid1_ctl00 tr td:contains("${Name}")').get()).parent().find("td input[src='img/Print-1.png']")).attr("id")
    Log Many    ${printId}    ${Name}
    Click Element    ${printId}
    Sleep    3s
    Click element    xpath=//span[contains(text(),'OK')]
    Sleep    10s

รายงานการติดตาม
    [Arguments]    ${Name}
    Click Element    m_203    #Lead on IOS
    Sleep    2s
    Click Element    m_205    #รายการติดตาม
    Select Frame    //iframe
    Wait Until Element Is Visible    txtSearchFirstName    10s
    sleep    1s
    Comment    Click Element    rdoAllBranchsItemType
    Execute Javascript    $('#txtSearchFirstName').val('${Name}')
    sleep    1s
    Execute Javascript    $('#btnSearch').click()    #ค้นหา
    sleep    2s

Pay type_ เงินสด
    WaitElementVisible    xpath=//*[@id="step-4"]
    ClickElem    //*[@id="div2"]/table/tbody/tr[1]/td/div/input[1]    #ข้อมูลผู้รับผลประโยชน์
    ClickElem    radPaymentType_1
    Sleep    2s
    Execute Javascript    $('.buttonFinish').click()
    Alert Should Be Present    \    ACCEPT    90s
    Alert Should Be Present    \    ACCEPT    90s

Pay type_ CV
    WaitElementVisible    xpath=//*[@id="step-4"]
    ClickElem    //*[@id="div2"]/table/tbody/tr[1]/td/div/input[1]    #ข้อมูลผู้รับผลประโยชน์
    Click Element    radPaymentType_5
    Execute Javascript    $('[name="radIsLoan"]').click()
    Choose File    filePayType_07    ${CURDIR}\\pic02.jpg
    Sleep    2s
    Execute Javascript    $('.buttonFinish').click()
    Alert Should Be Present    \    ACCEPT    10s
    Alert Should Be Present    \    ACCEPT    20s

Paytype_Credit
    [Arguments]    ${Credit no}
    WaitElementVisible    xpath=//*[@id="step-4"]
    ClickElem    //*[@id="div2"]/table/tbody/tr[1]/td/div/input[1]    #ข้อมูลผู้รับผลประโยชน์
    ClickElem    radPaymentType_2
    Input Text    txtCreditCardNo    1235963258555555
    Choose File    filePayType_13    ${CURDIR}\\pic01.jpg
    Sleep    1s
    Execute Javascript    $('.buttonFinish').click()
    Alert Should Be Present    \    ACCEPT    90s
    Alert Should Be Present    \    ACCEPT    90s

Paytype_CL
    WaitElementVisible    xpath=//*[@id="step-4"]
    ClickElem    //*[@id="div2"]/table/tbody/tr[1]/td/div/input[1]    #ข้อมูลผู้รับผลประโยชน์
    ClickElem    radPaymentType_8
    Sleep    2s
    Execute Javascript    $('.buttonFinish').click()
    Alert Should Be Present    \    ACCEPT    90s
    Alert Should Be Present    \    ACCEPT    90s

MasterFileRequest_FULL
    #สำเนาบัตรประชาชน
    Choose File    file_01    ${CURDIR}\\pic01.jpg
    Input Text    Commentfile_01    สำเนาบัตรประชาชน
    #สำเนาเล่มทะเบียน
    Choose File    file_02    ${CURDIR}\\pic02.jpg
    Input Text    Commentfile_02    สำเนาเล่มทะเบียน
    #รูปหน้ารถ
    Choose File    file_03    ${CURDIR}\\pic03.jpg
    Input Text    Commentfile_03    รูปหน้ารถ
    #รูปหลังรถ
    Choose File    file_04    ${CURDIR}\\pic04.jpg
    Input Text    Commentfile_04    รูปหลังรถ
    #รูปด้านขวา
    Choose File    file_05    ${CURDIR}\\pic05.jpg
    Input Text    Commentfile_05    รูปด้านขวา
    #รูปด้านซ้าย
    Choose File    file_06    ${CURDIR}\\pic06.jpg
    Input Text    Commentfile_06    รูปด้านซ้าย
    #เอกสารอื่นๆ 1
    Choose File    file_99_1    ${CURDIR}\\pic07.jpg
    Input Text    Commentfile_99_1    เอกสารอื่นๆ 1

MasterFileRequest
    #สำเนาบัตรประชาชน
    Comment    Select Frame    //iframe
    Choose File    file_01    ${CURDIR}\\pic01.jpg
    Input Text    Commentfile_01    สำเนาบัตรประชาชน
    #สำเนาเล่มทะเบียน
    Comment    Select Frame    //iframe
    Choose File    file_02    ${CURDIR}\\pic02.jpg
    Input Text    Commentfile_02    สำเนาเล่มทะเบียน

รายละเอียดผู้ขับขี่
    Execute Javascript    $('#chkDriver').click()
    Execute Javascript    $('#txtDriver1Licence').val('258123625945218')
    Comment    Execute Javascript    $('#imgDriver').click()
