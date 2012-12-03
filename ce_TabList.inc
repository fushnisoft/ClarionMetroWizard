! http://ClarionEdge.com
_ce_TabList_ EQUATE(1)
  !Include('tma_CStringClass.inc'),ONCE

  PRAGMA('project(#pragma link(resources\header_grey.bmp))')

TABLIST_HEADER_IMAGE         EQUATE('~resources\header_grey.bmp')
TABLIST_SEPERATION           EQUATE(4)

tabQ_Type                    QUEUE,TYPE
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
tabQ                         &tabQ_Type
sheetFeq                     SIGNED
listFeq                      SIGNED
lastTabFeq                   SIGNED
boxFeq                       SIGNED
backgroundImageFeq           SIGNED
lastChoice                   LONG
! Methods
Init                  PROCEDURE (WindowManager pWM, SIGNED pSheetFeq, <SIGNED pBoxFeq>, <SIGNED pImageFeq>, BYTE pSkipChecksAndOptions=FALSE) ,VIRTUAL 
SetListFrom           PROCEDURE () ,VIRTUAL 
SetupNoSheet          PROCEDURE (BYTE pSkipChecksAndOptions=FALSE) ,VIRTUAL 
TakeAccepted          PROCEDURE () ,VIRTUAL
TakeNewSelection      PROCEDURE () ,VIRTUAL
Destruct              PROCEDURE () ,VIRTUAL 
Replace               PROCEDURE (STRING pFrom, STRING pFind, STRING pReplace) ,STRING
                     END ! Class Definition
!_EndOfInclude_
