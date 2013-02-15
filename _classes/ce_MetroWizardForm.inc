! http://clarionedge.com, http://fushnisoft.com
! Licensed under the MIT license: https://github.com/fushnisoft/ClarionMetroWizard/blob/master/LICENSE.txt 

_ce_MetroWizardForm_ EQUATE(1)
  Omit('!!!Docs!!!')
============================
ce_MetroWizardForm Class
============================

.. _class-ce_metrowizardform:

.. describe:: ce_MetroWizardForm Class(ce_TabList)

  This class will take a Sheet control and convert it into Metro or "Modern UI" styled window. The sheet/Tab functionality is replaced with a list box on the left using the :ref:`ce_TabList <class-ce_tablist>` class.
  It is designed with a fairly narrow target but as long as you stay within the guidelines it seems to work well :)

Usage
=====

Just add a new instance of this class to a window, set a few properties, call the init method and you should be good to go. 

Requirements
============

* Same as the :ref:`ce_TabList <class-ce_tablist>` class
* Next and Previous buttons if you want wizard functionality but without them you can also apply this to a standard form with OK and Close/Cancel buttons only.
* Prompts to recieve Tab Header and Tab Details. The values for these prompts are taken from the current tabs PROP:Text and PROP:Tip.
* There are probably a lot of hard coded values for position and size of elements.

!!!Docs!!!

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
Omit('!!!Docs!!!')

Class Properties
================ 

This document will not list all the public properties, take a look at the source code for them for now.

---------------------------
themeColors
---------------------------

**Syntax**::

  themeColors LONG,DIM(25,2)

The dimension of this property are filled with `Windows 8 Color Palette <http://jasongaylord.com/blog/windows-8-color-palette>`_ values. 

.. image:: images/windows8-colors.jpg

!!!Docs!!!
themeColors LONG,DIM(25,2)

Omit('!!!Docs!!!')
---------------------------
promptTabHeader
---------------------------

**Syntax**::

  promptTabHeader SIGNED

Field equate for the control used to display the name of the selected TAB. 
The value comes from the TABs PROP:Text and is updated on EVENT:NewSelection.

---------------------------
promptTabDetail
---------------------------

**Syntax**::

  promptTabDetail SIGNED

Field equate for the control used to display the detail of the selected TAB. 
The value comes from the TABs PROP:Tip and is updated on EVENT:NewSelection.

!!!Docs!!!

promptTabHeader               SIGNED
promptTabDetail               SIGNED

Omit('!!!Docs!!!')
---------------------------
promptTabHeaderUpper
---------------------------

**Syntax**::

  promptTabHeaderUpper SIGNED(FALSE)

Convert text to upper case before display.

---------------------------
promptTabDetailUpper
---------------------------

**Syntax**::

  promptTabDetailUpper SIGNED(TRUE)

Convert text to upper case before display.

!!!Docs!!!

promptTabHeaderUpper          BYTE
promptTabDetailUpper          BYTE

Omit('!!!Docs!!!')
---------------------------
buttonClose
---------------------------

**Syntax**::

  buttonClose SIGNED

Field equate for the control used to close the form.
The button remains hidden until the last TAB in the Sheet is visible.

---------------------------
buttonOK
---------------------------

**Syntax**::

  buttonOK SIGNED

Field equate for the control used to Ok the form.
The button remains hidden until the last TAB in the Sheet is visible.

---------------------------
buttonPrevious
---------------------------

**Syntax**::

  buttonPrevious SIGNED

Field equate for the control used to navigate to the previous TAB.
The button is only visible if the current TAB is not the first TAB on the sheet.

---------------------------
buttonNext
---------------------------

**Syntax**::

  buttonNext SIGNED

Field equate for the control used to navigate to the next TAB.
The button is only visible if the current TAB is not the last TAB on the sheet.
!!!Docs!!!

buttonClose                   SIGNED
buttonOK                      SIGNED
buttonNext                    SIGNED
buttonPrevious                SIGNED

! --------------------------------------
! Non public or not documented properties
! --------------------------------------
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

buttonCloseIcon               CSTRING(255)
buttonOKIcon                  CSTRING(255)
buttonNextIcon                CSTRING(255)
buttonPreviousIcon            CSTRING(255)
headerRegionFEQ SIGNED

! Methods
Init                          PROCEDURE(WindowManager pWM, SIGNED pSheetFeq, BYTE pHideCaption=FALSE) ,DERIVED 
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
TakeEvent                     PROCEDURE(),DERIVED
                     END
!_EndOfInclude_
