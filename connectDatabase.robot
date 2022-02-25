*** Settings ***
Library           Selenium2Library
Library           sortcell.py
Library           ExcelLibrary
Library           String
Library           Selenium2Library
Resource          ../Resource/Utillities.robot
Resource          commonFunction1.robot
Library           DatabaseLibrary
Library           Collections
Library           ExcelLibrary
Library           OperatingSystem

*** Variables ***

*** Keywords ***
ConnectDB
    Comment    Connect To Database Using Custom Params    pymssql    database='DBCompare',user='',password='',host=''    #DEV
    Connect To Database Using Custom Params    pymssql    database='DBCompare',user='',password='',host=''    #UAT

Process keep results QT
    [Arguments]    ${QT}    ${Path_Case}
    ${Path}=    Create Log File    ${QT}    ${Path_Case}
    ${Summary}=    CompareST    ${QT}    ${Path}
    ### Log Summary ###
    Log List    ${Summary}
    ${SUMMARY}    Convert To String    ${Summary}
    Create File    ${Path}/SummaryResults.txt    ${SUMMARY}

Process keep results QV New
    [Arguments]    ${Path_Case}    ${QV}
    ${Path}=    Create Log File    ${QV}    ${Path_Case}
    ${Summary}=    CompareST_QV    ${QV}    ${Path}
    ### Log Summary ###
    Log List    ${Summary}
    ${SUMMARY}    Convert To String    ${Summary}
    Create File    ${Path}/SummaryResults.txt    ${SUMMARY}

Process keep results Running
    [Arguments]    ${Path_Case}    ${Running}
    ${Path}=    Create Log File    ${Running}    ${Path_Case}
    ${Summary}=    CompareST_Sale    ${Running}    ${Path}
    ### Log Summary ###
    Log List    ${Summary}
    ${SUMMARY}    Convert To String    ${Summary}
    Create File    ${Path}/SummaryResults.txt    ${SUMMARY}

Create Log File
    [Arguments]    ${No}    ${payType}
    ${dataTime}=    datatimetest
    Create Directory    O:\\IT_DEV\\0_Test Team\\Robot Test\\IOS\\Results_DB\\${payType}\\${No}_${dataTime}
    ${Path}    Set Variable    O:\\IT_DEV\\0_Test Team\\Robot Test\\IOS\\Results_DB\\${payType}\\${No}_${dataTime}
    log    ${Path}
    [Return]    ${Path}

Create Log File QV New
    [Arguments]    ${QV}    ${payType}
    ${dataTime}=    datatimetest
    Create Directory    O:\\IT_DEV\\0_Test Team\\Robot Test\\IOS\\Results_DB\\${payType}\\${QV}_${dataTime}
    ${Path}    Set Variable    O:\\IT_DEV\\0_Test Team\\Robot Test\\IOS\\Results_DB\\${payType}\\${QV}_${dataTime}
    log    ${Path}
    [Return]    ${Path}

Create Log file QV Rework
    [Arguments]    ${QV}    ${payType}
    ${dataTime}=    datatimetest
    Create Directory    O:\\IT_DEV\\0_Test Team\\Robot Test\\IOS\\Results_DB\\${payType}\\${QV}_${dataTime}
    ${Path}    Set Variable    O:\\IT_DEV\\0_Test Team\\Robot Test\\IOS\\Results_DB\\${payType}\\${QV}_${dataTime}
    log    ${Path}
    [Return]    ${Path}

Convert list to srting
    [Arguments]    @{QueryResults}
    ${data}    Catenate    @{QueryResults}${\n}
    [Return]    ${data}

Create File txt log
    [Arguments]    ${Log}    ${Path}    ${st}
    ${replace} =    Replace String    ${Log}    u'    '
    Log To Console    ${replace}
    Create File    ${Path}/${st}.txt    ${replace}

CompareST
    [Arguments]    ${QT}    ${Path}
    sp_ALL_LoadQuotationToTemp    ${QT}
    ${Sum1}=    sp_Q_01_QuoteHeader    ${QT}    ${Path}
    ${Sum2}=    sp_Q_02_QuoteRunningMapping    ${QT}    ${Path}
    ${Sum3}=    sp_Q_03_QuoteStandardDetail    ${QT}    ${Path}
    ${Sum4}=    sp_Q_04_QuoteSpecialDetail    ${QT}    ${Path}
    ${Sum5}=    sp_Q_05_QuoteStandardCarInfo    ${QT}    ${Path}
    ${Sum6}=    sp_Q_06_SpecialCarInfo    ${QT}    ${Path}
    ${Sum7}=    sp_Q_07_QuoteInsurerInfo    ${QT}    ${Path}
    ${Sum8}=    sp_Q_08_QuoteCoverageInfo    ${QT}    ${Path}
    ${Sum9}=    sp_Q_09_TTHQuoteAttachment    ${QT}    ${Path}
    ${Sum10}=    sp_Q_10_TTDQuoteAttachment    ${QT}    ${Path}
    ${Sum11}=    sp_Q_11_TTHQuotePrinting    ${QT}    ${Path}
    ${Sum12}=    sp_Q_12_TTDQuotePrinting    ${QT}    ${Path}
    [Return]    ${Sum1}    ${Sum2}    ${Sum3}    ${Sum4}    ${Sum5}    ${Sum6}
    ...    ${Sum7}    ${Sum8}    ${Sum9}    ${Sum10}    ${Sum11}    ${Sum12}

sp_ALL_LoadQuotationToTemp
    [Arguments]    ${QT}
    ${ParamList} =    Create List    ${QT}
    Call Stored Procedure    DBCompare.dbo.sp_ALL_LoadQuotationToTemp    ${ParamList}

sp_Q_01_QuoteHeader
    [Arguments]    ${QT}    ${Path}
    [Tags]
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_01_QuoteHeader
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_02_QuoteRunningMapping
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_02_QuoteRunningMapping
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_03_QuoteStandardDetail
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_03_QuoteStandardDetail
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_04_QuoteSpecialDetail
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_04_QuoteSpecialDetail
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_05_QuoteStandardCarInfo
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_05_QuoteStandardCarInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_06_SpecialCarInfo
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_06_SpecialCarInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_07_QuoteInsurerInfo
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_07_QuoteInsurerInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_08_QuoteCoverageInfo
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_08_QuoteCoverageInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_09_TTHQuoteAttachment
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_09_TTHQuoteAttachment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_10_TTDQuoteAttachment
    [Arguments]    ${QT}    ${Path}
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_10_TTDQuoteAttachment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_11_TTHQuotePrinting
    [Arguments]    ${QT}    ${Path}
    [Tags]
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_11_TTHQuotePrinting
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_Q_12_TTDQuotePrinting
    [Arguments]    ${QT}    ${Path}
    [Tags]
    ${ParamList} =    Create List    0    ${QT}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_Q_12_TTDQuotePrinting
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

CompareST_QV
    [Arguments]    ${QV}    ${Path}
    sp_ALL_LoadVerifyToTemp    ${QV}
    ${SumQV1}=    sp_V_01_TTHVerify    ${QV}    ${Path}
    ${SumQV2}=    sp_V_02_TTHVerifyQuote    ${QV}    ${Path}
    ${SumQV3}=    sp_V_03_TTVerifyPaymentDetail    ${QV}    ${Path}
    ${SumQV4}=    sp_V_04_TTVerifyStandardCarInfo    ${QV}    ${Path}
    ${SumQV5}=    sp_V_05_TTVerifySpecialCarInfo    ${QV}    ${Path}
    ${SumQV6}=    sp_V_06_TTVerifyeInsurerInfo    ${QV}    ${Path}
    ${SumQV7}=    sp_V_07_TTVerifyCoverageInfo    ${QV}    ${Path}
    ${SumQV8}=    sp_V_08_TTVerifyDriverSpecify    ${QV}    ${Path}
    ${SumQV9}=    sp_V_09_TTVerifyPreCustomer    ${QV}    ${Path}
    ${SumQV10}=    sp_V_10_TTVerifyPreCustomerContact    ${QV}    ${Path}
    ${SumQV11}=    sp_V_11_TTVerifyBenefit    ${QV}    ${Path}
    ${SumQV13}=    sp_V_13_TTHVerifyPaytypeAttachment    ${QV}    ${Path}
    ${SumQV14}=    sp_V_14_TTDVerifyPaytypeAttachment    ${QV}    ${Path}
    ${SumQV15}=    sp_V_15_TTHVerifyAttachment    ${QV}    ${Path}
    ${SumQV16}=    sp_V_16_TTDVerifyAttachment    ${QV}    ${Path}
    [Return]    ${SumQV1}    ${SumQV2}    ${SumQV3}    ${SumQV4}    ${SumQV5}    ${SumQV6}
    ...    ${SumQV7}    ${SumQV8}    ${SumQV9}    ${SumQV10}    ${SumQV11}    ${SumQV13}
    ...    ${SumQV14}    ${SumQV15}    ${SumQV16}

sp_ALL_LoadVerifyToTemp
    [Arguments]    ${QV}
    ${ParamList} =    Create List    ${QV}
    Call Stored Procedure    DBCompare.dbo.sp_ALL_LoadVerifyToTemp    ${ParamList}

sp_V_01_TTHVerify
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_01_TTHVerify
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_02_TTHVerifyQuote
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_02_TTHVerifyQuote
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    Log To Console    ${Summary}
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_03_TTVerifyPaymentDetail
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_03_TTVerifyPaymentDetail
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_04_TTVerifyStandardCarInfo
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_04_TTVerifyStandardCarInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_05_TTVerifySpecialCarInfo
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_05_TTVerifySpecialCarInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_06_TTVerifyeInsurerInfo
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_06_TTVerifyeInsurerInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_07_TTVerifyCoverageInfo
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_07_TTVerifyCoverageInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_08_TTVerifyDriverSpecify
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_08_TTVerifyDriverSpecify
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_09_TTVerifyPreCustomer
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_09_TTVerifyPreCustomer
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_10_TTVerifyPreCustomerContact
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_10_TTVerifyPreCustomerContact
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_11_TTVerifyBenefit
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_11_TTVerifyBenefit
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_13_TTHVerifyPaytypeAttachment
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_13_TTHVerifyPaytypeAttachment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_14_TTDVerifyPaytypeAttachment
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_14_TTDVerifyPaytypeAttachment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_15_TTHVerifyAttachment
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_15_TTHVerifyAttachment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_V_16_TTDVerifyAttachment
    [Arguments]    ${QV}    ${Path}
    ${ParamList} =    Create List    ${QV}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_V_16_TTDVerifyAttachment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

CompareST_Sale
    [Arguments]    ${Running}    ${Path}
    sp_ALL_LoadSaleToTemp    ${Running}
    ${SumR1}=    sp_S_01_TTInsTransaction    ${Running}    ${Path}
    ${SumR2}=    sp_S_02_TTInsTransactionDetail    ${Running}    ${Path}
    Comment    ${SumR3}=    Set Variable    bk
    ${SumR3}=    sp_S_03_TTInsTransactionDetailAUTO    ${Running}    ${Path}
    ${SumR4}=    sp_S_04_TTAutoCoverage    ${Running}    ${Path}
    ${SumR5}=    sp_S_05_TTAutoDriverSpecifyInfo    ${Running}    ${Path}
    ${SumR6}=    sp_S_06_TTInsTransactionLeadRefer    ${Running}    ${Path}
    ${SumR7}=    sp_S_07_TTInsTransactionReference    ${Running}    ${Path}
    ${SumR8}=    sp_S_08_TTTransactionLog    ${Running}    ${Path}
    ${SumR9}=    sp_S_09_CUS_TTCustomerHistory    ${Running}    ${Path}
    ${SumR10}=    sp_S_10_CUS_TTCustomerHistoryContact    ${Running}    ${Path}
    ${SumR11}=    sp_S_11_PAY_TTHPayment    ${Running}    ${Path}
    ${SumR12}=    sp_S_12_PAY_TTDPaymentCash    ${Running}    ${Path}
    ${SumR13}=    sp_S_13_PAY_TTDPaymentCreditcard    ${Running}    ${Path}
    ${SumR14}=    sp_S_13_PAY_TTDPaymentCreditCardDetail    ${Running}    ${Path}
    ${SumR15}=    sp_S_14_PAY_TTDPaymentCV    ${Running}    ${Path}
    ${SumR16}=    sp_S_15_PAY_TTDPaymentInstallment    ${Running}    ${Path}
    ${SumR17}=    sp_S_16_PAY_TTDPaymentPromotion    ${Running}    ${Path}
    ${SumR18}=    sp_S_17_PAY_TTDPaymentSalary    ${Running}    ${Path}
    ${SumR19}=    sp_S_17_PAY_TTDPaymentSalaryDetail    ${Running}    ${Path}
    [Return]    ${SumR1}    ${SumR2}    ${SumR3}    ${SumR4}    ${SumR5}    ${SumR6}
    ...    ${SumR7}    ${SumR8}    ${SumR9}    ${SumR10}    ${SumR11}    ${SumR12}
    ...    ${SumR13}    ${SumR14}    ${SumR15}    ${SumR16}    ${SumR17}    ${SumR18}
    ...    ${SumR19}

sp_ALL_LoadSaleToTemp
    [Arguments]    ${Running}
    ${ParamList} =    Create List    ${Running}
    Call Stored Procedure    DBCompare.dbo.sp_ALL_LoadSaleToTemp    ${ParamList}

sp_S_01_TTInsTransaction
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_01_TTInsTransaction
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_02_TTInsTransactionDetail
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_02_TTInsTransactionDetail
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_03_TTInsTransactionDetailAUTO
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_03_TTInsTransactionDetailAUTO
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_04_TTAutoCoverage
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_04_TTAutoCoverage
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_05_TTAutoDriverSpecifyInfo
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_05_TTAutoDriverSpecifyInfo
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_06_TTInsTransactionLeadRefer
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_06_TTInsTransactionLeadRefer
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_07_TTInsTransactionReference
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_07_TTInsTransactionReference
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_08_TTTransactionLog
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_08_TTTransactionLog
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_09_CUS_TTCustomerHistory
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_09_CUS_TTCustomerHistory
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_10_CUS_TTCustomerHistoryContact
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_10_CUS_TTCustomerHistoryContact
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_11_PAY_TTHPayment
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_11_PAY_TTHPayment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_12_PAY_TTDPaymentCash
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_12_PAY_TTDPaymentCash
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_13_PAY_TTDPaymentCreditcard
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_13_PAY_TTDPaymentCreditcard
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_13_PAY_TTDPaymentCreditCardDetail
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_13_PAY_TTDPaymentCreditCardDetail
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_14_PAY_TTDPaymentCV
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_14_PAY_TTDPaymentCV
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_15_PAY_TTDPaymentInstallment
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_15_PAY_TTDPaymentInstallment
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_16_PAY_TTDPaymentPromotion
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_16_PAY_TTDPaymentPromotion
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_17_PAY_TTDPaymentSalary
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_17_PAY_TTDPaymentSalary
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}

sp_S_17_PAY_TTDPaymentSalaryDetail
    [Arguments]    ${Running}    ${Path}
    ${ParamList} =    Create List    ${Running}
    ${SPName} =    Set Variable    DBCompare.dbo.sp_S_17_PAY_TTDPaymentSalaryDetail
    @{QueryResults} =    Call Stored Procedure    ${SPName}    ${ParamList}
    Log Many    @{QueryResults}
    ${Summary}=    Set Variable If    @{QueryResults}==[]    ${SPName}': PASS'    ${SPName}': FAIL'
    ${LIST}=    Run Keyword If    @{QueryResults}!=[]    Convert list to srting    @{QueryResults}
    Run Keyword If    @{QueryResults}!=[]    Create File txt log    ${LIST}    ${Path}    ${SPName}
    [Return]    ${Summary}
