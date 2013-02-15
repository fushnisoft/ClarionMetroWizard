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

.. image:: images/windows8-colors.jpg

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

Class Methods
=============

  
.. _method-ce_metrowizardform-init:

------------------------------
Init
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

| *pHideCaption=FALSE*
| TYPE: *BYTE*

  Set this to TRUE and the init method will call SetWindowLong to hide the form caption.

.. Note:: By doing this you will lose min/max functionality.

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
    
    0{PROP:Text} = 'Clarion Metro Wizard Demo v1.3'
    MetroForm.Init(SELF, ?CurrentTab, TRUE)
    MetroForm.SetHeaderText(0{PROP:Text})

    MetroForm.SetListHeaderText('Demo Features')

  
.. _method-ce_metrowizardform-settheme:

------------------------------
SetTheme
------------------------------

Set the theme to be used for the form highlights.

.. image:: images/windows8-colors.jpg

**Syntax**::

  SetTheme (BYTE pThemeNumber)

.. describe:: Parameters:

| *pThemeNumber*
| Type: *BYTE* 

  Index for the theme to be used. Valid values in 0-25 range.

.. Note:: pThemeNumber=0 is the hardecoded default value not shown in the image above. Colors copied from the original Silverlight Metro Style Wizard project.

.. describe:: Example

.. code-block:: guess
  :linenos:

  MetroForm.SetTheme(1)

  
.. _method-ce_metrowizardform-applycolors:

------------------------------
ApplyColors
------------------------------

In addition to the built in :ref:`SetTheme <method-ce_metrowizardform-settheme>` method you can call this method to manually specify the highlights.

**Syntax**::

  ApplyColors (LONG pDarkColor, LONG pLightColor)

.. describe:: Parameters:

| *pDarkColor*
| Type: *LONG* 

  Clarion color value for the dark highlight.

| *pLightColor*
| Type: *LONG* 

  Clarion color value for the light highlight.

.. describe:: Example

.. code-block:: guess
  :linenos:

  MetroForm.ApplyColors(COLOR:Black, COLOR:Silver)

  
.. _method-ce_metrowizardform-setheadertext:

--------------------------------
SetHeaderText
--------------------------------

Helper method to set the header prompt text

**Syntax**::

  SetHeaderText (STRING pText)

.. describe:: Parameters:

| *pText*
| Type: *STRING* 

  Text for the prompt.

.. describe:: Example

.. code-block:: guess
  :linenos:

  MetroForm.SetHeaderText(0{PROP:Text})

  
.. _method-ce_metrowizardform-setlistheadertext:

--------------------------------
SetListHeaderText
--------------------------------

Helper method to set the list prompt text

**Syntax**::

  SetListHeaderText (STRING pText)

.. describe:: Parameters:

| *pText*
| Type: *STRING* 

  Text for the prompt.

.. describe:: Example

.. code-block:: guess
  :linenos:

  MetroForm.SetListHeaderText('Demo Features')

  
.. _method-ce_metrowizardform-setfootertext:

--------------------------------
SetFooterText
--------------------------------

Helper method to set the footer prompt text

**Syntax**::

  SetFooterText (STRING pText)

.. describe:: Parameters:

| *pText*
| Type: *STRING* 

  Text for the prompt.

.. describe:: Example

.. code-block:: guess
  :linenos:

  MetroForm.SetFooterText('Footer Demo: ' & Format(Clock(), @t8) & ', ' & Format(Today(), @d18))

