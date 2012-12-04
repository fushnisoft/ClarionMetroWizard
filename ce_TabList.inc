! http://clarionedge.com, http://fushnisoft.com
! Licensed under the MIT license: https://github.com/fushnisoft/ClarionMetroWizard/blob/master/LICENSE.txt 
_ce_TabList_  EQUATE(1)

  PRAGMA('project(#pragma link(resources\header_grey.bmp))')

ce_tabQ_Type                    QUEUE,TYPE
name                           CSTRING(255)
cellStyle                      LONG
cellTooltip                    CSTRING(255)
                             END

  include('ce_BaseWindowComponent.inc'),ONCE
  include('ABWINDOW.INC'),ONCE
!--------------------------------------------------------------------------------
!Class ce_TabList
!
!--------------------------------------------------------------------------------
ce_TabList          Class(ce_BaseWindowComponent),Implements(WindowComponent),Type,Module('ce_TabList.Clw'),LINK('ce_TabList.Clw',1)
! Properties
tabQ                  &ce_tabQ_Type
sheetFeq              SIGNED
listFeq               SIGNED
listLineHeightAdjustment  LONG
listValuesUpperCase   BYTE
listValuesBold        BYTE
lastTabFeq            SIGNED
boxFeq                SIGNED
boxMargin             LONG
backgroundImageFeq    SIGNED
backgroundImage       CSTRING(255)
lastChoice            LONG
! Methods
Construct             PROCEDURE()
Destruct              PROCEDURE() ,VIRTUAL 
Init                  PROCEDURE(WindowManager pWM, SIGNED pSheetFeq, BYTE pSkipChecksAndOptions=FALSE) ,VIRTUAL 
SetListFrom           PROCEDURE() ,VIRTUAL 
SetupNoSheet          PROCEDURE(BYTE pSkipChecksAndOptions=FALSE) ,VIRTUAL 
TakeAccepted          PROCEDURE() ,VIRTUAL
TakeNewSelection      PROCEDURE() ,VIRTUAL
Replace               PROCEDURE(STRING pFrom, STRING pFind, STRING pReplace) ,STRING
                     END 
!_EndOfInclude_
