VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormDependencia 
   Caption         =   "Dependência"
   ClientHeight    =   4755
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   5295
   OleObjectBlob   =   "FormDependencia.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormDependencia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub btnCancelar_Click()
    cbxRTticket.value = "RT Técnico"
    txtTicketDependencia.Text = Empty
    txtTicketDependencia.ForeColor = &H0&
    btnOK.Enabled = False
    
    Projeto1.FormDependencia.Hide
End Sub

Private Sub btnOK_Click()
    strTest = txtTicketDependencia.Text
    With CreateObject("vbscript.regexp")
        .Pattern = "^[0-9\,\s]+$"
        If Trim(strTest) = "" Then
            MsgBox "É obrigatório informar o número do ticket.", vbExclamation
            Exit Sub
        ElseIf Not .test(strTest) Then
            txtTicketDependencia.Text = Empty
            MsgBox "Número do ticket incorreto.", vbExclamation
            Exit Sub
        End If
    End With
        
    TicketDependencia = txtTicketDependencia.Text
    RTDependencia = cbxRTticket.value
    txtTicketDependencia.Text = Empty
    txtTicketDependencia.ForeColor = &H0&
    btnOK.Enabled = False
    
    Projeto1.FormDependencia.Hide
End Sub

Private Sub txtTicketDependencia_Change()
    If (txtTicketDependencia.Text = Empty Or cbxRTticket.value = Empty) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub UserForm_Activate()
    cbxRTticket.Clear
    cbxRTticket.AddItem "RT Técnico"
    cbxRTticket.AddItem "RT ADM"
    
    cbxRTticket.value = "RT Técnico"
        
    txtTicketDependencia.Text = Empty
    txtTicketDependencia.ForeColor = &H0&
    btnOK.Enabled = False
End Sub
