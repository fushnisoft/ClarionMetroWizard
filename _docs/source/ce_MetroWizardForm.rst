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


Class Properties
================ 

This document will not list all the public properties, take a look at the source code for them for now.

---------------------------
themeColors
---------------------------

**Syntax**::

  themeColors LONG,DIM(25,2)

The dimension of this property are filled with `Windows 8 Color Palette <http://jasongaylord.com/blog/windows-8-color-palette>`_. 


Class Methods
=============

  
.. _method-ce_metrowizardform-init:

------------------------------
ce_MetroWizardForm.Init
------------------------------

Before calling this method you **must** set the button and prompt properties:

* ce_MetroWizardForm.buttonNext (optional)
* ce_MetroWizardForm.buttonPrevious (optional)
* ce_MetroWizardForm.buttonOK
* ce_MetroWizardForm.buttonClose 

* ce_MetroWizardForm.promptTabDetail 
* ce_MetroWizardForm.promptTabHeader 

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

.. describe:: Example

.. code-block:: guess
  :linenos:

  ThisWindow.Init PROCEDURE
    CODE
    ! ...
    ! A bunch of other Init stuff happens here, then...
    ! ...
    SELF.Open(Window)
    ?ButtonNext{PROP:Hide} = TRUE
    ?ButtonPrevious{PROP:Hide} = TRUE
  
    MetroForm.buttonNext = ?ButtonNext
    MetroForm.buttonPrevious = ?ButtonPrevious
    MetroForm.buttonOK = ?ButtonOK
    MetroForm.buttonClose = ?ButtonClose
  
    MetroForm.promptTabDetail = ?PromptTabDetail
    MetroForm.promptTabHeader = ?PromptTabHeader
  
    MetroForm.Init(SELF, ?CurrentTab)
    MetroForm.SetHeaderText('Clarion Metro Wizard Demo v1.3')

    MetroForm.SetListHeaderText('Demo Features')

