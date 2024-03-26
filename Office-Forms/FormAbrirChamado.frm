VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormAbrirChamado 
   Caption         =   "Abrir Chamado"
   ClientHeight    =   2955
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4935
   OleObjectBlob   =   "FormAbrirChamado.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormAbrirChamado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cbxArea_Change()
    If (cbxArea.value = Empty Or tbxEnderecoCorporativo.Text = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub tbxEnderecoCorporativo_Change()
    If (tbxEnderecoCorporativo.Text = Empty Or cbxArea.value = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub UserForm_Initialize()
    cbxArea.Clear
    cbxArea.AddItem "DBA"
    cbxArea.AddItem "Gestão"
    cbxArea.AddItem "Infra"
    cbxArea.AddItem "Sistemas"
   
    tbxEnderecoCorporativo.Text = ""
    cbxArea.value = ""
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Terminate()
    tbxEnderecoCorporativo.Text = ""
    cbxArea.value = ""
    btnOK.Enabled = False
End Sub

Private Sub btnCancelar_Click()
    tbxEnderecoCorporativo.Text = ""
    cbxArea.value = ""
    
    btnOK.Enabled = False
    
    Projeto1.FormAbrirChamado.Hide
End Sub

Private Sub btnOK_Click()

    If tbxEnderecoCorporativo.value = Empty Then
        MsgBox "Informe o endereço corporativo do cliente.", vbExclamation
    ElseIf Len(cbxArea.value) = 0 Then
        MsgBox "Selecione a área.", vbExclamation
    Else
        EnderecoCorporativo = tbxEnderecoCorporativo.Text
        Area = Replace(cbxArea.value, "Gestão", "Gestao")
    End If
    
    Projeto1.FormAbrirChamado.Hide
    
    tbxEnderecoCorporativo.Text = Empty
    cbxArea.value = Empty
        
    btnOK.Enabled = False
End Sub


