VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormCobranca 
   Caption         =   "Cobran�a"
   ClientHeight    =   3855
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4965
   OleObjectBlob   =   "FormCobranca.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormCobranca"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cbxArea_Change()
    If (tbxEnderecoCorporativo.Text = Empty Or cbxArea.value = Empty Or tbxEnderecoConsultor.Text = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub tbxEnderecoCorporativo_Change()
    If (tbxEnderecoCorporativo.Text = Empty Or cbxArea.value = Empty Or tbxEnderecoConsultor.Text = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub tbxEnderecoConsultor_Change()
    If (tbxEnderecoCorporativo.Text = Empty Or cbxArea.value = Empty Or tbxEnderecoConsultor.Text = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub UserForm_Initialize()
    cbxArea.Clear
    cbxArea.AddItem "DBA"
    cbxArea.AddItem "Gest�o"
    cbxArea.AddItem "Infra"
    cbxArea.AddItem "Sistemas"
    
    tbxEnderecoCorporativo.Text = ""
    tbxEnderecoConsultor.Text = ""
    cbxArea.value = ""
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Terminate()
    tbxEnderecoCorporativo.Text = ""
    tbxEnderecoConsultor.Text = ""
    cbxArea.value = ""
    btnOK.Enabled = False
End Sub

Private Sub btnCancelar_Click()
    tbxEnderecoCorporativo.Text = ""
    tbxEnderecoConsultor.Text = ""
    cbxArea.value = ""
    btnOK.Enabled = False
    
    Projeto1.FormCobranca.Hide
End Sub

Private Sub btnOK_Click()

    If tbxEnderecoConsultor.value = Empty Then
        MsgBox "Informe o endere�o do consultor a ser cobrado.", vbExclamation
    ElseIf tbxEnderecoCorporativo.value = Empty Then
        MsgBox "Informe o endere�o corporativo do cliente.", vbExclamation
    ElseIf Len(cbxArea.value) = 0 Then
        MsgBox "Selecione a �rea.", vbExclamation
    Else
        EnderecoConsultor = tbxEnderecoConsultor.Text
        EnderecoCorporativo = tbxEnderecoCorporativo.Text
        Area = Replace(cbxArea.value, "Gest�o", "Gestao")
    End If
    
    Projeto1.FormCobranca.Hide
    
    tbxEnderecoConsultor.Text = Empty
    tbxEnderecoCorporativo.Text = Empty
    cbxArea.value = Empty
        
    btnOK.Enabled = False
End Sub

