VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CheckBoxManutencao"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Criacao dinamica de eventos adaptada do artigo:
' http://ramblings.mcpher.com/Home/excelquirks/dynamic-forms/dynamic-event-handlers
Option Explicit


Private WithEvents ptb As MSForms.CheckBox
Attribute ptb.VB_VarHelpID = -1
Private pEventSelected As Control
Public Property Set Control(p As MSForms.CheckBox)
    Set ptb = p
End Property

Public Property Get Control() As Control
    Set Control = ptb
End Property

Private Sub ptb_Click()
    FormManutencaoDB.check_clicado (ptb.name)
End Sub
