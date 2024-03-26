VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormFecharPlantao 
   Caption         =   "Fechar Plant�o"
   ClientHeight    =   6390
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4845
   OleObjectBlob   =   "FormFecharPlantao.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormFecharPlantao"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cbxFormaAtendimento_Change()
    If (Len(cbxFormaAtendimento) > 0 And lblTotalHoras.ForeColor = &HC000& And Len(cbxArea) > 0) Then
        btnOK.Enabled = True
    Else
        btnOK.Enabled = False
    End If
End Sub

Private Sub UserForm_Activate()
    cbxFormaAtendimento.Clear
    cbxFormaAtendimento.AddItem "Presencial"
    cbxFormaAtendimento.AddItem "Remoto"
    
    cbxArea.Clear
    cbxArea.AddItem "DBA"
    cbxArea.AddItem "Gest�o"
    cbxArea.AddItem "Infra"
    cbxArea.AddItem "Sistemas"
    
    cbxFormaAtendimento.value = "Remoto"
    tbxDataInicial.Text = Mid(Date, 1, 2) & "/" & Mid(Date, 4, 2) & "/" & Mid(Date, 7, 4)
    tbxHoraInicial.Text = Empty
    tbxDataFinal.Text = Mid(Date, 1, 2) & "/" & Mid(Date, 4, 2) & "/" & Mid(Date, 7, 4)
    tbxHoraFinal.Text = Empty
    tbxTotalHoras = "00:00"
    lblTempoUtilizado.ForeColor = &H0&
    cbxArea.value = Empty
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Initialize()
    cbxFormaAtendimento.Clear
    cbxFormaAtendimento.AddItem "Presencial"
    cbxFormaAtendimento.AddItem "Remoto"
    
    cbxArea.Clear
    cbxArea.AddItem "DBA"
    cbxArea.AddItem "Gest�o"
    cbxArea.AddItem "Infra"
    cbxArea.AddItem "Sistemas"
    
    cbxFormaAtendimento.value = "Remoto"
    tbxDataInicial.Text = Mid(Date, 1, 2) & "/" & Mid(Date, 4, 2) & "/" & Mid(Date, 7, 4)
    tbxHoraInicial.Text = Empty
    tbxDataFinal.Text = Mid(Date, 1, 2) & "/" & Mid(Date, 4, 2) & "/" & Mid(Date, 7, 4)
    tbxHoraFinal.Text = Empty
    tbxTotalHoras = "00:00"
    lblTempoUtilizado.ForeColor = &H0&
    cbxArea.value = Empty
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Terminate()
    cbxFormaAtendimento.value = "Remoto"
    tbxDataInicial.Text = Empty
    tbxHoraInicial.Text = Empty
    tbxDataFinal.Text = Empty
    tbxHoraFinal.Text = Empty
    tbxTotalHoras = "00:00"
    lblTempoUtilizado.ForeColor = &H0&
    cbxArea.value = Empty
    btnOK.Enabled = False
End Sub

Private Sub btnCancelar_Click()
    cbxFormaAtendimento.value = "Remoto"
    tbxDataInicial.Text = Empty
    tbxHoraInicial.Text = Empty
    tbxDataFinal.Text = Empty
    tbxHoraFinal.Text = Empty
    tbxTotalHoras = "00:00"
    lblTempoUtilizado.ForeColor = &H0&
    cbxArea.value = Empty
    btnOK.Enabled = False
    
    Projeto1.FormFecharPlantao.Hide
End Sub

Private Sub btnOK_Click()

    With CreateObject("vbscript.regexp")
        .Pattern = "^([0-2]{1})([0-9]{1}):([0-5]{1})([0-9]{1})$"
        Do
            strHoraInicial = tbxHoraInicial.value
            
            If StrPtr(strHoraInicial) = 0 Then Exit Sub
                        
            If strHoraInicial = "" Then
                MsgBox "� obrigat�rio informar a hora do in�cio da intera��o. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
            ElseIf Not .test(strHoraInicial) Then
                MsgBox "Hora Incorreta. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
            ElseIf Left(strHoraInicial, 2) > 23 Then
                MsgBox "Hora Incorreta. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
                strHoraInicial = ""
            End If
        Loop Until .test(strHoraInicial)
    End With
        
    With CreateObject("vbscript.regexp")
        .Pattern = "^([0-2]{1})([0-9]{1}):([0-5]{1})([0-9]{1})$"
        Do
            strHoraFinal = tbxHoraFinal.value
            
            If StrPtr(strHoraFinal) = 0 Then Exit Sub
                        
            If strHoraFinal = "" Then
                MsgBox "� obrigat�rio informar a hora do t�rmino da intera��o." & vbNewLine & " " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59)." & vbNewLine & " " & vbNewLine & "Para os casos que n�o foram utilizadas horas, informar no hor�rio do t�rmino o mesmo hor�rio do in�cio da intera��o.", vbExclamation
            ElseIf Not .test(strHoraFinal) Then
                MsgBox "Hora Incorreta. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
            ElseIf Left(strHoraFinal, 2) > 23 Then
                MsgBox "Hora Incorreta. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
                strHoraFinal = ""
            ElseIf (DateDiff("n", strHoraInicial, strHoraFinal) Mod 30) > 0 Then
                MsgBox "Tempo utilizado fora dos padr�es de atendimento da InterSolution." & vbNewLine & " " & vbNewLine & "Hor�rio do atendimento: Das " & strHoraInicial & " �s " & strHoraFinal & vbNewLine & " " & vbNewLine & "Tempo utilizado no atendimento: " & Right("00" & Round((DateDiff("n", strHoraInicial, strHoraFinal) / 60), 0), 2) & ":" & Right("00" & (DateDiff("n", strHoraInicial, strHoraFinal) Mod 30), 2) & vbNewLine & " " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
                strHoraFinal = ""
            End If
        Loop Until .test(strHoraFinal)
    End With

    If Len(cbxArea.value) = 0 Then
        MsgBox "Selecione a area", vbExclamation
    Else
        If Left(lblTotalHoras, 2) > 4 Then
            If MsgBox("O tempo utilizado (" & lblTotalHoras & ") est� acima de 4 horas." & vbNewLine & vbNewLine & "Isso pode indicar um erro no preenchimento." & vbNewLine & " " & vbNewLine & "Confirma o tempo utilizado no plant�o ?", vbYesNo + vbExclamation, "Tempo utilizado no plant�o") = vbNo Then
                tbxHoraFinal.Text = Empty
                tbxHoraFinal.SetFocus
            Else
                FormaAtendimento = LCase(cbxFormaAtendimento.value)
                DataInicial = tbxDataInicial.Text
                DataFinal = tbxDataFinal.Text
                HoraInicial = tbxHoraInicial.Text
                HoraFinal = tbxHoraFinal.Text
                Area = Replace(cbxArea.value, "Gest�o", "Gestao")
    
                Projeto1.FormFecharPlantao.Hide
            
                cbxFormaAtendimento.value = "Remoto"
                tbxDataInicial.Text = Empty
                tbxDataFinal.Text = Empty
                tbxHoraInicial.Text = Empty
                tbxHoraFinal.Text = Empty
                tbxTotalHoras = "00:00"
                lblTempoUtilizado.ForeColor = &H0&
                cbxArea.value = Empty
                btnOK.Enabled = False
            End If
        Else
            FormaAtendimento = LCase(cbxFormaAtendimento.value)
            DataInicial = tbxDataInicial.Text
            DataFinal = tbxDataFinal.Text
            HoraInicial = tbxHoraInicial.Text
            HoraFinal = tbxHoraFinal.Text
            Area = Replace(cbxArea.value, "Gest�o", "Gestao")
    
            Projeto1.FormFecharPlantao.Hide
            
            cbxFormaAtendimento.value = "Remoto"
            tbxDataInicial.Text = Empty
            tbxDataFinal.Text = Empty
            tbxHoraInicial.Text = Empty
            tbxHoraFinal.Text = Empty
            tbxTotalHoras = "00:00"
            lblTempoUtilizado.ForeColor = &H0&
            cbxArea.value = Empty
            btnOK.Enabled = False
        End If
    End If
    
End Sub

Private Sub tbxHoraInicial_Change()
    tbxHoraInicial.MaxLength = 5

    If Len(tbxHoraInicial) = 2 Then
        tbxHoraInicial.Text = tbxHoraInicial.Text & ":"
        SendKeys "{End}", True
    End If
    
    If Left(tbxHoraInicial.Text, 1) > 2 Then
        tbxHoraInicial.Text = Empty
    ElseIf Left(tbxHoraInicial.Text, 2) > 23 Then
        tbxHoraInicial.Text = Left(tbxHoraInicial.Text, 1)
    ElseIf Right(tbxHoraInicial.Text, 1) > 5 Then
        If Len(tbxHoraInicial.value) = 4 Then
            tbxHoraInicial.Text = Left(tbxHoraInicial.Text, 3)
        End If
    End If
    
    If Len(tbxHoraInicial) = 5 Then
        If IsDate(tbxHoraInicial.Text) Then
            If Len(tbxHoraInicial) = 5 And Len(tbxHoraFinal) = 5 And Len(tbxDataInicial) = 10 And Len(tbxDataFinal) = 10 Then
                lblTotalHoras = Format(((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60), "00:00")
        
                If (tbxDataInicial.Text = tbxDataFinal.Text) Then
                    If DateDiff("n", tbxHoraInicial.Text, tbxHoraFinal.Text) < 0 Then
                        MsgBox "Hora de in�cio maior que a hora de t�rmino.", vbExclamation
                        tbxHoraInicial.Text = Empty
                        lblTotalHoras = "00:00"
                    End If
                End If
            
                If (((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60) >= 2400) Then
                    MsgBox "Tempo utilizado fora dos padr�es de atendimento da InterSolution." & vbNewLine & " " & vbNewLine & "Tempo m�ximo permitido 23:30." & vbNewLine & " " & vbNewLine & "Data/Hora do atendimento: " & tbxDataInicial.Text & " " & tbxHoraInicial.Text & " - " & tbxDataFinal.Text & " " & tbxHoraFinal.Text & vbNewLine & " " & vbNewLine & "Tempo utilizado no atendimento: " & lblTotalHoras, vbExclamation
                    tbxHoraInicial.Text = Empty
                    lblTotalHoras = "00:00"
                End If
            Else
                lblTotalHoras = "00:00"
            End If
        Else
            MsgBox "Hora inv�lida.", vbExclamation
            tbxHoraInicial.Text = Empty
            lblTotalHoras = "00:00"
        End If
    Else
        lblTotalHoras = "00:00"
    End If
      
    If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Or Len(tbxDataInicial) < 10 Or Len(tbxDataFinal) < 10 Or Len(tbxHoraInicial) < 5 Or Len(tbxHoraFinal) < 5 Then
        If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Then
            lblTotalHoras.ForeColor = &HFF&
        Else
            lblTotalHoras.ForeColor = &HC000&
        End If
        btnOK.Enabled = False
    Else
        lblTotalHoras.ForeColor = &HC000&
        If Len(cbxFormaAtendimento) > 0 And Len(cbxArea.value) > 0 Then
            btnOK.Enabled = True
        Else
            btnOK.Enabled = False
        End If
    End If
End Sub

Private Sub tbxHoraFinal_Change()
    tbxHoraFinal.MaxLength = 5
    
    If Len(tbxHoraFinal) = 2 Then
        tbxHoraFinal.Text = tbxHoraFinal.Text & ":"
        SendKeys "{End}", True
    End If
    
    If Left(tbxHoraFinal.Text, 1) > 2 Then
        tbxHoraFinal.Text = Empty
    ElseIf Left(tbxHoraFinal.Text, 2) > 23 Then
        tbxHoraFinal.Text = Left(tbxHoraFinal.Text, 1)
    ElseIf Right(tbxHoraFinal.Text, 1) > 5 Then
        If Len(tbxHoraFinal.value) = 4 Then
            tbxHoraFinal.Text = Left(tbxHoraFinal.Text, 3)
        End If
    End If
    
    If Len(tbxHoraFinal) = 5 Then
        If IsDate(tbxHoraFinal.Text) Then
            If Len(tbxHoraInicial) = 5 And Len(tbxHoraFinal) = 5 And Len(tbxDataInicial) = 10 And Len(tbxDataFinal) = 10 Then
                lblTotalHoras = Format(((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60), "00:00")
        
                If (tbxDataInicial.Text = tbxDataFinal.Text) Then
                    If DateDiff("n", tbxHoraInicial.Text, tbxHoraFinal.Text) < 0 Then
                        MsgBox "Hora de t�rmino menor que a hora de in�cio.", vbExclamation
                        tbxHoraFinal.Text = Empty
                        lblTotalHoras = "00:00"
                    End If
                End If
        
                If (((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60) >= 2400) Then
                    MsgBox "Tempo utilizado fora dos padr�es de atendimento da InterSolution." & vbNewLine & " " & vbNewLine & "Tempo m�ximo permitido 23:30." & vbNewLine & " " & vbNewLine & "Data/Hora do atendimento: " & tbxDataInicial.Text & " " & tbxHoraInicial.Text & " - " & tbxDataFinal.Text & " " & tbxHoraFinal.Text & vbNewLine & " " & vbNewLine & "Tempo utilizado no atendimento: " & lblTotalHoras, vbExclamation
                    tbxHoraFinal.Text = Empty
                    lblTotalHoras = "00:00"
                End If
            Else
                lblTotalHoras = "00:00"
            End If
        Else
            MsgBox "Hora inv�lida.", vbExclamation
            tbxHoraFinal.Text = Empty
            lblTotalHoras = "00:00"
        End If
    Else
        lblTotalHoras = "00:00"
    End If
    
    If (Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30") Or Len(tbxDataInicial) < 10 Or Len(tbxDataFinal) < 10 Or Len(tbxHoraInicial) < 5 Or Len(tbxHoraFinal) < 5 Then
        If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Then
            lblTotalHoras.ForeColor = &HFF&
        Else
            lblTotalHoras.ForeColor = &HC000&
        End If
        btnOK.Enabled = False
    Else
        lblTotalHoras.ForeColor = &HC000&
        If Len(cbxFormaAtendimento) > 0 And Len(cbxArea.value) > 0 Then
            btnOK.Enabled = True
        Else
            btnOK.Enabled = False
        End If
    End If
    
End Sub

Private Sub cbxArea_Change()
    If (Len(cbxFormaAtendimento) > 0 And lblTotalHoras.ForeColor = &HC000& And Len(cbxArea) > 0) Then
        btnOK.Enabled = True
    Else
        btnOK.Enabled = False
    End If
End Sub

Private Sub tbxDataInicial_Change()
    If (Len(tbxDataInicial.Text) = 3 And Mid(tbxDataInicial.Text, 3, 1) <> "/") Then
        tbxDataInicial.Text = Left(tbxDataInicial.Text, 2) & "/" & Right(tbxDataInicial.Text, 1)
    ElseIf (Len(tbxDataInicial.Text) = 6 And Mid(tbxDataInicial.Text, 6, 1) <> "/") Then
        tbxDataInicial.Text = Left(tbxDataInicial.Text, 5) & "/" & Right(tbxDataInicial.Text, 1)
    End If
    
    If Len(tbxDataInicial) = 10 Then
        If IsDate(tbxDataInicial.Text) Then
            If (Mid(tbxDataInicial.Text, 7, 4) & Mid(tbxDataInicial.Text, 4, 2) & Mid(tbxDataInicial.Text, 1, 2)) > (Mid(Date, 7, 4) & Mid(Date, 4, 2) & Mid(Date, 1, 2)) Then
                MsgBox "Data posterior a data atual.", vbExclamation
                tbxDataInicial.Text = Empty
            Else
                If (Len(tbxDataFinal) = 10) Then
                    If (Mid(tbxDataInicial.Text, 7, 4) & Mid(tbxDataInicial.Text, 4, 2) & Mid(tbxDataInicial.Text, 1, 2)) > (Mid(tbxDataFinal.Text, 7, 4) & Mid(tbxDataFinal.Text, 4, 2) & Mid(tbxDataFinal.Text, 1, 2)) Then
                        MsgBox "Data de in�cio maior que a data de t�rmino.", vbExclamation
                        tbxDataFinal.Text = Empty
                    End If
                End If
            End If
        Else
            MsgBox "Data inv�lida.", vbExclamation
            tbxDataInicial.Text = Empty
        End If
    End If
    
    If Len(tbxHoraInicial) = 5 And Len(tbxHoraFinal) = 5 And Len(tbxDataInicial) = 10 And Len(tbxDataFinal) = 10 Then
        lblTotalHoras = Format(((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60), "00:00")
        
        If (tbxDataInicial.Text = tbxDataFinal.Text) Then
            If DateDiff("n", tbxHoraInicial.Text, tbxHoraFinal.Text) < 0 Then
                MsgBox "Hora de in�cio maior que a hora de t�rmino.", vbExclamation
                tbxHoraInicial.Text = Empty
                lblTotalHoras = "00:00"
            End If
        End If
                    
        If (((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60) >= 2400) Then
            MsgBox "Tempo utilizado fora dos padr�es de atendimento da InterSolution." & vbNewLine & " " & vbNewLine & "Tempo m�ximo permitido 23:30." & vbNewLine & " " & vbNewLine & "Data/Hora do atendimento: " & tbxDataInicial.Text & " " & tbxHoraInicial.Text & " - " & tbxDataFinal.Text & " " & tbxHoraFinal.Text & vbNewLine & " " & vbNewLine & "Tempo utilizado no atendimento: " & lblTotalHoras, vbExclamation
            tbxHoraInicial.Text = Empty
            lblTotalHoras = "00:00"
        End If
    Else
        lblTotalHoras = "00:00"
    End If
    
    If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Or Len(tbxDataInicial) < 10 Or Len(tbxDataFinal) < 10 Or Len(tbxHoraInicial) < 5 Or Len(tbxHoraFinal) < 5 Then
        If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Then
            lblTotalHoras.ForeColor = &HFF&
        Else
            lblTotalHoras.ForeColor = &HC000&
        End If
        btnOK.Enabled = False
    Else
        lblTotalHoras.ForeColor = &HC000&
        btnOK.Enabled = True
    End If
End Sub

Private Sub tbxDataFinal_Change()
    If (Len(tbxDataFinal.Text) = 3 And Mid(tbxDataFinal.Text, 3, 1) <> "/") Then
        tbxDataFinal.Text = Left(tbxDataFinal.Text, 2) & "/" & Right(tbxDataFinal.Text, 1)
    ElseIf (Len(tbxDataFinal.Text) = 6 And Mid(tbxDataFinal.Text, 6, 1) <> "/") Then
        tbxDataFinal.Text = Left(tbxDataFinal.Text, 5) & "/" & Right(tbxDataFinal.Text, 1)
    End If
    
    If Len(tbxDataFinal) = 10 Then
        If IsDate(tbxDataFinal.Text) Then
            If (Mid(tbxDataFinal.Text, 7, 4) & Mid(tbxDataFinal.Text, 4, 2) & Mid(tbxDataFinal.Text, 1, 2)) > (Mid(Date, 7, 4) & Mid(Date, 4, 2) & Mid(Date, 1, 2)) Then
                MsgBox "Data posterior a data atual.", vbExclamation
                tbxDataFinal.Text = Empty
            Else
                If (Len(tbxDataFinal) = 10) Then
                    If (Mid(tbxDataInicial.Text, 7, 4) & Mid(tbxDataInicial.Text, 4, 2) & Mid(tbxDataInicial.Text, 1, 2)) > (Mid(tbxDataFinal.Text, 7, 4) & Mid(tbxDataFinal.Text, 4, 2) & Mid(tbxDataFinal.Text, 1, 2)) Then
                        MsgBox "Data de t�rmino menor que a data de in�cio.", vbExclamation
                        tbxDataFinal.Text = Empty
                    End If
                End If
            End If
        Else
            MsgBox "Data inv�lida.", vbExclamation
            tbxDataFinal.Text = Empty
        End If
    End If
    
    If Len(tbxHoraInicial) = 5 And Len(tbxHoraFinal) = 5 And Len(tbxDataInicial) = 10 And Len(tbxDataFinal) = 10 Then
        lblTotalHoras = Format(((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60), "00:00")
        
        If (tbxDataInicial.Text = tbxDataFinal.Text) Then
            If DateDiff("n", tbxHoraInicial.Text, tbxHoraFinal.Text) < 0 Then
                MsgBox "Hora de t�rmino menor que a hora de in�cio.", vbExclamation
                tbxHoraFinal.Text = Empty
                lblTotalHoras = "00:00"
            End If
        End If
                
        If (((DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) \ 60) * 100) + (DateDiff("n", tbxDataInicial & " " & tbxHoraInicial.Text, tbxDataFinal & " " & tbxHoraFinal.Text) Mod 60) >= 2400) Then
            MsgBox "Tempo utilizado fora dos padr�es de atendimento da InterSolution." & vbNewLine & " " & vbNewLine & "Tempo m�ximo permitido 23:30." & vbNewLine & " " & vbNewLine & "Data/Hora do atendimento: " & tbxDataInicial.Text & " " & tbxHoraInicial.Text & " - " & tbxDataFinal.Text & " " & tbxHoraFinal.Text & vbNewLine & " " & vbNewLine & "Tempo utilizado no atendimento: " & lblTotalHoras, vbExclamation
            tbxHoraFinal.Text = Empty
            lblTotalHoras = "00:00"
        End If
    Else
        lblTotalHoras = "00:00"
    End If
    
    If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Or Len(tbxDataInicial) < 10 Or Len(tbxDataFinal) < 10 Or Len(tbxHoraInicial) < 5 Or Len(tbxHoraFinal) < 5 Then
        If Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30" Then
            lblTotalHoras.ForeColor = &HFF&
        Else
            lblTotalHoras.ForeColor = &HC000&
        End If
        btnOK.Enabled = False
    Else
        lblTotalHoras.ForeColor = &HC000&
        btnOK.Enabled = True
    End If
End Sub
