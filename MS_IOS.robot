*** Settings ***
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
Resource          ../Resource/connectDatabase.robot
Resource          ../Resource/MS_IOS.robot

*** Variables ***

*** Keywords ***
Lead on IOS-VERIFY INPUT Page->ข้อมูลลูกค้า_Revise
    [Arguments]    ${status}    ${business}    ${currier}    ${exp}    ${acc}    ${finance}
    ...    ${use}    ${freq}    ${addr}    ${prov}    ${aump}    ${tumb}
    ...    ${post}    ${marital}
    [Documentation]    1.ข้อมูลลูกค้า
    ##ข้อมูลทั่วไป##
    Select Frame    //iframe[1]
    Sleep    1s
    Comment    ข้อมูลลูกค้า-ข้อมูลทั่วไป_Revise    ${status}    ${business}    ${currier}    ${exp}    ${acc}
    ...    ${finance}    ${use}    ${freq}    ${marital}
    #ที่อยู่
    Sleep    1s
    ScrollIntoView    txtCustomerCurrentAddress
    Input Text    txtCustomerCurrentAddress    258/632 รีเวิค ทดสอบ
    Sleep    2s
    Comment    #reset
    Comment    Execute Javascript    $("#ddlCustomerCurrentProvince").data("kendoComboBox").value("")
    Comment    Execute Javascript    $("#ddlCustomerCurrentDistrict").data("kendoComboBox").value("")
    Comment    Execute Javascript    $("#ddlCustomerCurrentSubDistrict").data("kendoComboBox").value("")
    Comment    Sleep    3s
    Comment    #จังหวัด : กรุงเทพ
    Comment    Execute Javascript    var AA = $("#ddlCustomerCurrentProvince").data("kendoComboBox"); AA.select(0);
    Comment    Sleep    3s
    Comment    Execute Javascript    $("#ddlCustomerCurrentProvince").data("kendoComboBox").trigger("change");
    Comment    Sleep    3s
    Comment    #อำเภอ : บางรัก
    Comment    Execute Javascript    var AA = $("#ddlCustomerCurrentDistrict").data("kendoComboBox"); AA.select(3);
    Comment    Sleep    3s
    Comment    Execute Javascript    $("#ddlCustomerCurrentDistrict").data("kendoComboBox").trigger("change")
    Comment    Sleep    3s
    Comment    #ตำบล : บางรัก
    Comment    Click Element    $("#ddlCustomerCurrentSubDistrict").data("kendoComboBox").value(31)
    Comment    Sleep    3s
    Comment    Click Element    $("#ddlCustomerCurrentSubDistrict").data("kendoComboBox").trigger('change')
    Comment    Sleep    3s
    Comment    #เหมือนที่อยู่ปัจจุบัน
    Comment    Execute Javascript    $('#chkDupAddressToMaillingAddress').click()
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[1]/span/span/span/span    #จังหวัด
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentProvince_listbox"]/li[contains(text(),'กรุงเทพมหานคร')]
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[2]/span/span/span/span    #อำเภอ
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentDistrict_listbox"]/li[contains(text(),'เขตบางรัก')]
    Sleep    2s
    Click Element    xpath=//*[@id="tblGeneralCustomerData"]/tbody/tr[4]/td[3]/span/span/span/span    #ตำบล
    Sleep    3s
    Click Element    xpath=//*[@id="ddlCustomerCurrentSubDistrict_listbox"]/li[contains(text(),'บางรัก')]
    Click Element    chkDupAddressToMaillingAddress    #เหมือนที่อยู่ปัจจุบัน
    #Next
    Sleep    2s
    Execute Javascript    $('.buttonNext').click()

Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_Revise
    [Arguments]    ${CarRegProvince}    ${ChassisNo}    ${EngineNo}    ${CarCC}    ${CarWeight}
    #ข้อมูลรถ
    ScrollIntoView    lblQuoteTypeName
    ##GetId
    ${getId}    Execute Javascript    return $($("input[id*='txtCarLicence']").get()).attr("id")
    ${subId}    Get Substring    ${getId}    14
    Log To Console    ==========${subId}====
    Sleep    2S
    #จังหวัดที่จดทะเบียน
    Execute Javascript    $('#ddlCarRegisProvince_${subId}').data("kendoDropDownList").value(2);
    #เลขตัวถัง
    Comment    Input Text    txtChassisNo_${subId}    ${ChassisNo}
    #เลขเครื่องยนต์
    Input Text    txtEngineNo_${subId}    SFSDF534564
    #ขนาดเครื่องยนต์
    Input Text    txtCarCC_${subId}    1000
    #น้าหนักรวม(Kg)
    Input Text    txtWeight_${subId}    5000
    #####ข้อมูลไฟล์แนบ
    ${File}=    Execute Javascript    return $('#tblMasterFileRequest tbody tr').length
    Run Keyword If    '${File}'=='7'    FileRequest_FUll
    ...    ELSE    FileRequest
    ##Next
    Sleep    2s
    Execute Javascript    $('.buttonNext').click()
    #Next หน้ารายงานการคุ้มครอง
    Sleep    2s
    Execute Javascript    $('.buttonNext').click()
    Sleep    2s

Lead on IOS-VERIFY INPUT Page->ข้อมูลใบเสนอราคา_รถบรรทุก_Revise
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

Lead on IOS-VERIFY INPUT Page->ข้อมูลความคุ้มครอง_Revise
    WaitElementVisible    xpath=//*[@id="step-3"]
    ##รายละเอียดผู้ขาย
    Execute Javascript    $('#btnCheckLicense').click()    #ตรวจสอบใบอนุญาต
    ##Next
    Execute Javascript    $('.buttonNext').click()

Lead on IOS-VERIFY INPUT Page->ข้อมูลชำระเงิน_Revise
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

ข้อมูลลูกค้า-ข้อมูลทั่วไป_Revise
    [Arguments]    ${status}    ${business}    ${currier}    ${exp}    ${acc}    ${finance}
    ...    ${use}    ${freq}    ${marital}
    #สถานะ
    Comment    Execute Javascript    $("#ddlMARITAL_STATUS").data("kendoDropDownList").value(3)
    ##กลุ่มธุรกิจ##
    Execute Javascript    $("#ddlBUSSINESS_GROUP").data("kendoDropDownList").value(3);
    ##อาชีพ##
    Execute Javascript    $("#ddlOCCUPATION").data("kendoDropDownList").value('03');
    #ประสบการณ์การขับรถ
    Execute Javascript    $('[name="radDriveExprerience"][value="02"]').click()
    # ปีที่ผ่านมาเกิดอุบัติเหตุหรือไม่
    Execute Javascript    $('[name="radFreqInAccident"][value="02"]').click()
    #ลักษณะการใช้รถ
    Execute Javascript    $('[name="radUsingCharacteristicID"][value="02"]').click()
    #ความถี่ในการใช้รถ
    Execute Javascript    $('[name="radUseType"][value="02"]').click()

verify by sale support : Rework
    [Arguments]    ${QV}
    ${LicensePre}=    Random CarId_1
    ${LicenseLast}=    Random CarId_2
    ${Name}=    Random Name
    ${LastName}=    Random Name
    ${Crassis}=    Random Credit
    #Open Jobs
    Execute Javascript    $('[src="img/external-link.png"]').click()
    Select Frame    //iframe[1]
    WaitElementVisible    btnEditCustomerInfo
    Comment    ## 1. แก้ไขข้อมูลลูกค้า
    Execute Javascript    $('#btnEditCustomerInfo').click()
    Sleep    3s
    ${title}    Execute Javascript    return $k('#ddlTITLE').val()
    Execute Javascript    $k('#ddlTITLE').val("${title}")    #คำนำหน้าชื่อ
    Execute Javascript    $("#dddlMaritalStatus").data("kendoDropDownList").value(2)    #Status
    Execute Javascript    $('#ttxtCustomerFirstName').val('เปลี่ยนชื่อ${Name}')    #ชื่อ
    Execute Javascript    $('#ttxtCustomerLastName').val('เปลี่ยนสกุล${LastName}')    #นามสกุล
    Execute Javascript    $('#ttxtEmail').val('change-mail@Test.com')    #E-Mail
    Execute Javascript    $('#btnEditCustomerOk').click()
    Alert Should Be Present    \    ACCEPT    2s
    Execute Javascript    $('[class="buttonNext"]').click()
    ## 2. แก้ไขข้อมูลรถ
    Sleep    2s
    Execute Javascript    $('[onclick^="showCarDetail"]').click()
    Sleep    2s
    Execute Javascript    $('[id^="txtLicensePrefix"]').val("${LicensePre}")    #ทะเบียน
    Execute Javascript    $('[id^="txtLicenseNo"]').val("${LicenseLast}")    #ทะเบียน2
    Comment    Execute Javascript    $('[id^="ttxtChassisNo"]').val("${Crassis}")    #เลขตัวถัง
    Execute Javascript    $('[id^="ttxtCarCC"]').val("20005")    #เลขเครื่องยนต์
    Execute Javascript    $('[id^="ttxtWeight"]').val("90001")    #ขนาดเครื่องยนต์
    Execute Javascript    $('[id^="btnEditCar"]').click()    #น้ำหนักรวม (kg)
    Alert Should Be Present    \    ACCEPT
    Sleep    2s
    Execute Javascript    $('[class="buttonNext"]').click()
    Sleep    2s
    # ข้อมูลคุ้มครอง
    Execute Javascript    $('[class="buttonNext"]').click()
    #แก้ไขข้อมูลผู้รับผลประโยชน์
    Comment    Execute Javascript    $('#btnEditCustomerIsLoan').click()
    Comment    Sleep    2s
    Comment    Execute Javascript    $('[class="buttonFinish"]').click()
    #ส่งแก้ไข
    Sleep    2s
    Execute Javascript    $('#btn_wf_Rework').click()
    Sleep    2s
    Execute Javascript    $('#selectCommentCategory').val("1")
    Sleep    2s
    Execute Javascript    $('#txtFreeComment').val("ReworkJOB")
    Sleep    2s
    Execute Javascript    $('#btnSendWorkFlow').click()
    Alert Should Be Present    ทำการบันทึกข้อมูลเรียบร้อย    ACCEPT    60s
    Sleep    3s

Reworking
    [Arguments]    ${name}
    ${LicensePre}=    Random CarId_1
    ${LicenseLast}=    Random CarId_2
    ${Name_Change}=    Random Name
    ${LastName}=    Random Name
    ${Crassis}=    Random Credit
    Select Frame    //iframe[1]
    WaitElementVisible    //div[@id='IOS_WorkList']/div[@id='ctl00_ContentPlaceHolder1_RadGrid1']/table
    Execute Javascript    $('[href="#K2_WorkList"][onclick="checkAuthorizedHeight();"]').click()
    #Search:
    Sleep    2s
    Input Text    //*[@id="TableK2WolkList_filter"]/label/input    ${name}    # search Jobs
    Press Key    //*[@type="search"]    \\13
    #Open Jobs
    Execute Javascript    $('[src="img/external-link.png"]').click()

Verify_ข้อมูลลูกค้า_ที่อยู่_Revise
    [Arguments]    ${addr}    ${prov}    ${aump}    ${tumb}    ${post}
    Input Text    txtCustomerCurrentAddress    258/632 รีเวิค ทดสอบ
    Sleep    3s
    Execute Javascript    $('#chkDupAddressToMaillingAddress').click()    #เหมือนที่อยู่ปัจจุบัน

Send revise
    Sleep    2s
    #Save
    Comment    Execute Javascript    $('.buttonFinish').click()
    Comment    Alert Should Be Present    ยืนยันการบันทึกข้อมูล?    ACCEPT    20s
    Comment    Alert Should Be Present    ทำการบันทึกข้อมูลเรียบร้อย    ACCEPT    20s
    Sleep    2s
    #ยืนยันการ revise
    Execute Javascript    $('#btn_wf_Confirm').click()
    Sleep    2s
    Execute Javascript    $('#selectCommentCategory').val("1")    #comment
    Execute Javascript    $('#txtFreeComment').val('Reworking Finished')    #comment
    Sleep    2s
    Execute Javascript    $('#btnSendWorkFlow').click()    #บันทึก
    Sleep    2s
    Alert Should Be Present    ทำการบันทึกข้อมูลเรียบร้อย    ACCEPT    60s

Get QV
    [Arguments]    ${lead no}    ${QT}    ${name}
    Sleep    2s
    Click Element    m_112    #worklist page
    Select Frame    //iframe[1]
    Click Element    TotalWorkList    #รายการค้าง/รับ-ส่งงาน
    Comment    Input Text    //*[@id="TableK2WolkList_filter"]/label/input    ${name}
    Sleep    2s
    Execute Javascript    var param = { quoteHeaderId: "",leadId: ${lead no},quoteNumber: "${QT}"};var aa = ''; ios_web_request("/generic/transaction/quotationOnline/QuotationInfo.ashx", "getQuotationsData", param, function (res){if (!res.IsError){$.each(res.Data,function (i,item){$.each(item.Details,function(i2,item2){if(item2.WorkflowStatus=='Opened'){aa = item2.VerifyRunningNo;alert(aa); }});});}});
    Sleep    2s
    ${getQV}=    Handle Alert    ACCEPT
    ${QV}=    Set Variable    ${getQV}
    Input Text    //*[@id="TableK2WolkList_filter"]/label/input    ${QV}
    [Return]    ${QV}

Get Running
    [Arguments]    ${name}
    Sleep    3.5s
    Select Frame    //iframe[1]
    ${Running}=    Execute Javascript    return $($('#ctl00_ContentPlaceHolder1_RadGrid1_ctl00 tr td:contains("${name}")').get()).parent().find("td:contains('18')").html()
    [Return]    ${Running}

BK_FILE
    #สำเนาบัตรประชาชน
    ${file1}    Run Keyword And Return Status    Page Should Contain    สำเนาบัตรประชาชน
    Run Keyword If    ${file1}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_01    ${CURDIR}\\pic01.jpg
    ...    AND    Input Text    Commentfile_01    สำเนาบัตรประชาชน
    Execute Javascript    alert('ตรวจสอบสำเนาบัตรประชาชน')
    Sleep    2s
    Alert Should Be Present    \    ACCEPT
    #สำเนาเล่มทะเบียน
    ${file2}    Run Keyword And Return Status    Page Should Contain    สำเนาเล่มทะเบียน
    Run Keyword If    ${file2}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_02    ${CURDIR}\\pic02.jpg
    ...    AND    Input Text    Commentfile_02    สำเนาเล่มทะเบียน
    Execute Javascript    alert('ตรวจสอบสำเนาเล่มทะเบียน')
    Sleep    2s
    Alert Should Be Present    \    ACCEPT
    #รูปหน้ารถ
    ${file3}    Run Keyword And Return Status    Page Should Contain    รูปหน้ารถ
    Set Selenium Speed    0.1s
    Run Keyword If    ${file3}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_03    ${CURDIR}\\pic03.jpg
    ...    AND    Input Text    Commentfile_03    รูปหน้ารถ
    Set Selenium Speed    0.1s
    Execute Javascript    alert('ตรวจสอบรูปหน้ารถ')
    Sleep    2s
    Alert Should Be Present    \    ACCEPT
    #รูปหลังรถ
    ${file4}    Run Keyword And Return Status    Page Should Contain    รูปหน้ารถ
    Run Keyword If    ${file4}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_04    ${CURDIR}\\pic04.jpg
    ...    AND    Input Text    Commentfile_04    รูปหลังรถ
    Execute Javascript    alert('ตรวจสอบรูปหลังรถ')
    Sleep    2s
    Alert Should Be Present    \    ACCEPT
    #รูปด้านขวา
    ${file5}    Run Keyword And Return Status    Page Should Contain    รูปด้านขวา
    Run Keyword If    ${file5}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_05    ${CURDIR}\\pic05.jpg
    ...    AND    Input Text    Commentfile_05    รูปด้านขวา
    Execute Javascript    alert('ตรวจสอบรูปด้านขวา')
    Sleep    2s
    Alert Should Be Present    \    ACCEPT
    #รูปด้านซ้าย
    ${file6}    Run Keyword And Return Status    Page Should Contain    รูปด้านซ้าย
    Run Keyword If    ${file6}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_06    ${CURDIR}\\pic06.jpg
    ...    AND    Input Text    Commentfile_06    รูปด้านซ้าย
    Execute Javascript    alert('ตรวจสอบรูปด้านซ้าย')
    Sleep    2s
    Alert Should Be Present    \    ACCEPT
    #เอกสารอื่นๆ 1
    ${file_other}    Run Keyword And Return Status    Page Should Contain    เอกสารไฟล์แนบอื่นๆ
    Run Keyword If    ${file_other}    Run Keywords    Select Frame    //iframe
    ...    AND    Choose File    file_99_1    ${CURDIR}\\pic07.jpg
    ...    AND    Input Text    Commentfile_99_1    เอกสารอื่นๆ 1

FileRequest_FUll
    #สำเนาบัตรประชาชน
    Choose File    file_01    ${CURDIR}\\Revise-pic01.jpg
    Input Text    Commentfile_01    สำเนาบัตรประชาชนEdited
    #สำเนาเล่มทะเบียน
    Choose File    file_02    ${CURDIR}\\Revise-pic02.jpg
    Input Text    Commentfile_02    สำเนาเล่มทะเบียน Edite
    #รูปหน้ารถ
    Choose File    file_03    ${CURDIR}\\Revise-pic03.jpg
    Input Text    Commentfile_03    รูปหน้ารถ Edite
    #รูปหลังรถ
    Choose File    file_04    ${CURDIR}\\Revise-pic04.jpg
    Input Text    Commentfile_04    รูปหลังรถ Edite
    #รูปด้านขวา
    Choose File    file_05    ${CURDIR}\\Revise-pic05.jpg
    Input Text    Commentfile_05    รูปด้านขวา Edite
    #รูปด้านซ้าย
    Choose File    file_06    ${CURDIR}\\Revise-pic06.jpg
    Input Text    Commentfile_06    รูปด้านซ้าย Edite
    #เอกสารอื่นๆ 1
    Choose File    file_99_1    ${CURDIR}\\Revise-pic07.jpg
    Input Text    Commentfile_99_1    เอกสารอื่นๆ 1 Edite

FileRequest
    #สำเนาบัตรประชาชน
    Choose File    file_01    ${CURDIR}\\Revise-pic01.jpg
    Input Text    Commentfile_01    สำเนาบัตรประชาชน Edited
    #สำเนาเล่มทะเบียน
    Choose File    file_02    ${CURDIR}\\Revise-pic02.jpg
    Input Text    Commentfile_02    สำเนาเล่มทะเบียน Edite
