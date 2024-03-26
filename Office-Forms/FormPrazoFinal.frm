VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormPrazoFinal 
   Caption         =   "Prazo Final"
   ClientHeight    =   2730
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   3585
   OleObjectBlob   =   "FormPrazoFinal.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormPrazoFinal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub btnCancelar_Click()
    tbxDataAgendamento.Text = Empty
    tbxHoraAgendamento.Text = Empty
    btnOK.Enabled = False
    
    Projeto1.FormPrazoFinal.Hide
End Sub

Private Sub btnOK_Click()
        
    DataAgendamento = tbxDataAgendamento.Text
    HoraAgendamento = tbxHoraAgendamento.Text
    
    Projeto1.FormPrazoFinal.Hide
    
    tbxDataAgendamento.Text = Empty
    tbxHoraAgendamento.Text = Empty
    btnOK.Enabled = False
    
End Sub

Private Sub tbxDataAgendamento_Change()

    Dim strQtdDiasAgendamento As String

    If (Len(tbxDataAgendamento.Text) = 3 And Mid(tbxDataAgendamento.Text, 3, 1) <> "/") Then
        tbxDataAgendamento.Text = Left(tbxDataAgendamento.Text, 2) & "/" & Right(tbxDataAgendamento.Text, 1)
    ElseIf (Len(tbxDataAgendamento.Text) = 6 And Mid(tbxDataAgendamento.Text, 6, 1) <> "/") Then
        tbxDataAgendamento.Text = Left(tbxDataAgendamento.Text, 5) & "/" & Right(tbxDataAgendamento.Text, 1)
    End If
    
    If Len(tbxDataAgendamento) = 10 Then
        If IsDate(tbxDataAgendamento.Text) Then
            If (Mid(tbxDataAgendamento.Text, 7, 4) & Mid(tbxDataAgendamento.Text, 4, 2) & Mid(tbxDataAgendamento.Text, 1, 2)) < (Mid(Date, 7, 4) & Mid(Date, 4, 2) & Mid(Date, 1, 2)) Then
                MsgBox "Data anterior a data atual.", vbExclamation
                tbxDataAgendamento.Text = Empty
           Else
                If (Mid(tbxDataAgendamento.Text, 7, 4) & Mid(tbxDataAgendamento.Text, 4, 2) & Mid(tbxDataAgendamento.Text, 1, 2)) > (Mid(Date + 30, 7, 4) & Mid(Date + 30, 4, 2) & Mid(Date + 30, 1, 2)) Then
                    strQtdDiasAgendamento = DateDiff("d", Date, tbxDataAgendamento.Text)
                    If MsgBox("Confirma o prazo final para " + tbxDataAgendamento.Text + " (" + strQtdDiasAgendamento + " dias) ?", vbYesNo + vbExclamation, "Data do agendamento") = vbNo Then
                        tbxDataAgendamento.Text = Empty
                    Else
                        tbxHoraAgendamento.SetFocus
                    End If
                End If
            End If
            If Len(tbxHoraAgendamento) = 5 Then
                If (tbxHoraAgendamento.Text < Time()) Then
                    MsgBox "Hora anterior a hora atual.", vbExclamation
                    tbxHoraAgendamento.Text = Empty
                End If
            End If
        Else
            MsgBox "Data invalida.", vbExclamation
            tbxDataAgendamento.Text = Empty
        End If
    End If
    
    If tbxDataAgendamento.Text = Empty Or Len(tbxDataAgendamento.Text) < 5 Or tbxHoraAgendamento.Text = Empty Or Len(tbxHoraAgendamento.Text) < 5 Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
           
End Sub

Private Sub tbxHoraAgendamento_Change()
    tbxHoraAgendamento.MaxLength = 5
    
    If Len(tbxHoraAgendamento) = 2 Then
        tbxHoraAgendamento.Text = tbxHoraAgendamento.Text & ":"
        SendKeys "{End}", True
    End If
    
    If Left(tbxHoraAgendamento.Text, 1) > 2 Then
        tbxHoraAgendamento.Text = Empty
    ElseIf Left(tbxHoraAgendamento.Text, 2) > 23 Then
        tbxHoraAgendamento.Text = Left(tbxHoraAgendamento.Text, 1)
    ElseIf Right(tbxHoraAgendamento.Text, 1) > 5 Then
        If Len(tbxHoraAgendamento.value) = 4 Then
            tbxHoraAgendamento.Text = Left(tbxHoraAgendamento.Text, 3)
        End If
    End If
    
    If Len(tbxDataAgendamento) = 10 Then
        If IsDate(tbxDataAgendamento.Text) Then
            If (Mid(tbxDataAgendamento.Text, 7, 4) & Mid(tbxDataAgendamento.Text, 4, 2) & Mid(tbxDataAgendamento.Text, 1, 2)) = (Mid(Date, 7, 4) & Mid(Date, 4, 2) & Mid(Date, 1, 2)) Then
                If Len(tbxHoraAgendamento) = 5 Then
                    If (tbxHoraAgendamento.Text < Time()) Then
                        MsgBox "Hora anterior a hora atual.", vbExclamation
                        tbxHoraAgendamento.Text = Empty
                    End If
                End If
            End If
        End If
    End If
       
    If tbxDataAgendamento.Text = Empty Or Len(tbxDataAgendamento.Text) < 5 Or tbxHoraAgendamento.Text = Empty Or Len(tbxHoraAgendamento.Text) < 5 Then
       btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub UserForm_Click()
    btnOK.Enabled = False
End Sub
