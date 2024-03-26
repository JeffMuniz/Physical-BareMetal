VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormFecharVisita 
   Caption         =   "Fechar Visita"
   ClientHeight    =   4125
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4140
   OleObjectBlob   =   "FormFecharVisita.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormFecharVisita"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cbxFormaAtendimento_Change()
    tbxHoraFechamento_Change
End Sub

Private Sub UserForm_Activate()
    tbxHoraFechamento.Text = Mid(Time, 1, 5)
    tbxHoraEntrada.Text = HoraEntrada
    tbxHoraFechamento_Change
End Sub

Private Sub UserForm_Initialize()
    cbxFormaAtendimento.Clear
    cbxFormaAtendimento.AddItem "Presencial"
    cbxFormaAtendimento.AddItem "Remoto"
    
    tbxHoraFechamento.Text = Mid(Time, 1, 5)
    tbxDataEntrada.Text = DataEntrada
    tbxHoraEntrada.Text = HoraEntrada
    cbxFormaAtendimento.value = "Presencial"
    
    tbxHoraFechamento_Change
    
    btnOK.Enabled = True
End Sub

Private Sub UserForm_Terminate()
    tbxHoraFechamento.Text = ""
    cbxFormaAtendimento.value = ""
    tbxTotalHoras = "00:00"
    lblTempoUtilizado.ForeColor = &H0&
            
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Unload()
Unload Me
End Sub

Private Sub btnCancelar_Click()
    tbxHoraFechamento.Text = Mid(Time, 1, 5)
    tbxHoraEntrada.Text = HoraEntrada
    cbxFormaAtendimento.value = "Presencial"
    
    tbxHoraFechamento_Change
    
    btnOK.Enabled = True
       
    UserForm_Unload
End Sub

Private Sub btnOK_Click()
    Dim DataArquivo As Date
        
    With CreateObject("vbscript.regexp")
        .Pattern = "^([0-2]{1})([0-9]{1}):([0-5]{1})([0-9]{1})$"
        Do
            strHoraFechamento = tbxHoraFechamento.value
            
            If StrPtr(strHoraFechamento) = 0 Then Exit Sub
                        
            If strHoraFechamento = "" Then
                MsgBox "É obrigatório informar a hora do fechamento da visita." & vbNewLine & " " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59)." & vbNewLine & " " & vbNewLine & "Para os casos que não foram utilizadas horas, informar no horário do término o mesmo horário do início da interação.", vbExclamation
            ElseIf Not .test(strHoraFechamento) Then
                MsgBox "Hora Incorreta. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
            ElseIf Left(strHoraFechamento, 2) > 23 Then
                MsgBox "Hora Incorreta. " & vbNewLine & "Preencher no formato HH:MM (00:00 - 23:59).", vbExclamation
                strHoraFechamento = ""
            End If
        Loop Until .test(strHoraFechamento)
    End With

    If Len(cbxFormaAtendimento.value) = 0 Then
        MsgBox "Selecione a forma de atendimento.", vbExclamation
    Else
        If Left(lblTotalHoras, 2) > 9 Then
            If MsgBox("O tempo utilizado (" & lblTotalHoras & ") está acima de 9 horas." & vbNewLine & vbNewLine & "Isso pode indicar um erro no preenchimento." & vbNewLine & " " & vbNewLine & "Confirma o tempo utilizado na visita ?", vbYesNo + vbExclamation, "Tempo utilizado na visita") = vbNo Then
                tbxHoraFechamento.Text = Empty
                tbxHoraFechamento.SetFocus
            Else
            
                If (DataEntrada < Mid(Date, 1, 2) & "/" & Mid(Date, 4, 2) & "/" & Mid(Date, 7, 4)) Then
                    JustificativaDataVisita = InputBox("A data da visita é anterior a data atual." & vbNewLine & vbNewLine & "Por favor, informe o motivo da abertura da visita com data anterior.")
                    If JustificativaDataVisita = "" Then Exit Sub
                Else
                    JustificativaDataVisita = ""
                End If
            
                HoraFechamento = tbxHoraFechamento.Text
                FormaAtendimento = LCase(cbxFormaAtendimento.value)
        
                UserForm_Unload
            End If
        Else
        
            If (DataEntrada < Mid(Date, 1, 2) & "/" & Mid(Date, 4, 2) & "/" & Mid(Date, 7, 4)) Then
                JustificativaDataVisita = InputBox("A data da visita é anterior a data atual." & vbNewLine & vbNewLine & "Por favor, informe o motivo da abertura da visita com data anterior.")
                If JustificativaDataVisita = "" Then Exit Sub
            Else
                JustificativaDataVisita = ""
            End If
        
            HoraFechamento = tbxHoraFechamento.Text
            FormaAtendimento = LCase(cbxFormaAtendimento.value)
        
            UserForm_Unload
        End If
    End If
    
End Sub

Private Sub tbxHoraFechamento_Change()
    tbxHoraFechamento.MaxLength = 5
    
    If Len(tbxHoraFechamento) = 2 Then
        tbxHoraFechamento.Text = tbxHoraFechamento.Text & ":"
        SendKeys "{End}", True
    End If
    
    If Left(tbxHoraFechamento.Text, 1) > 2 Then
        tbxHoraFechamento.Text = Empty
    ElseIf Left(tbxHoraFechamento.Text, 2) > 23 Then
        tbxHoraFechamento.Text = Left(tbxHoraFechamento.Text, 1)
    ElseIf Right(tbxHoraFechamento.Text, 1) > 5 Then
        If Len(tbxHoraFechamento.value) = 4 Then
            tbxHoraFechamento.Text = Left(tbxHoraFechamento.Text, 3)
        End If
    End If
    
    If Len(tbxHoraEntrada) = 5 And Len(tbxHoraFechamento) = 5 Then
        If DateDiff("n", tbxHoraEntrada.Text, tbxHoraFechamento.Text) < 0 Then
            lblTotalHoras = Format((((DateDiff("n", tbxHoraEntrada.Text, "23:59") + DateDiff("n", "00:00", tbxHoraFechamento.Text) + 1) \ 60) * 100) + ((DateDiff("n", tbxHoraEntrada.Text, "23:59") + DateDiff("n", "00:00", tbxHoraFechamento.Text) + 1) Mod 60), "00:00")
        Else
            lblTotalHoras = Format(((DateDiff("n", tbxHoraEntrada.Text, tbxHoraFechamento.Text) \ 60) * 100) + (DateDiff("n", tbxHoraEntrada.Text, tbxHoraFechamento.Text) Mod 60), "00:00")
        End If
    Else
        lblTotalHoras = "00:00"
    End If
        
    If Len(tbxHoraFechamento) < 5 Or Len(cbxFormaAtendimento.value) = 0 Then
        btnOK.Enabled = False
    Else
        If (cbxFormaAtendimento.value = "Remoto" And Right(lblTotalHoras, 2) <> "00" And Right(lblTotalHoras, 2) <> "30") Then
            lblTotalHoras.ForeColor = &HFF&
            btnOK.Enabled = False
        Else
            lblTotalHoras.ForeColor = &HC000&
            btnOK.Enabled = True
        End If
    End If
    
End Sub
