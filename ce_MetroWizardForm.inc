! http://clarionedge.com, http://fushnisoft.com
! Licensed under the MIT license: https://github.com/fushnisoft/ClarionMetroWizard/blob/master/LICENSE.txt 

_ce_MetroWizardForm_ EQUATE(1)

  PRAGMA('project(#pragma link(header_ce_metro_24x24.ico))')
  PRAGMA('project(#pragma link(cancel_ce_metro_24x24.ico))')
  PRAGMA('project(#pragma link(navigation-right_ce_metro_24x24.ico))')
  PRAGMA('project(#pragma link(navigation-left_ce_metro_24x24.ico))')
  PRAGMA('project(#pragma link(thumb_up_ce_metro_24x24.ico))')

  include('ce_TabList.inc'),ONCE
  include('ABWINDOW.INC'),ONCE

CMW_COLOR_DARK EQUATE(1)
CMW_COLOR_LIGHT EQUATE(2)
!--------------------------------------------------------------------------------
!Class ce_MetroWizardForm
!
!--------------------------------------------------------------------------------
ce_MetroWizardForm          Class(ce_TabList),Type,Module('ce_MetroWizardForm.Clw'),LINK('ce_MetroWizardForm.Clw',1)
! Properties
lightColor                    LONG
darkColor                     LONG
fontColor                     LONG
fontSelectedColor             LONG

headerHeight                  LONG
footerHeight                  LONG

headerImageFeq                SIGNED
headerImage                   CSTRING(255)

listTitleFontSize             LONG
listBorderFeq                 SIGNED

listBorderC6Style             BYTE

headerFontSize                LONG
footerFontSize                LONG

boxHeaderFeq                  SIGNED
boxFooterFeq                  SIGNED
boxListTitleFeq               SIGNED

promptListTitleFeq            SIGNED
promptHeaderFeq               SIGNED
promptFooterFeq               SIGNED
promptTabHeader               SIGNED
promptTabDetail               SIGNED

promptTabHeaderUpper          BYTE
promptTabDetailUpper          BYTE

buttonClose                   SIGNED
buttonCloseIcon               CSTRING(255)
buttonOK                      SIGNED
buttonOKIcon                  CSTRING(255)
buttonNext                    SIGNED
buttonNextIcon                CSTRING(255)
buttonPrevious                SIGNED
buttonPreviousIcon            CSTRING(255)

themeColors LONG,DIM(25,2)
! Methods
Init                          PROCEDURE(WindowManager pWM, SIGNED pSheetFeq) ,VIRTUAL 
MoveOriginalControls          PROCEDURE(),VIRTUAL
CreateControls                PROCEDURE(),VIRTUAL
SetupWindow                   PROCEDURE(),VIRTUAL
SetupButtons                  PROCEDURE(),VIRTUAL
ApplyColors                   PROCEDURE(LONG pDarkColor, LONG pLightColor),VIRTUAL
SetTheme                      PROCEDURE(BYTE pThemeNumber),VIRTUAL
SetButtonStyle                PROCEDURE(SIGNED pFeq, STRING pIcon) ,VIRTUAL
SetHeaderIcon                 PROCEDURE(STRING pText)
SetHeaderText                 PROCEDURE(STRING pText)
SetListHeaderText             PROCEDURE(STRING pText)
SetFooterText                 PROCEDURE(STRING pText)
Construct                     PROCEDURE()
TakeAccepted                  PROCEDURE(),DERIVED
TakeNewSelection              PROCEDURE(),DERIVED
                     END
!_EndOfInclude_
