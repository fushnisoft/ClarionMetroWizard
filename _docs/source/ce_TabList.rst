! ============================
! ce_TabList Class
! ============================
!
! .. _class-ce_tablist:
!
! .. describe:: ce_TabList Class(ce_BaseWindowComponent),Implements(WindowComponent)
!
!   This class will take a Sheet control and convert it into list box representation of the TABs on the left.
!   It is designed with a fairly narrow target but as long as you stay within the guidelines it seems to work well :)
!
! Usage
! =====
!
! Just add a new instance of this class to a window, follow the requirements below and call the init method and you should be good to go.
!
! Requirements
! ============

! * A Sheet control with TAB location set to LEFT
! * The TAB width needs to be set manually rather than left at zero
! * The class will *not* convert nested Sheets into a tree structure.
! * There are probably a lot of hard coded values for position and size of elements.
!

Class Properties
================

This document will not list all the public properties, take a look at the source code for them for now.


Class Methods
=============


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

