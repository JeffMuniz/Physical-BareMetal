VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormRoteador 
   Caption         =   "Roteador"
   ClientHeight    =   2640
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4035
   OleObjectBlob   =   "FormRoteador.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormRoteador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cbxArea_Change()
    If (cbxArea.value = Empty Or cbxTipo.value = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub cbxTipo_Change()
    If (cbxArea.value = Empty Or cbxTipo.value = Empty) Then
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

    cbxTipo.Clear
    cbxTipo.AddItem "Interno"
    cbxTipo.AddItem "Levantamento"
    cbxTipo.AddItem "Projeto"
    cbxTipo.AddItem "Relacionamento"
    cbxTipo.AddItem "Suporte"
    
    cbxTipo.value = TipoAtendimento
    
    btnOK.Enabled = True
End Sub

Private Sub UserForm_Terminate()
    cbxTipo.value = TipoAtendimento
    cbxArea.value = ""
            
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Unload()
Unload Me
End Sub

Private Sub btnCancelar_Click()
    cbxTipo.value = TipoAtendimento
    cbxArea.value = ""
    
    btnOK.Enabled = True
       
    UserForm_Unload
    
End Sub

Private Sub btnOK_Click()
    If Len(cbxTipo.value) = 0 Then
        MsgBox "Selecione o tipo do atendimento.", vbExclamation
    ElseIf Len(cbxArea.value) = 0 Then
        MsgBox "Selecione a áre.", vbExclamation
    Else
        TipoAtendimento = cbxTipo.value
        Area = Replace(cbxArea.value, "Gestão", "Gestao")
        
        UserForm_Unload
    End If
    
    cbxTipo.value = TipoAtendimento
    cbxArea.value = ""
End Sub
