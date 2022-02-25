*** Settings ***
Library           Selenium2Library
Resource          Utillities.robot

*** Keywords ***
DropdownOrange
    [Arguments]    ${Name}    ${Value}
    ${arrow}    Set Variable    //*[@aria-owns='${Name}']/span/span/span[@class='k-icon k-i-arrow-s']
    ${dropdown}    Set Variable    //ul[@id='${Name}']/li[contains(text(),'${Value}')]
    : FOR    ${indx}    IN RANGE    999999
    \    ClickElem    ${arrow}
    \    sleep    1s
    \    ${res}    WaitElement    //ul[@id='${Name}']    1s
    \    Exit For Loop If    '${res}' == 'True'
    ClickElem    ${dropdown}

DropdownGray
    [Arguments]    ${Name}    ${Value}
    ${arrow}    Set Variable    ctl00_ContentPlaceHolder1_${Name}_Arrow
    ${dropdown}    Set Variable    ctl00_ContentPlaceHolder1_${Name}_DropDown
    : FOR    ${indx}    IN RANGE    999999
    \    ClickElem    //a[@id='${arrow}']
    \    sleep    1s
    \    ${res}    WaitElement    ${dropdown}    1s
    \    Exit For Loop If    '${res}' == 'True'
    sleep    1s
    Click Element    //*[@id='${dropdown}']/div/ul/li[contains(text(),'${Value}')]

WaitElement
    [Arguments]    ${Locator}    ${Timeout}=20s
    Set Selenium Implicit Wait    20s
    Set Browser Implicit Wait    20s
    ${res}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Locator}    ${Timeout}
    [Return]    ${res}
