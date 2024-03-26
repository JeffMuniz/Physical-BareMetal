VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormAbrirPlantao 
   Caption         =   "Abrir Plant�o"
   ClientHeight    =   4860
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4905
   OleObjectBlob   =   "FormAbrirPlantao.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormAbrirPlantao"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub btnNovoCliente_Click()
    If (cbxCliente.value <> Empty) Then
        cbxCliente.value = Empty
    End If
    
    tbxEnderecoCorporativo.Text = Empty
    tbxEnderecoCorporativo.Enabled = True
    tbxEnderecoCorporativo.SetFocus
End Sub

Private Sub btnTipoNovo_Click()
    cbxTipo.value = Empty
    tbxTipo.Text = Empty
    cbxArea.value = Empty
        
    If (tbxTipo.Visible = False) Then
        tbxTipo.Visible = True
        cbxTipo.Visible = False
        cbxArea.Enabled = True
        tbxTipo.SetFocus
    Else
        tbxTipo.Visible = False
        cbxTipo.Visible = True
        cbxArea.Enabled = False
        cbxTipo.SetFocus
    End If
End Sub

Private Sub cbxArea_Change()
    If (cbxArea.value = Empty Or tbxEnderecoCorporativo.Text = Empty Or (cbxTipo.Visible = True And cbxTipo.value = Empty) Or (tbxTipo.Visible = True And tbxTipo.Text = Empty)) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub cbxCliente_Change()
    Dim iFF As Integer
    Dim sLinha As String
    
    tbxEnderecoCorporativo.Text = Empty
    tbxEnderecoCorporativo.Enabled = False
            
    If Dir("c:\InterRT\Outlook\BotoesOutlookCliente.txt", vbArchive) <> vbNullString Then
        iFF = FreeFile
    
        Open "c:\InterRT\Outlook\BotoesOutlookCliente.txt" For Input As iFF
    
        Do While Not EOF(iFF)
            Line Input #iFF, sLinha
        
            If (Mid(sLinha, InStr(1, sLinha, ";") + 1) = cbxCliente.Text) Then
                tbxEnderecoCorporativo.Text = Mid(sLinha, 1, InStr(1, sLinha, ";") - 1)
                tbxEnderecoCorporativo.Enabled = False
            End If
        Loop
    
        Close iFF
    End If
End Sub

Private Sub cbxTipo_Change()

    Select Case cbxTipo.value
    Case "ADM Redes"
        cbxArea.value = "Infra"
    Case "Administrativo"
        cbxArea.value = "Infra"
    Case "Banco de Dados"
        cbxArea.value = "DBA"
    Case "Desenvolvimento"
        cbxArea.value = "Sistemas"
    Case "Gest�o"
        cbxArea.value = "Gest�o"
    Case "Linux"
        cbxArea.value = "Infra"
    Case "Microsoft SQL"
        cbxArea.value = "DBA"
    Case "MySQL"
        cbxArea.value = "DBA"
    Case "Oracle"
        cbxArea.value = "DBA"
    Case "PostgreSQL"
        cbxArea.value = "DBA"
    Case "SO"
        cbxArea.value = "Infra"
    Case "Windows"
        cbxArea.value = "Infra"
    Case Else
    End Select

    cbxArea.Enabled = False
    
    If ((cbxTipo.Visible = True And cbxTipo.value = Empty) Or cbxArea.value = Empty Or tbxEnderecoCorporativo.Text = Empty Or (tbxTipo.Visible = True And tbxTipo.Text = Empty)) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub tbxEnderecoCorporativo_Change()
    If (tbxEnderecoCorporativo.Text = Empty Or cbxArea.value = Empty Or (cbxTipo.Visible = True And cbxTipo.value = Empty) Or (tbxTipo.Visible = True And tbxTipo.Text = Empty)) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub tbxTipo_Change()
    If ((tbxTipo.Visible = True And tbxTipo.Text = Empty) Or tbxEnderecoCorporativo.Text = Empty Or cbxArea.value = Empty Or (cbxTipo.Visible = True And cbxTipo.value = Empty)) Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub UserForm_Initialize()
    CarregaComboCliente
    
    cbxArea.Clear
    cbxArea.AddItem "DBA"
    cbxArea.AddItem "Gest�o"
    cbxArea.AddItem "Infra"
    cbxArea.AddItem "Sistemas"

    cbxTipo.Clear
    cbxTipo.AddItem "ADM Redes"
    cbxTipo.AddItem "Administrativo"
    cbxTipo.AddItem "Banco de Dados"
    cbxTipo.AddItem "Desenvolvimento"
    cbxTipo.AddItem "Gest�o"
    cbxTipo.AddItem "Linux"
    cbxTipo.AddItem "Microsoft SQL"
    cbxTipo.AddItem "MySQL"
    cbxTipo.AddItem "Oracle"
    cbxTipo.AddItem "PostgreSQL"
    cbxTipo.AddItem "SO"
    cbxTipo.AddItem "Windows"
    
    cbxCliente.value = ""
    tbxEnderecoCorporativo.Text = ""
    cbxTipo.value = ""
    cbxArea.value = ""
    cbxTipo.Visible = True
    tbxTipo.Visible = False
    cbxArea.Enabled = False
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Terminate()
    cbxCliente.value = ""
    tbxEnderecoCorporativo.Text = ""
    cbxTipo.value = ""
    tbxTipo.Text = ""
    cbxArea.value = ""
    cbxTipo.Visible = True
    tbxTipo.Visible = False
    cbxArea.Enabled = False
    btnOK.Enabled = False
End Sub

Private Sub btnCancelar_Click()
    cbxCliente.value = ""
    tbxEnderecoCorporativo.Text = ""
    cbxTipo.value = ""
    tbxTipo.Text = ""
    cbxArea.value = ""
    
    cbxTipo.Visible = True
    tbxTipo.Visible = False
    cbxArea.Enabled = False
    btnOK.Enabled = False
    
    Projeto1.FormAbrirPlantao.Hide
End Sub

Private Sub btnOK_Click()

    If tbxEnderecoCorporativo.value = Empty Then
        MsgBox "Informe o endere�o corporativo do cliente.", vbExclamation
    ElseIf Len(cbxArea.value) = 0 Then
        MsgBox "Selecione a �rea.", vbExclamation
    ElseIf cbxTipo.Visible = True And Len(cbxTipo.value) = 0 Then
        MsgBox "Selecione o tipo.", vbExclamation
    ElseIf tbxTipo.Visible = True And tbxTipo.Text = Empty Then
        MsgBox "Informe o tipo.", vbExclamation
    Else
        If LCase(tbxEnderecoCorporativo.Text) = "h9j" Then
            MsgBox "Informe o endere�o abrir.h9j@intersolution.com.br.", vbInformation
        End If
        
        EnderecoCorporativo = tbxEnderecoCorporativo.Text
        If cbxTipo.Visible = True Then
            Tipo = cbxTipo.value
        ElseIf tbxTipo.Visible = True Then
            Tipo = tbxTipo.Text
        End If
        Area = Replace(cbxArea.value, "Gest�o", "Gestao")
    End If
    
    Projeto1.FormAbrirPlantao.Hide
    
    cbxCliente.value = Empty
    tbxEnderecoCorporativo.Text = Empty
    cbxTipo.value = Empty
    tbxTipo.Text = Empty
    cbxArea.value = Empty
        
    cbxTipo.Visible = True
    tbxTipo.Visible = False
    cbxArea.Enabled = False
    btnOK.Enabled = False
End Sub

Sub CarregaComboCliente()
    Dim iFF As Integer
    Dim sLinha As String

    'Download do arquivo com a lista de clientes
    Download
    
    iFF = FreeFile
    
    cbxCliente.Clear

    If Dir("c:\InterRT\Outlook\BotoesOutlookCliente.txt", vbArchive) <> vbNullString Then
        Open "c:\InterRT\Outlook\BotoesOutlookCliente.txt" For Input As iFF
    
        Do While Not EOF(iFF)
            Line Input #iFF, sLinha
            cbxCliente.AddItem Mid(sLinha, InStr(1, sLinha, ";") + 1)
        Loop
    
        Close iFF
    Else
        tbxEnderecoCorporativo.Text = Empty
        tbxEnderecoCorporativo.Enabled = True
    End If
    
End Sub


Public Sub Download()
On Error GoTo Err

    Dim Auxiliar As Long
    Dim URL As String, CaminhoLocal As String
    
    URL = "http://wiki.intersolution.com.br:18330/wiki/images/6/6a/BotoesOutlookCliente.txt?" & Format(Date, "yyyymmdd") & Time
    
    If Dir("c:\InterRT\Outlook", vbDirectory) = vbNullString Then
        MkDir "c:\InterRT"
        MkDir "c:\InterRT\Outlook"
    End If
    
    CaminhoLocal = "c:\InterRT\Outlook\BotoesOutlookCliente.txt"
    
    Auxiliar = URLDownloadToFile(0, URL, CaminhoLocal, 0, 0)
    
    If (Auxiliar <> 0) Then
        If Dir("c:\InterRT\Outlook\BotoesOutlookCliente.txt", vbArchive) <> vbNullString Then
            DataArquivo = Format(FileDateTime("c:\InterRT\Outlook\BotoesOutlookCliente.txt"), "yyyy-mm-dd")
       
            If (DataArquivo < Format(DateAdd("d", -4, Date), "yyyy-mm-dd")) Then
                MsgBox ("Arquivo de clientes desatualizado." & vbNewLine & "Favor realizar o download do arquivo na Wiki e gravar no diretorio c:\InterRT\Outlook.")
            End If
        Else
            MsgBox ("O arquivo de clientes n�o foi localizado. " & vbNewLine & "Favor realizar o download do arquivo na Wiki e gravar no diretorio c:\InterRT\Outlook.")
        End If
    End If
    
Err:
    If (Err <> 0) Then
        If Dir("c:\InterRT\Outlook\BotoesOutlookCliente.txt", vbArchive) <> vbNullString Then
            DataArquivo = Format(FileDateTime("c:\InterRT\Outlook\BotoesOutlookCliente.txt"), "yyyy-mm-dd")
       
            If (DataArquivo < Format(DateAdd("d", -4, Date), "yyyy-mm-dd")) Then
                MsgBox ("Arquivo de clientes desatualizado." & vbNewLine & "Favor realizar o download do arquivo na Wiki e gravar no diretorio c:\InterRT\Outlook.")
            End If
        Else
            MsgBox ("O arquivo de clientes n�o foi localizado." & vbNewLine & "Favor realizar o download do arquivo na Wiki e gravar no diretorio c:\InterRT\Outlook.")
        End If
    End If
End Sub
