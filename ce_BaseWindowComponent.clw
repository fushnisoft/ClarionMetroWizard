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
      MAP
      END 
      Include('ce_BaseWindowComponent.inc'),ONCE
ce_BaseWindowComponent.WindowComponent.Kill PROCEDURE
  CODE
ce_BaseWindowComponent.WindowComponent.Reset PROCEDURE  (BYTE force)
  CODE
ce_BaseWindowComponent.WindowComponent.ResetRequired PROCEDURE  () 
  CODE
  RETURN FALSE
ce_BaseWindowComponent.WindowComponent.TakeEvent PROCEDURE  ()
  CODE
  RETURN Level:Benign
ce_BaseWindowComponent.WindowComponent.SetAlerts PROCEDURE 
  CODE
ce_BaseWindowComponent.WindowComponent.Update PROCEDURE 
  CODE
ce_BaseWindowComponent.WindowComponent.UpdateWindow PROCEDURE
  CODE
