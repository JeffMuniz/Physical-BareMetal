VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormManutencaoDB 
   Caption         =   "Manutenção DB"
   ClientHeight    =   8715.001
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   14625
   OleObjectBlob   =   "FormManutencaoDB.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormManutencaoDB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Criacao dinamica de eventos adaptada do artigo:
' http://ramblings.mcpher.com/Home/excelquirks/dynamic-forms/dynamic-event-handlers

Option Explicit
Private pControlEvents As Collection
Private WithEvents ptb As MSForms.CheckBox
Attribute ptb.VB_VarHelpID = -1
Private Const strNomeFrame = "chkFrame_"
Private Const strNomeChkServer = "CheckboxServer_"
Private Const strNomeChkBase = "CheckboxBase_"
Private Const CaminhoLocal = "C:\InterRT\Outlook\BotoesOutlookServidoresCliente.txt"
Private AtualizandoChkBox As Boolean

'
' Funcoes referentes aos checkBox
'

Private Function nomeFrame(id As Integer)
    nomeFrame = strNomeFrame & id
End Function

Private Function nomeCheckServer(id As Integer)
    nomeCheckServer = strNomeChkServer & id
End Function

Private Function nomeCheckBase(id As Integer, id2 As Integer)
    nomeCheckBase = strNomeChkBase & id & "_" & id2
End Function

Public Function retorna_selecionados()
    Dim controls As Object
    Dim chk As Object
    Dim ServerAtual As String
    Dim todas_bases As Boolean
    
    retorna_selecionados = ""
    
    For Each controls In Projeto1.FormManutencaoDB.FrameServidorBase.controls
        If is_frame(controls.name) Then
            todas_bases = False
            
            For Each chk In controls.controls
                If is_checkbox_base(chk.name) Or is_checkbox_server(chk.name) Then
                    If is_checkbox_server(chk.name) Then
                        ServerAtual = chk.Caption
                        If chk.value = True Then
                            todas_bases = True
                            retorna_selecionados = retorna_selecionados & ";" & ServerAtual & ":TODAS"
                        End If
                    ElseIf todas_bases = False And is_checkbox_base(chk.name) And chk.value = True Then
                        retorna_selecionados = retorna_selecionados & ";" & ServerAtual & ":" & chk.Caption
                    End If
                End If
            Next
        End If
    Next
    
End Function

' Procedimento de click num checkbox
Sub check_clicado(checkbox_name As String)

    ' Ao alterar o status do chkbox via codigo o evento de click eh disparado, sendo necessaria uma trava para nao gerar loop
    If IsEmpty(AtualizandoChkBox) Or AtualizandoChkBox = False Then
        AtualizandoChkBox = True
        
        'Verifica se foi server ou base
        If is_checkbox_server(checkbox_name) Then
            marca_bases (is_checkbox_server_id(checkbox_name))
        ElseIf is_checkbox_base(checkbox_name) Then
            marca_servidor (is_checkbox_server_id(checkbox_name))
        End If
        
        AtualizandoChkBox = False
        
        liberar_btnOK
    End If
    
End Sub

' Propaga status do servidor para as bases
Sub marca_bases(id As Integer)
    Dim Status As Boolean
    Dim chk As Object
    
    Status = Projeto1.FormManutencaoDB.FrameServidorBase.controls(nomeFrame(id)).controls(nomeCheckServer(id)).value
    
    ' Marca ou desmarca as bases baseado no servidor
    For Each chk In Projeto1.FormManutencaoDB.FrameServidorBase.controls(nomeFrame(id)).controls
        If is_checkbox_base(chk.name) Then
            chk.value = Status
        End If
    Next
    
End Sub

' Se alterou as bases, reflete no servidor
Sub marca_servidor(id As Integer)
    Dim Status As Boolean
    Dim chk As Object
    
    ' Verifica se todas as bases estao checadas
    Status = True
    For Each chk In Projeto1.FormManutencaoDB.FrameServidorBase.controls(nomeFrame(id)).controls
        If is_checkbox_base(chk.name) Then
            If chk.value = False Then
                Status = False
            End If
        End If
    Next
    
    Projeto1.FormManutencaoDB.FrameServidorBase.controls(nomeFrame(id)).controls(nomeCheckServer(id)).value = Status
    
End Sub

Private Function is_checkbox_server(checkbox_name As String)
    is_checkbox_server = InStr(checkbox_name, strNomeChkServer)
End Function

Private Function is_checkbox_base(checkbox_name As String)
    is_checkbox_base = InStr(checkbox_name, strNomeChkBase)
End Function

Private Function is_frame(obj_name As String)
    is_frame = InStr(obj_name, strNomeFrame)
End Function

Private Function is_checkbox_server_id(checkbox_name As String)
    Dim inicio As Integer
    Dim fim As Integer
    
    inicio = InStr(checkbox_name, "_")
    fim = InStr(inicio + 1, checkbox_name, "_")
    
    If fim = 0 Then
        is_checkbox_server_id = Mid(checkbox_name, inicio + 1)
    Else
        is_checkbox_server_id = Mid(checkbox_name, inicio + 1, fim - inicio - 1)
    End If
    
End Function

Private Function is_checkbox_base_id(checkbox_name As String)
    Dim inicioserver As Integer
    Dim iniciobase As Integer
    
    inicioserver = InStr(checkbox_name, "_")
    iniciobase = InStr(inicioserver + 1, checkbox_name, "_")
    
    is_checkbox_base_id = Mid(checkbox_name, iniciobase + 1)
End Function

Sub CarregaServidoresCliente()
    Dim iFF As Integer
    Dim iFimCliente As Integer
    Dim sCliente As String
    Dim iFimServidor As Integer
    Dim sServidor As String
    Dim sServidorAtual As String
    Dim sBase As String
    Dim sLinha As String
    
    Dim iLinha As Integer
    Dim iLinhaBase As Integer
    Dim iColuna As Integer
    Dim iAlturaColuna As Integer
    Dim iLarguraColuna As Integer
    Dim iLarguraColunaServidor As Integer
    Dim iAlturaColunaInicial As Integer
    Dim iAlturaFrameInicial As Integer
    Dim BasesPorColuna As Integer
    Dim indiceBase As Integer
    Dim indiceServidor As Integer
    Dim idFrame As String
    
    Dim cHandler As CheckBoxManutencao
    Dim LabelAviso As Object
    Set pControlEvents = New Collection
    
    iFF = FreeFile
    
    sServidorAtual = ""
    iLinha = -1
    indiceServidor = -1
    iAlturaColuna = 18
    iLarguraColuna = 60
    iLarguraColunaServidor = 200
    iAlturaColunaInicial = 10
    BasesPorColuna = 8
    iAlturaFrameInicial = 21
    
    Projeto1.FormManutencaoDB.FrameServidorBase.controls.Clear
    
    If Dir(CaminhoLocal, vbArchive) <> vbNullString Then
        Open CaminhoLocal For Input As iFF
    
        Do While Not EOF(iFF)
            Line Input #iFF, sLinha
            iFimCliente = InStr(sLinha, ";")
            sCliente = Mid(sLinha, 1, iFimCliente - 1)
            If sCliente = fila Then
                iFimServidor = InStr(iFimCliente + 1, sLinha, ";")
                sServidor = Mid(sLinha, iFimCliente + 1, iFimServidor - iFimCliente - 1)
                sBase = Mid(sLinha, iFimServidor + 1)
                
                If (sServidorAtual = "" Or sServidorAtual <> sServidor) Then
                    iLinha = iLinha + 1
                    iLinhaBase = 0
                    indiceBase = 0
                    indiceServidor = indiceServidor + 1
                    sServidorAtual = sServidor
                    iColuna = 0
                    
                    idFrame = nomeFrame(indiceServidor)
                    With Projeto1.FormManutencaoDB.FrameServidorBase.controls.Add("Forms.Frame.1", idFrame, True)
                        .Top = iAlturaColunaInicial + iAlturaFrameInicial * iLinha
                        .Width = 700
                        .Height = iAlturaFrameInicial
                    End With
                    
                    Set ptb = Projeto1.FormManutencaoDB.FrameServidorBase.controls(idFrame).Add("Forms.CheckBox.1", nomeCheckServer(indiceServidor), True)
                    With ptb
                        .Top = 0
                        .Caption = sServidorAtual
                        .Width = iLarguraColunaServidor
                    End With
                    
            
                    'Cria Event Handler e adiciona na pControlEvents para persistir
                    Set cHandler = New CheckBoxManutencao
                    Set cHandler.Control = ptb
                    pControlEvents.Add cHandler


                End If
                
                ' Base
                ' Nova linha
                If iColuna Mod BasesPorColuna = 0 And iColuna <> 0 Then
                    iLinha = iLinha + 1
                    iLinhaBase = iLinhaBase + 1
                    Projeto1.FormManutencaoDB.FrameServidorBase.controls(idFrame).Height = Projeto1.FormManutencaoDB.FrameServidorBase.controls(idFrame).Height + iAlturaColuna
                    iColuna = 0
                End If
                
                Set ptb = Projeto1.FormManutencaoDB.FrameServidorBase.controls(idFrame).Add("Forms.CheckBox.1", nomeCheckBase(indiceServidor, indiceBase), True)
                With ptb
                    .Top = iAlturaColuna * iLinhaBase
                    .Left = iLarguraColunaServidor + iLarguraColuna * iColuna
                    .Caption = Trim(sBase)
                End With
                iColuna = iColuna + 1
                indiceBase = indiceBase + 1
                
                'Cria Event Handler e adiciona na pControlEvents para persistir
                Set cHandler = New CheckBoxManutencao
                Set cHandler.Control = ptb
                pControlEvents.Add cHandler
                    
            End If
        Loop
    
        Close iFF
        
        If sServidorAtual = "" Then
            LabelMsgServidores.Visible = True
            LabelMsgServidores.Caption = "Nenhum Servidor do Cliente '" & UCase(fila) & "' encontrado nos monitoramentos SIGMon-Cloud"
            FrameServidorBase.Visible = False
            optDesativarMonitoramentoSim.Enabled = False
            optDesativarMonitoramentoNao.Enabled = False
        End If
        
    Else
         MsgBox ("O arquivo de Servidores do cliente não foi localizado. " & vbNewLine & "Favor realizar o download do arquivo na Wiki e gravar no diretorio c:\InterRT\Outlook.")
    End If
    
End Sub

Public Sub DownloadManutencao()
On Error GoTo Err

    Dim Auxiliar As Long
    Dim URL As String, DataArquivo As String
    
    URL = "http://sigmon.intersolution.com.br:8081/sigmon/RT/BotoesOutlookServidoresCliente.txt?rng=" & Format(Date, "yyyymmdd") & Time
    
    If Dir("c:\InterRT\Outlook", vbDirectory) = vbNullString Then
        MkDir "c:\InterRT"
        MkDir "c:\InterRT\Outlook"
    End If
    
    Auxiliar = URLDownloadToFile(0, URL, CaminhoLocal, 0, 0)
    
    If (Auxiliar <> 0) Then
        If Dir(CaminhoLocal, vbArchive) <> vbNullString Then
            DataArquivo = Format(FileDateTime(CaminhoLocal), "yyyy-mm-dd")
       
            If (DataArquivo < Format(DateAdd("d", -4, Date), "yyyy-mm-dd")) Then
                MsgBox ("Arquivo de clientes desatualizado." & vbNewLine & "Por favor verifique se 'http://sigmon.intersolution.com.br:8081/sigmon/' esta acessível." & vbNewLine & "Em seguida tente utilizar o botão novamente OU realize o download do arquivo e grave no diretorio c:\InterRT\Outlook.")
            End If
        Else
            MsgBox ("O arquivo de clientes não foi localizado. " & vbNewLine & "Por favor verifique se 'http://sigmon.intersolution.com.br:8081/sigmon/' esta acessível." & vbNewLine & "Em seguida tente utilizar o botão novamente OU realize o download do arquivo e grave no diretorio c:\InterRT\Outlook.")
        End If
    End If
    
Err:
    
     If Dir(CaminhoLocal, vbArchive) <> vbNullString Then
         DataArquivo = Format(FileDateTime(CaminhoLocal), "yyyy-mm-dd")
    
         If (DataArquivo < Format(DateAdd("d", -1, Date), "yyyy-mm-dd")) Then
             MsgBox ("Arquivo de servidores clientes desatualizado." & vbNewLine & "Por favor verifique se 'http://sigmon.intersolution.com.br:8081/sigmon/' esta acessível." & vbNewLine & "Em seguida tente utilizar o botão novamente OU realize o download do arquivo e grave no diretorio c:\InterRT\Outlook.")
         End If
     Else
         MsgBox ("O arquivo de servidores de clientes não foi localizado." & vbNewLine & "Por favor verifique se 'http://sigmon.intersolution.com.br:8081/sigmon/' esta acessível." & vbNewLine & "Em seguida tente utilizar o botão novamente OU realize o download do arquivo e grave no diretorio c:\InterRT\Outlook.")
     End If
End Sub

Private Sub optDesativarMonitoramentoSim_Click()
    If (optDesativarMonitoramentoSim.value = True) Then
        FrameServidorBase.Enabled = True
    Else
        FrameServidorBase.Enabled = False
    End If
    liberar_btnOK
End Sub

Private Sub optDesativarMonitoramentoNao_Click()
    If (optDesativarMonitoramentoNao.value = True) Then
        FrameServidorBase.Enabled = False
    Else
        FrameServidorBase.Enabled = True
    End If
    liberar_btnOK
End Sub

'
' Botoes normais do Formulario
'

Private Sub UserForm_Initialize()
    optDesativarMonitoramentoSim.value = True
    optDesativarMonitoramentoNao.value = False
    LabelMsgServidores.Visible = False
    FrameServidorBase.Visible = True
    optDesativarMonitoramentoSim.Enabled = True
    optDesativarMonitoramentoNao.Enabled = True
    'Download do arquivo com a lista de servidores e bases dos clientes
    DownloadManutencao
    CarregaServidoresCliente
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Activate()
    optDesativarMonitoramentoSim.value = True
    optDesativarMonitoramentoNao.value = False
    LabelMsgServidores.Visible = False
    FrameServidorBase.Visible = True
    optDesativarMonitoramentoSim.Enabled = True
    optDesativarMonitoramentoNao.Enabled = True
    'Download do arquivo com a lista de servidores e bases dos clientes
    DownloadManutencao
    CarregaServidoresCliente
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Terminate()
    btnOK.Enabled = False
End Sub

Private Sub btnCancelar_Click()
    Projeto1.FormManutencaoDB.Hide
End Sub

Private Sub liberar_btnOK()
    If (optDesativarMonitoramentoSim.value = True) Then
        If (retorna_selecionados() = "") Then
            btnOK.Enabled = False
        Else
            btnOK.Enabled = True
        End If
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub btnOK_Click()
    If (optDesativarMonitoramentoSim.value = True) Then
        DesativarMonitoramento = "S"
    Else
        DesativarMonitoramento = "N"
    End If
    
    Projeto1.FormManutencaoDB.Hide
End Sub
