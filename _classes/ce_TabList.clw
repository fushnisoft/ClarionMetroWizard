! http://clarionedge.com, http://fushnisoft.com
! Licensed under the MIT license: https://github.com/fushnisoft/ClarionMetroWizard/blob/master/LICENSE.txt 

      Member()
         omit('***$***',_VER_C55)
_ABCDllMode_  EQUATE(0)
_ABCLinkMode_ EQUATE(1)
         ***$***
      Include('Equates.CLW'),ONCE
      Include('Keycodes.CLW'),ONCE
      Include('Errors.CLW'),ONCE
Omit('!!!Docs!!!')

Class Methods
=============

'!!!Docs!!!
      Map
      End ! map
  Include('ce_TabList.inc'),ONCE
ce_TabList.Construct  PROCEDURE()
  CODE
  SELF.boxMargin = 4
  SELF.backgroundImage = '~header_grey.bmp'
  SELF.listLineHeightAdjustment = 6
  SELF.listValuesUpperCase = TRUE
  SELF.listValuesBold = FALSE
  
ce_TabList.Destruct   PROCEDURE                           
  CODE
  IF NOT SELF.tabQ &= NULL
    DISPOSE(SELF.tabQ)
  END
  
ce_TabList.Init     PROCEDURE  (WindowManager pWM, SIGNED pSheetFeq, BYTE pSkipChecksAndOptions=FALSE, BYTE pHideCaption=FALSE)
savePixels                   BYTE
Omit('!!!Docs!!!')

.. _method-ce_tablist.init:

---------------
ce_TabList.Init
---------------

Before using any other methods you **must** call this Init method. 

**Syntax**::

  Init (WindowManager pWM, SIGNED pSheetFeq)

.. describe:: Parameters:

| *pWM*
| Type: *WindowManager* 

  The window manager to call AddItem on

| *pSheetFeq*
| Type: *SIGNED*

  FEQ value of the Sheet control to be adjusted.

!!!Docs!!!

  CODE
  
  savePixels     = 0{PROP:Pixels}
  0{PROP:Pixels} = TRUE

  SELF.sheetFeq = pSheetFeq
  IF SELF.sheetFeq{PROP:Left} = FALSE OR SELF.sheetFeq{PROP:LeftOffSet} = 0
    Message('ce_TabList.Init||' & |
            'Developer note: You need to design the window with the TABs on the left.|' & |
            '                AND set the width of the tabs manually!')
  END

  pWM.AddItem(SELF.WindowComponent)

  SELF.boxFeq = Create(0, CREATE:box)
  SELF.backgroundImageFeq = Create(0, CREATE:image, 0)
  SELF.backgroundImageFeq{PROP:Text} = SELF.backgroundImage
  SELF.listFeq = Create(0, CREATE:list)

  SELF.listFeq{PROP:Xpos}   = SELF.sheetFeq{PROP:Xpos}
  SELF.listFeq{PROP:Ypos}   = SELF.sheetFeq{PROP:Ypos}
  SELF.listFeq{PROP:Width}  = SELF.sheetFeq{PROP:LeftOffSet} - (SELF.boxMargin/2)
  SELF.listFeq{PROP:Height} = SELF.sheetFeq{PROP:Height} 

  SELF.sheetFeq{PROP:Xpos}   = SELF.sheetFeq{PROP:Xpos} + (SELF.boxMargin/2)
  SELF.sheetFeq{PROP:Width}  = SELF.sheetFeq{PROP:Width} - SELF.boxMargin
  SELF.sheetFeq{PROP:Wizard} = TRUE
  SELF.sheetFeq{PROP:Trn}    = TRUE

  ! Setup list style properties
  SELF.listFeq{PROP:Flat}          = TRUE
  SELF.listFeq{PROP:Hide}          = FALSE
  SELF.listFeq{PROP:Tip}           = '.' ! <-- required to make cell tips work!!
  SELF.listFeq{PROP:LineHeight}    = SELF.listFeq{PROP:LineHeight} + SELF.listLineHeightAdjustment
  SELF.listFeq{PROPLIST:Underline} = TRUE
  SELF.listFeq{PROPLIST:Grid}      = COLOR:SCROLLBAR
  SELF.listFeq{PROPLIST:CellStyle, 1} = TRUE
  SELF.listFeq{PROPLIST:Tip, 1} = TRUE
  SELF.listFeq{PROPLIST:DefaultTip, 1} = ''
  SELF.listFeq{PROPLIST:TextSelected, 1} = COLOR:Black
  SELF.listFeq{PROPLIST:BackSelected, 1} = 03F9FFEh
  SELF.listFeq{PROPLIST:LeftOffset, 1} = 2
  IF SELF.listValuesBold = TRUE
    SELF.listFeq{PROPSTYLE:FontStyle, 1} = FONT:bold
    SELF.listFeq{PROPSTYLE:FontStyle, 2} = FONT:bold+FONT:italic
  ELSE
    SELF.listFeq{PROPSTYLE:FontStyle, 1} = FONT:regular
    SELF.listFeq{PROPSTYLE:FontStyle, 2} = FONT:regular+FONT:italic
  END
  
    
  SELF.listFeq{PROPSTYLE:TextSelected, 2} = COLOR:Black
  SELF.listFeq{PROPSTYLE:BackSelected, 2} = 03F9FFEh

  SELF.SetupNoSheet(pSkipChecksAndOptions)

  0{PROP:Alrt,255} = CtrlTab
  0{PROP:Alrt,255} = CtrlShiftTab
  0{PROP:Pixels} = savePixels

  SELF.SetListFrom()
  
ce_TabList.SetListFrom    PROCEDURE()
i                           LONG
tabFeq                      SIGNED
  CODE
  
  IF SELF.tabQ &= NULL
    SELF.tabQ &= New(ce_tabQ_Type)
    Assert(~SELF.tabQ &= NULL,'Instantiating SELF.tabQ in ce_TabList.SetListFrom()')
  ELSE
    Free(SELF.tabQ)
  END

  LOOP
    i += 1
    tabFeq = SELF.sheetFeq{PROP:Child, i}
    IF tabFeq = 0
      BREAK
    END
    IF tabFeq{PROP:Hide} = TRUE
      CYCLE
    END
    
    SELF.tabQ.name = SELF.Replace(tabFeq{PROP:Text}, '&', '')
    IF SELF.listValuesUpperCase = TRUE
      SELF.tabQ.name = Upper(SELF.tabQ.name)
    END
    
    SELF.tabQ.cellStyle = 1
    SELF.tabQ.cellTooltip = tabFeq{PROP:Tip}
    Add(SELF.tabQ)

    SELF.lastTabFeq = tabFeq
  END
  SELF.listFeq{PROP:From} = SELF.tabQ
  
ce_TabList.WindowComponent.TakeEvent PROCEDURE() !,BYTE 
rv BYTE
  CODE
  rv = PARENT.WindowComponent.TakeEvent()

  CASE Event()
  OF EVENT:PreAlertKey
    
    ! Move focus to the list control
    Select(SELF.listFeq)
    IF KeyCode() = CtrlTab
      IF SELF.sheetFeq{PROP:ChoiceFEQ} = SELF.lastTabFeq
        ! This is to "wrap" the selection around the list
        Select(SELF.listFeq, 1)
        Post(EVENT:NewSelection, SELF.listFeq)
      ELSE
        PressKey(DownKey)
      END
      
    ELSIF KeyCode() = CtrlShiftTab
      IF SELF.sheetFeq{PROP:ChoiceFEQ} = SELF.sheetFeq{PROP:Child, 1}
        ! This is to "wrap" the selection around the list
        Select(SELF.listFeq, Records(SELF.tabQ))
        Post(EVENT:NewSelection, SELF.listFeq)
      ELSE
        PressKey(UpKey)
      END
    END
    
  OF EVENT:NewSelection
    IF Field() = SELF.listFeq
      ! Change the style of the selected cell
      ! Reset last choice
      Get(SELF.tabQ, SELF.lastChoice)
      SELF.tabQ.cellStyle = 1
      Put(SELF.tabQ)
      ! Set new choice
      Get(SELF.tabQ, Choice(SELF.listFeq))
      SELF.tabQ.cellStyle = 2
      Put(SELF.tabQ)
      SELF.lastChoice = Choice(SELF.listFeq)

      Select(SELF.sheetFeq, Choose(Choice(SELF.listFeq)=0, 1, Choice(SELF.listFeq)))
      Post(EVENT:NewSelection, SELF.sheetFeq)
    END
    SELF.TakeNewSelection()
    
  OF EVENT:OpenWindow
    Select(SELF.listFeq, 1)
    Post(EVENT:NewSelection, SELF.listFeq)
    
  OF EVENT:Accepted
    SELF.TakeAccepted()
    
  END

  SELF.TakeEvent()
  
  RETURN rv
  
ce_TabList.SetupNoSheet   PROCEDURE(BYTE pSkipChecksAndOptions=FALSE) 
thisFeq                     SIGNED
tempFeq                     SIGNED
originalDisplayState        BYTE
  CODE
  
  SELF.sheetFeq{PROP:NoSheet} = TRUE

  SetPosition(SELF.boxFeq, |
              SELF.sheetFeq{PROP:Xpos}+SELF.sheetFeq{PROP:LeftOffSet} + SELF.boxMargin, |
              SELF.sheetFeq{PROP:Ypos}, |
              SELF.sheetFeq{PROP:Width}-SELF.sheetFeq{PROP:LeftOffSet} - SELF.boxMargin, |
              SELF.sheetFeq{PROP:Height})
  
  SELF.boxFeq{PROP:Color} = COLOR:WINDOWFRAME
  SELF.boxFeq{PROP:Fill}  = COLOR:WINDOW
  SELF.boxFeq{PROP:Hide}  = FALSE

  SetPosition(SELF.backgroundImageFeq, |
              SELF.boxFeq{PROP:Xpos}+2, |
              SELF.boxFeq{PROP:Ypos}+1, |
              SELF.boxFeq{PROP:Width}-4 , |
              SELF.backgroundImageFeq{PROP:Height})
  
  SELF.backgroundImageFeq{PROP:Hide} = FALSE

  ! Set all prompts checkboxes and groups and radio controls to transparent so they look pretty on top of our background image
  LOOP
    thisFeq = 0{PROP:NextField, thisFeq}
    IF thisFeq = 0
      BREAK
    END
    IF thisFeq < 0
      CYCLE
    END
    IF InList(thisFeq{PROP:Type}, |
      CREATE:prompt, |
      CREATE:option, |
      CREATE:check, |
      CREATE:radio, |
      CREATE:sstring, |
      CREATE:string) > 0 AND |
      (thisFeq{PROP:Background} = -1 OR thisFeq{PROP:Background} = 0)

      IF pSkipChecksAndOptions=TRUE AND |
        InList(thisFeq{PROP:Type}, |
          CREATE:option, |
          CREATE:check, |
          CREATE:radio) > 0

        ! Skip these ones though. PROP:Trn is ugly with SkinFramework applied!
        CYCLE
      END
      
      thisFeq{PROP:Trn} = TRUE
    END
  END
  
ce_TabList.Replace                PROCEDURE(STRING pFrom, STRING pFind, STRING pReplace) !,STRING
! FindString , ReplaceWith
locate                       LONG,AUTO
lastLocate                   LONG
  CODE
  ! Note: This is hacked out of a much larger dynamic string class
  !       In this implementation it is _assumed_ that the returned string will always be smaller than the pFrom string. Dirty, nasty hacky coding.
  !       Maybe later I will include the full dynamic string class. For now... this is enough for a demo (I use the full classes in production!)

  LOOP
    locate = InString(Upper(pFind), Upper(pFrom), 1, lastLocate+1)
    IF ~locate
      BREAK
    END

    ! So we dont end up having recursive replacement.
    lastLocate = locate + Len(pReplace)-1

    pFrom = Sub(pFrom, 1, locate-1)                  & |
             pReplace                                      & |
             Sub(pFrom , locate+Len(pFind), Len(pFrom))
  END

  RETURN pFrom
  
ce_TabList.TakeAccepted   PROCEDURE() !,VIRTUAL
  CODE
ce_TabList.TakeNewSelection   PROCEDURE() !,VIRTUAL
  CODE
ce_TabList.TakeEvent PROCEDURE() !,VIRTUAL
  CODE