Attribute VB_Name = "Module1"
'Attribute VB_Name = "Module1"
Public Area
Public DataInicial
Public DataFinal
Public HoraInicial
Public HoraFinal
Public TicketDependencia
Public RTDependencia
Public DataAgendamento
Public HoraAgendamento
Public HoraFechamento
Public EnderecoConsultor
Public EnderecoCorporativo
Public FormaAtendimento
Public Tipo
Public DataEntrada
Public HoraEntrada
Public Justificativa
Public TipoAtendimento
Public JustificativaDataVisita
Public SolicitacaoCliente
Public DesativarMonitoramento
Public EncerramentoAtividade
Public fila
Public ClienteEmCopia
Public AreaEmCopia
Public CorporativoEmCopia
Public ExibeRecorrencia
Public TicketRecorrencia
Public HabilitarSolicitacaoCliente

'Versao dos botoes
Public Const VERSAO = "V06.8"

Public Declare PtrSafe Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long _
      , ByVal szURL As String _
      , ByVal szFileName As String _
      , ByVal dwReserved As Long _
      , ByVal lpfnCB As Long) As Long

Public Sub DefineAreaConsultor()
    Dim URL As String, CaminhoLocal As String, DataArquivo As String
    
    If Dir("c:\InterRT\Outlook", vbDirectory) = vbNullString Then
        MkDir "c:\InterRT"
        MkDir "c:\InterRT\Outlook"
    End If
    
    CaminhoLocal = "c:\InterRT\Outlook\AreaConsultor.txt"
    
    If Dir(CaminhoLocal, vbArchive) = vbNullString Then
        
        strArea = ""
        
        Do
            strArea = LCase(InputBox("Informe sua Área (DBA, Infra ou Sistemas)"))
        Loop Until strArea = "dba" Or strArea = "infra" Or strArea = "sistemas"
                
        Open CaminhoLocal For Output As 1
            Print #1, strArea;
        Close #1

    End If
End Sub

Sub Cria_Botoes()
  Call RemoveToolbarButton("")
  Call AddToolbarButton("Responder a Todos", "Responder a Todos", "Projeto1.Responder_A_Todos", , 136, msoButtonIconAndCaption)
  Call AddToolbarButton("Responder Interno", "Responder Interno", "Projeto1.Responder_Interno", , 133, msoButtonIconAndCaption)
  Call AddToolbarButton("", " ", "_", , 0, msoButtonCaption)
  
  Call AddToolbarButton("Abrir Chamado", "Abrir Chamado", "Projeto1.Abrir_Chamado", , 23, msoButtonIconAndCaption)
  'Call AddToolbarButton("Assumir", "Assumir", "Projeto1.Assumir_Chamado", , 535, msoButtonIconAndCaption)
  Call AddToolbarButton("Iniciar", "Iniciar", "Projeto1.Iniciar", , 355, msoButtonIconAndCaption)
  Call AddToolbarButton("        ", "        ", "_", , 0, msoButtonCaption)
  
  Call AddToolbarButton("Status", "Status", "Projeto1.Status_Chamado", , 274, msoButtonIconAndCaption)
  Call AddToolbarButton("Status Interno", "Status Interno", "Projeto1.Status_Interno", , 1045, msoButtonIconAndCaption)
  Call AddToolbarButton("Solicitacao Cliente", "Solicitacao Cliente", "Projeto1.Solicitacao_Cliente", , 49, msoButtonIconAndCaption)
  
  Call AddToolbarButton("Alterar Dono", "Alterar Dono", "Projeto1.Alterar_Dono", , 607, msoButtonIconAndCaption)
  Call AddToolbarButton("Alterar Requisitante", "Alterar Requisitante", "Projeto1.Alterar_Requisitante", , 1086, msoButtonIconAndCaption)
  Call AddToolbarButton("Dependência", "Dependência", "Projeto1.Dependencia_Ticket", , 1667, msoButtonIconAndCaption)
  
  Call AddToolbarButton("Resolver", "Resolver", "Projeto1.Resolver", , 1087, msoButtonIconAndCaption)
  Call AddToolbarButton("Resolver Chamado Interno", "Resolver Chamado Interno", "Projeto1.Resolver_Interno", , 1087, msoButtonIconAndCaption)
  Call AddToolbarButton("Arquivar", "Arquivar", "Projeto1.Arquivado", , 225, msoButtonIconAndCaption)
    
  Call AddToolbarButton("Reabrir", "Reabrir", "Projeto1.Reabrir_Chamado", , 643, msoButtonIconAndCaption)
  Call AddToolbarButton("Deletar Ticket", "Deletar Ticket", "Projeto1.Deletar_Ticket", , 644, msoButtonIconAndCaption)
  Call AddToolbarButton("Mesclar Ticket", "Mesclar Ticket", "Projeto1.Mesclar_Ticket", , 694, msoButtonIconAndCaption)

  Call AddToolbarButton("Agendar", "Agendar", "Projeto1.Agendar", , 353, msoButtonIconAndCaption)
  Call AddToolbarButton("Agendar Reunião", "Agendar Reunião", "Projeto1.AgendarReuniao", , 362, msoButtonIconAndCaption)
  Call AddToolbarButton("Agendar Interno", "Agendar Interno", "Projeto1.Agendar_Interno", , 1672, msoButtonIconAndCaption)
    
  Call AddToolbarButton("Abrir Visita", "Abrir Visita", "Projeto1.Abrir_visita", , 2766, msoButtonIconAndCaption)
  Call AddToolbarButton("Fechar Visita", "Fechar Visita", "Projeto1.Fechar_visita", , 2767, msoButtonIconAndCaption)
  Call AddToolbarButton("   ", " ", "_", , 0, msoButtonCaption)
  
  Call AddToolbarButton("Abrir Plantao", "Abrir Plantao", "Projeto1.Abrir_Plantao", , 23, msoButtonIconAndCaption)
  Call AddToolbarButton("Fechar Plantao", "Fechar Plantao", "Projeto1.Fechar_Plantao", , 106, msoButtonIconAndCaption)
  Call AddToolbarButton(" ", " ", "_", , 0, msoButtonCaption)
    
  'Call AddToolbarButton("Cobranca Interna", "Cobranca Interna", "Projeto1.Cobranca_interna", , 352, msoButtonIconAndCaption)
  Call AddToolbarButton("Prazo Final", "Prazo Final", "Projeto1.Prazo_Final", , 583, msoButtonIconAndCaption)
  Call AddToolbarButton("Roteador", "Roteador", "Projeto1.Roteador", , 602, msoButtonIconAndCaption)
  Call AddToolbarButton("Manutenção DB", "Manutenção DB", "Projeto1.ManutencaoDB", , 642, msoButtonIconAndCaption)
  
  
End Sub

Function DefineAbrirChamado() As String
    Area = ""
    EnderecoCorporativo = ""
    
    Projeto1.FormAbrirChamado.Show
End Function

Function DefineHorarioAtendimento(strAcao) As String
    FormaAtendimento = ""
    DataInicial = ""
    DataFinal = ""
    HoraInicial = ""
    HoraFinal = ""
    
    If (strAcao = "SolicitacaoCliente") Then
        SolicitacaoCliente = "S"
    Else
        SolicitacaoCliente = ""
    End If
    
    Projeto1.FormHorarioAtendimento.Show
End Function

Function DefineArquivarResolver() As String
    FormaAtendimento = ""
    DataInicial = ""
    DataFinal = ""
    HoraInicial = ""
    HoraFinal = ""
    
    Projeto1.FormArquivarResolver.Show
End Function

Function DefineManutencaoDB() As String
    DesativarMonitoramento = ""
    
    Projeto1.FormManutencaoDB.Show
End Function

Function DefineIniciar() As String
    SolicitacaoCliente = ""
    
    Projeto1.FormIniciar.Show
End Function

Function DefineAgendamentoHorarioAtendimento() As String
    FormaAtendimento = ""
    DataInicial = ""
    DataFinal = ""
    HoraInicial = ""
    HoraFinal = ""
    DataAgendamento = ""
    HoraAgendamento = ""
    SolicitacaoCliente = ""

    Projeto1.FormAgendar.Show
End Function

Function DefineDependencia() As String
    strTicketDependencia = ""
    strRTticket = ""
    
    Projeto1.FormDependencia.Show
End Function

Function DefineStatusInterno() As String
    FormaAtendimento = ""
    DataInicial = ""
    DataFinal = ""
    HoraInicial = ""
    HoraFinal = ""
    DataAgendamento = ""
    HoraAgendamento = ""
    SolicitacaoCliente = ""
    EncerramentoAtividade = ""

    Projeto1.FormStatusInterno.Show
End Function


Function DefineFecharPlantao() As String
    DataInicial = ""
    DataFinal = ""
    HoraInicial = ""
    HoraFinal = ""
    Area = ""
    
    Projeto1.FormFecharPlantao.Show
End Function

Function DefineFecharVisita(strDataEntrada As String, strHoraEntrada As String) As String
    HoraFechamento = ""
    FormaAtendimento = ""
    DataEntrada = strDataEntrada
    HoraEntrada = strHoraEntrada
        
    Projeto1.FormFecharVisita.Show
End Function

Function DefineAbrirVisita() As String
    EnderecoCorporativo = ""
    FormaAtendimento = ""
    Area = ""
    DataEntrada = ""
    HoraEntrada = ""
    Justificativa = ""
    
    Projeto1.FormAbrirVisita.Show
End Function

Function DefineAbrirPlantao() As String
    EnderecoCorporativo = ""
    FormaAtendimento = ""
    Area = ""
    
    Projeto1.FormAbrirPlantao.Show
End Function

Function DefinePrazoFinal() As String
    DataAgendamento = ""
    HoraAgendamento = ""

    Projeto1.FormPrazoFinal.Show
End Function

Function DefineCobranca() As String
    EnderecoConsultor = ""
    EnderecoCorporativo = ""
    Area = ""

    Projeto1.FormCobranca.Show
End Function

Function DefineRoteador(strTipoAtendimento) As String
    TipoAtendimento = strTipoAtendimento
    Area = ""
    
    Projeto1.FormRoteador.Show
End Function

Function chamadoInterno(Assunto) As Boolean
        chamadoInterno = False
        With CreateObject("vbscript.regexp")
                .Pattern = ".*\[{1}.*interno #{1}.*\]{1}.*$"
                If Not .test(Assunto) Then
                        chamadoInterno = False
                Else
                        chamadoInterno = True
                End If
        End With
End Function

Function chamadoRecorrencia(Assunto) As Boolean
        Dim fila As String
        
        fila = chamadoFila(Assunto)
        chamadoRecorrencia = False
        
        If fila = "recorrencia" Then
            chamadoRecorrencia = True
        Else
            chamadoRecorrencia = False
        End If
        
End Function

Function chamadoFila(Assunto) As String
        Dim inicio As Integer
        Dim fim As Integer
        
        chamadoFila = ""
        
        inicio = InStr(Assunto, "[")
        fim = InStr(Assunto, "#")
        
        chamadoFila = Trim(Mid(Assunto, inicio + 1, fim - inicio - 2))
End Function

Function chamadoFilaCorporativo(Assunto) As String
        Dim fila As String
        
        chamadoFilaCorporativo = ""
        
        fila = chamadoFila(Assunto)
        
        If UCase(fila) = "IS" Or UCase(fila) = "GENERAL" Then
            chamadoFilaCorporativo = "suporte@intersolution.com.br"
        Else
            chamadoFilaCorporativo = fila & "@intersolution.com.br"
        End If
        
End Function

Function chamadoAberto(Assunto) As Boolean
        chamadoAberto = False
        With CreateObject("vbscript.regexp")
                .Pattern = ".*\[{1}.*#{1}.*\]{1}.*$"
                If Not .test(Assunto) Then
                        MsgBox "Ticket não encontrado no assunto do e-mail." & vbNewLine & "Verifique se esta respondendo a um e-mail de ticket.", vbExclamation
                Else
                        chamadoAberto = True
                End If
        End With
End Function

Function chamadoVisita(Assunto As String, ExibirMensagem As Boolean) As Boolean
        chamadoVisita = False
        Tipo = "Visita"
        With CreateObject("vbscript.regexp")
                .Pattern = ".*(Relatório Técnico){1}.*$"
                If Not .test(Assunto) Then
                        If ExibirMensagem Then
                                MsgBox "Assunto do e-mail não corresponde a " & Tipo & "." & vbNewLine & "Verifique se esta respondendo a um e-mail de " & Tipo, vbExclamation
                        End If
                Else
                        chamadoVisita = True
                End If
        End With
End Function

Function chamadoPlantao(Assunto As String, ExibirMensagem As Boolean) As Boolean
        chamadoPlantao = False
        Tipo = "Plantão"
        With CreateObject("vbscript.regexp")
                .Pattern = ".*(Relatório de Plantão){1}.*$"
                If Not .test(Assunto) Then
                        If ExibirMensagem Then
                                MsgBox "Assunto do e-mail não corresponde a " & Tipo & "." & vbNewLine & "Verifique se esta respondendo a um e-mail de " & Tipo, vbExclamation
                        End If
                Else
                        chamadoPlantao = True
                End If
        End With
End Function

Function chamadoNormal(Assunto As String, ExibirMensagem As Boolean) As Boolean
        chamadoNormal = False
        With CreateObject("vbscript.regexp")
                .Pattern = ".*(Relatório de Plantão){1}.*$"
                If Not .test(Assunto) Then
                        .Pattern = ".*(Relatório Técnico){1}.*$"
                        If Not .test(Assunto) Then
                                chamadoNormal = True
                        End If
                End If
        End With

        If Not chamadoNormal And ExibirMensagem Then
                MsgBox "Assunto do e-mail corresponde a Plantão ou Visita." & vbNewLine & "Verifique se esta respondendo a um e-mail de Chamado.", vbExclamation
        End If
End Function

Function chamadoNormalPlantao(Assunto As String, ExibirMensagem As Boolean) As Boolean
        chamadoNormalPlantao = False
        With CreateObject("vbscript.regexp")
                .Pattern = ".*(Relatório Técnico){1}.*$"
                If Not .test(Assunto) Then
                        chamadoNormalPlantao = True
                End If
        End With

        If Not chamadoNormalPlantao And ExibirMensagem Then
                MsgBox "Assunto do e-mail corresponde a uma Visita." & vbNewLine & "Verifique se esta respondendo um e-mail de Chamado ou Plantão.", vbExclamation
        End If
End Function

Function chamadoNormalPlantaoVisita(Assunto As String, ExibirMensagem As Boolean) As Boolean
        
        chamadoNormalPlantaoVisita = False
        
        With CreateObject("vbscript.regexp")
            .Pattern = ".*(Relatório de Plantão){1}.*$"
            If Not .test(Assunto) Then
                .Pattern = ".*(Relatório Técnico){1}.*$"
                If Not .test(Assunto) Then
                    .Pattern = ".*\[{1}.*#{1}.*\]{1}.*$"
                    If Not .test(Assunto) Then
                        chamadoNormalPlantaoVisita = False
                    Else
                        Tipo = "Chamado"
                        chamadoNormalPlantaoVisita = True
                    End If
                Else
                    Tipo = "Visita"
                    chamadoNormalPlantaoVisita = True
                End If
            Else
                Tipo = "Plantão"
                chamadoNormalPlantaoVisita = True
            End If
        End With

        If Not chamadoNormalPlantaoVisita And ExibirMensagem Then
            MsgBox "Assunto do e-mail não corresponde a um Plantão, Visita ou Chamado." & vbNewLine & "Verifique se esta respondendo um e-mail sem ticket.", vbExclamation
        End If
End Function

Function chamadoEmailEncerramento(Assunto As String, ExibirMensagem As Boolean) As Boolean
    chamadoEmailEncerramento = False
    With CreateObject("vbscript.regexp")
        .Pattern = ".*(Encerramento de Ticket){1}.*$"
        If Not .test(Assunto) Then
            chamadoEmailEncerramento = True
        End If
    End With

    If Not chamadoEmailEncerramento And ExibirMensagem Then
        MsgBox "Assunto do e-mail corresponde a um Encerramento de Ticket." & vbNewLine & "Verifique se esta respondendo o e-mail correto.", vbExclamation
    End If
End Function

Function ValidaTicket(EnviadoPor As String, ExibirMensagem As Boolean) As Boolean
    ValidaTicket = False
    
    With CreateObject("vbscript.regexp")
        .Pattern = ".*(Ticket){1}.*$"
        If Not .test(EnviadoPor) Then
            If ExibirMensagem Then
                MsgBox "Ticket não encontrado." & vbNewLine & "Verifique se esta roteando a um email do ticket.", vbExclamation
            End If
        Else
            ValidaTicket = True
        End If
    End With

End Function

Function ValidaTicketNormal(Assunto As String, ExibirMensagem As Boolean) As Boolean
    ValidaTicketNormal = False
    
    With CreateObject("vbscript.regexp")
        .Pattern = ".*(Relatório de Plantão){1}.*$"
        If Not .test(Assunto) Then
            .Pattern = ".*(Relatório Técnico){1}.*$"
            If Not .test(Assunto) Then
                ValidaTicketNormal = True
            End If
        End If
    End With

    If Not ValidaTicketNormal And ExibirMensagem Then
        MsgBox "Assunto do email corresponde a Plantão ou Visita." & vbNewLine & "Verifique se esta respondendo a um email de Chamado", vbExclamation
    End If
    
End Function

Function ValidaRemetente(EnviadoPor As String, ExibirMensagem As Boolean) As Boolean
    ValidaRemetente = False
    If (EnviadoPor <> Empty) Then
        With CreateObject("vbscript.regexp")
            .Pattern = ".*(Ticket InterSolution){1}.*$"
            If .test(EnviadoPor) Then
                If ExibirMensagem Then
                    MsgBox "Não é permitido responder um e-mail do remetente Ticket InterSolution.", vbExclamation
                End If
            Else
                ValidaRemetente = True
            End If
        End With
    Else
        ValidaRemetente = True
    End If

End Function

Function corrigeAssunto(Assunto) As String
    Dim inicio As Integer
    
    corrigeAssunto = Assunto
    
    inicio = InStr(Assunto, "[")
    
    If inicio > 20 Then
        corrigeAssunto = Trim(Mid(Assunto, inicio))
    End If
        
End Function

Function VerificaEnderecoEmail(objMsg As Object, EnderecoEmail As String, EnderecoEmailExibicao As String, ExibirMensagem As Boolean, Mensagem As String) As Boolean
    Dim objValida As Object
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor

    VerificaEnderecoEmail = False
    
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                  
    Set objValida = CreateObject("vbscript.regexp")
    objValida.Pattern = ".*(" & EnderecoEmail & "){1}.*$"
       
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaEnderecoEmail = True
            If (ExibirMensagem = True) Then
                If (Mensagem = Empty) Then
                    MsgBox "Não é permitido executar esta ação com o endereço de e-mail '" & EnderecoEmailExibicao & "' em cópia." & vbNewLine & "Verifique se está respondendo o e-mail correto. ", vbExclamation
                    Exit For
                Else
                    MsgBox Mensagem, vbExclamation
                End If
            End If
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If objValida.test(objMsg.SenderEmailAddress) Then
            VerificaEnderecoEmail = True
            If (ExibirMensagem = True) Then
                If (Mensagem = Empty) Then
                    MsgBox "Não é permitido executar esta ação com o endereço de e-mail '" & EnderecoEmailExibicao & "' em cópia." & vbNewLine & "Verifique se está respondendo o e-mail correto. ", vbExclamation
                Else
                    MsgBox Mensagem, vbExclamation
                End If
            End If
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaEnderecoEmail = True
            If (ExibirMensagem = True) Then
                If (Mensagem = Empty) Then
                    MsgBox "Não é permitido executar esta ação com o endereço de e-mail '" & EnderecoEmailExibicao & "' em cópia." & vbNewLine & "Verifique se está respondendo o e-mail correto. ", vbExclamation
                Else
                    MsgBox Mensagem, vbExclamation
                End If
            End If
        End If
    End If
    
End Function

Function VerificaEmailRTADM(objMsg As Object, ExibirMensagem As Boolean, Mensagem As String) As Boolean
    Dim objValida As Object
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor

    VerificaEmailRTADM = False
    
    ' Se for um ticket do RTADM nao fazemos a verificacao
    
    Set objValidaFila = CreateObject("vbscript.regexp")
    objValidaFila.Pattern = "\[is\..*"
    
    If objValidaFila.test(objMsg.Subject) Then
        Exit Function
    End If
    
    ' Valida emails do RT ADM
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                  
    Set objValida = CreateObject("vbscript.regexp")
    objValida.Pattern = "^(is\.){1}.*@intersolution.*$"
       
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaEmailRTADM = True
            If (ExibirMensagem = True) Then
                If (Mensagem = Empty) Then
                    MsgBox "Não é permitido executar esta ação com o endereço de e-mail '" & objPA.GetProperty(PR_SMTP_ADDRESS) & "' em cópia." & vbNewLine & vbNewLine & "Caso já tenha posicionado este chamado com '" & objPA.GetProperty(PR_SMTP_ADDRESS) & "' em cópia é necessário reenviar, pois foi ignorado pelo RT", vbExclamation
                    Exit For
                Else
                    MsgBox Mensagem, vbExclamation
                End If
            End If
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If objValida.test(objMsg.SenderEmailAddress) Then
            VerificaEmailRTADM = True
            If (ExibirMensagem = True) Then
                If (Mensagem = Empty) Then
                    MsgBox "Não é permitido executar esta ação com o endereço de e-mail '" & objPA.GetProperty(PR_SMTP_ADDRESS) & "' em cópia." & vbNewLine & vbNewLine & "Caso já tenha posicionado este chamado com '" & objPA.GetProperty(PR_SMTP_ADDRESS) & "' em cópia é necessário reenviar, pois foi ignorado pelo RT", vbExclamation
                Else
                    MsgBox Mensagem, vbExclamation
                End If
            End If
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaEmailRTADM = True
            If (ExibirMensagem = True) Then
                If (Mensagem = Empty) Then
                    MsgBox "Não é permitido executar esta ação com o endereço de e-mail '" & objPA.GetProperty(PR_SMTP_ADDRESS) & "' em cópia." & vbNewLine & vbNewLine & "Caso já tenha posicionado este chamado com '" & objPA.GetProperty(PR_SMTP_ADDRESS) & "' em cópia é necessário reenviar, pois foi ignorado pelo RT", vbExclamation
                Else
                    MsgBox Mensagem, vbExclamation
                End If
            End If
        End If
    End If
    
End Function

Function VerificaCopiaCorporativo(objMsg As Object) As Boolean
    Dim objValida As Object
    Dim objValidaSuporte As Object
    Dim fila As String
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor

    VerificaCopiaCorporativo = False
    
    ' Se for um ticket do RTADM nao fazemos a verificacao
    
    Set objValidaFila = CreateObject("vbscript.regexp")
    objValidaFila.Pattern = "\[is\..*"
    
    If objValidaFila.test(objMsg.Subject) Or chamadoInterno(objMsg.Subject) Then
        VerificaCopiaCorporativo = True
        Exit Function
    End If
    
    ' Valida se temos email corporativo em copia
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                  
    fila = chamadoFila(objMsg.Subject)
    
    Set objValida = CreateObject("vbscript.regexp")
    objValida.Pattern = "^" & fila & "@intersolution.*$"
    
    ' Valida se o Corporativo Padrao esta em copia
    Set objValidaSuporte = CreateObject("vbscript.regexp")
    objValidaSuporte.Pattern = "^suporte@intersolution.*$"
       
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If objValida.test(LCase(objPA.GetProperty(PR_SMTP_ADDRESS))) Or objValidaSuporte.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaCopiaCorporativo = True
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If objValida.test(LCase(objMsg.SenderEmailAddress)) Or objValidaSuporte.test(objMsg.SenderEmailAddress) Then
            VerificaCopiaCorporativo = True
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If objValida.test(LCase(objPA.GetProperty(PR_SMTP_ADDRESS))) Or objValidaSuporte.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaCopiaCorporativo = True
        End If
    End If
    
End Function

Function VerificaCopiaArea(objMsg As Object) As Boolean
    Dim objValidaArea1 As Object
    Dim objValidaArea2 As Object
    Dim objValidaArea3 As Object
    
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor

    VerificaCopiaArea = False
    
    ' Se for um ticket do RTADM nao fazemos a verificacao
    
    Set objValidaFila = CreateObject("vbscript.regexp")
    objValidaFila.Pattern = "\[is\..*"
    
    If objValidaFila.test(objMsg.Subject) Or chamadoInterno(objMsg.Subject) Or chamadoRecorrencia(objMsg.Subject) Then
        VerificaCopiaArea = True
        Exit Function
    End If
    
    
    ' Valida se temos email de area em copia
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
    
    Set objValidaArea1 = CreateObject("vbscript.regexp")
    objValidaArea1.Pattern = "^dba@intersolution.*$"
    
    Set objValidaArea2 = CreateObject("vbscript.regexp")
    objValidaArea2.Pattern = "^infra@intersolution.*$"
    
    Set objValidaArea3 = CreateObject("vbscript.regexp")
    objValidaArea3.Pattern = "^sistemas@intersolution.*$"
       
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If objValidaArea1.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Or objValidaArea2.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Or objValidaArea3.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaCopiaArea = True
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If objValidaArea1.test(objMsg.SenderEmailAddress) Or objValidaArea2.test(objMsg.SenderEmailAddress) Or objValidaArea3.test(objMsg.SenderEmailAddress) Then
            VerificaCopiaArea = True
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If objValidaArea1.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Or objValidaArea2.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Or objValidaArea3.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaCopiaArea = True
        End If
    End If
    
End Function


Function VerificaCopiaCliente(objMsg As Object) As Boolean
    Dim objValida As Object
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor

    VerificaCopiaCliente = False
    
    ' Se for um ticket do RTADM nao fazemos a verificacao
    
    Set objValidaFila = CreateObject("vbscript.regexp")
    objValidaFila.Pattern = "\[is\..*"
    
    If objValidaFila.test(objMsg.Subject) Or chamadoInterno(objMsg.Subject) Or chamadoRecorrencia(objMsg.Subject) Then
        VerificaCopiaCliente = True
        Exit Function
    End If
    
    
    ' Valida se temos email de cliente em copia
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                  
    Set objValida = CreateObject("vbscript.regexp")
    objValida.Pattern = "^.*@intersolution.*$"
       
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If Not objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaCopiaCliente = True
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If Not objValida.test(objMsg.SenderEmailAddress) Then
            VerificaCopiaCliente = True
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If Not objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            VerificaCopiaCliente = True
        End If
    End If
    
End Function

Function VerificaTextoEmail(objMsg As Object, Texto As String, ExibirMensagem) As Boolean
      
    VerificaTextoEmail = False

    If (InStr(objMsg.ReplyAll.HTMLBody, Texto) > 0) Then
        VerificaTextoEmail = True
        If (ExibirMensagem) Then
            MsgBox "Não é permitido executar esta ação num e-mail interno." & vbNewLine & "Verifique se está respondendo o e-mail correto. ", vbExclamation
        End If
    End If
    
End Function

Function EmailTo(objMsg As Object) As String
    Dim strTo As String
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor
    
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                  
    strTo = Empty
    
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If (objRecipient.Type = 1) Then
            If InStr(1, strTo, objPA.GetProperty(PR_SMTP_ADDRESS), vbTextCompare) <= 0 Then
                strTo = strTo & objPA.GetProperty(PR_SMTP_ADDRESS) & ";"
            End If
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If InStr(1, strTo, objMsg.SenderEmailAddress, vbTextCompare) <= 0 Then
            strTo = objMsg.SenderEmailAddress & ";" & strTo
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If InStr(1, strTo, objPA.GetProperty(PR_SMTP_ADDRESS), vbTextCompare) <= 0 Then
            strTo = objPA.GetProperty(PR_SMTP_ADDRESS) & ";" & strTo
        End If
    End If
    
    EmailTo = strTo
End Function

Function EmailToInterno(objMsg As Object) As String
    Dim objValida As Object
    Dim strTo As String
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor
    
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                  
    strTo = Empty
    
    Set objValida = CreateObject("vbscript.regexp")
    objValida.Pattern = ".*(@intersolution){1}.*$"
    
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            If (objRecipient.Type = 1) Then
                If InStr(1, strTo, objPA.GetProperty(PR_SMTP_ADDRESS), vbTextCompare) <= 0 Then
                    strTo = strTo & objPA.GetProperty(PR_SMTP_ADDRESS) & ";"
                End If
            End If
        End If
    Next
            
    If InStr(1, objMsg.SenderEmailAddress, "@", vbTextCompare) > 0 Then
        If objValida.test(objMsg.SenderEmailAddress) Then
            If InStr(1, strTo, objMsg.SenderEmailAddress, vbTextCompare) <= 0 Then
                strTo = objMsg.SenderEmailAddress & ";" & strTo
            End If
        End If
    Else
        Set objPA = objMsg.Sender.PropertyAccessor
    
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            If InStr(1, strTo, objPA.GetProperty(PR_SMTP_ADDRESS), vbTextCompare) <= 0 Then
                strTo = objPA.GetProperty(PR_SMTP_ADDRESS) & ";" & strTo
            End If
        End If
    End If
    
    EmailToInterno = strTo
End Function

Function EmailCC(objMsg As Object) As String
    Dim strCC As String
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor
    
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                   
    strCC = Empty
   
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor

        If (objRecipient.Type = 2) Then
            If InStr(1, strCC, objPA.GetProperty(PR_SMTP_ADDRESS), vbTextCompare) <= 0 Then
                strCC = strCC & objPA.GetProperty(PR_SMTP_ADDRESS) & ";"
            End If
        End If
    Next
    
    EmailCC = strCC
    
End Function

Function EmailCCInterno(objMsg As Object) As String
    Dim objValida As Object
    Dim strCC As String
    Dim objRecipient As Outlook.Recipient
    Dim objPA As Outlook.PropertyAccessor
    
    Const PR_SMTP_ADDRESS As String = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"
                   
    strCC = Empty

    Set objValida = CreateObject("vbscript.regexp")
    objValida.Pattern = ".*(@intersolution){1}.*$"
    
    For Each objRecipient In objMsg.Recipients
        Set objPA = objRecipient.PropertyAccessor
       
        If objValida.test(objPA.GetProperty(PR_SMTP_ADDRESS)) Then
            If (objRecipient.Type = 2) Then
                If InStr(1, strCC, objPA.GetProperty(PR_SMTP_ADDRESS), vbTextCompare) <= 0 Then
                    strCC = strCC & objPA.GetProperty(PR_SMTP_ADDRESS) & ";"
                End If
            End If
        End If
    Next
    
    EmailCCInterno = strCC
    
End Function

Function EmailInterno(Assunto) As String
    EmailInterno = ""
    
    With CreateObject("vbscript.regexp")
        .Pattern = ".*\[{1}.*is.interno #{1}.*\]{1}.*$"
        If .test(Assunto) Then
            EmailInterno = "is.interno@intersolution.com.br"
        Else
            With CreateObject("vbscript.regexp")
                .Pattern = ".*\[{1}.*interno #{1}.*\]{1}.*$"
                If .test(Assunto) Then
                    EmailInterno = "interno@intersolution.com.br"
                Else
                    EmailInterno = ""
                End If
            End With
        End If
    End With
End Function

Function UID(Subject_email As String) As String

hoje = Date & " " & Time
UID = Mid(Subject_email, InStr(1, Subject_email, "#"), InStr(1, Subject_email, "]") - InStr(1, Subject_email, "#")) & "_" & Mid(hoje, 9, 2) & Mid(hoje, 4, 2) & Mid(hoje, 1, 2) & Mid(hoje, 12, 2) & Mid(hoje, 15, 2) & Mid(hoje, 18, 2)

End Function

Function RemoveToolbarButton(Caption As String)
Dim objBar As Office.CommandBar
Dim objButton As Office.CommandBarControl

For Each objButton In ActiveExplorer.CommandBars("Standard").controls
  objButton.Delete
Next objButton
End Function

Function AddToolbarButton(Caption As String, _
                       toolTip As String, macroName As String, _
                       Optional toolbarName As String = "Standard", _
                       Optional FaceID As Long = 483, _
                       Optional buttonStyle As MsoButtonStyle = msoButtonAutomatic)
Dim objBar As Office.CommandBar
Dim objButton As Office.CommandBarButton
Dim objButtonControl As Office.CommandBarControl

For Each objButtonControl In ActiveExplorer.CommandBars("Standard").controls

If objButtonControl.Caption = Caption Then
  objButtonControl.Delete
End If
Next objButtonControl

  Set objBar = ActiveExplorer.CommandBars(toolbarName)
  Set objButton = objBar.controls.Add(msoControlButton)
 
  With objButton
    .Caption = Caption
    .OnAction = macroName
    .TooltipText = toolTip
    .FaceID = FaceID
    .Style = buttonStyle
    .BeginGroup = True
  End With
 
End Function

Sub Alterar_Requisitante()
     
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strRequestorName As String
    Dim strTo As String
    Dim strCC As String
     
    ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
     
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    Set MsgReply = Msg.ReplyAll
     
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", False, Empty) Then
        strTo = Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
        strCC = Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
    End If
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If strTo = Empty Then
        strTo = "coordenadores@intersolution.inf.br"
    End If
    
    On Error Resume Next
    
    strRequestorName = InputBox("E-mail do novo requisitante:")
    If strRequestorName = "" Then Exit Sub
    
    On Error GoTo 0
    
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
        & "Novo requisitante será: " & strRequestorName & " <br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::requisitante::" & UID(Msg.Subject) & "::<br />" _
        & "requisitante|" & strRequestorName & "|</span><br />" _
        & "==========================</span><br />" & .HTMLBody
        .Display
        SendKeys "{DOWN 6}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Status_Chamado()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
        
    ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    HabilitarSolicitacaoCliente = True
    
    DefineHorarioAtendimento ("Status")
            
    If (FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
        
    Set MsgReply = Msg.ReplyAll
     
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
            & "Prezado Cliente,<br /><br />" _
            & "Sua solicitação continua em andamento.<br />" _
            & "<br />" _
            & "-----------------------------------<br />" _
            & "Horário do atendimento: <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "-----------------------------------<br />" _
            & " <br />" _
            & "Informações importantes: <br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::status_cliente::" & UID(Msg.Subject) & "::<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br />" _
            & "solicitacao_cliente|" & SolicitacaoCliente & "|<br /></span>" _
            & "-----------------------------------</span><br />" _
            & .HTMLBody
        .Display
        SendKeys "{DOWN 20}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Arquivado()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormal(Msg.Subject, True) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    DefineArquivarResolver
    
    If (FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
                    
    Set MsgReply = Msg.ReplyAll
     
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
            & " Prezado Cliente, <br />" _
            & "<br />" _
            & " Este chamado está sendo arquivado, pois necessitamos de informações para sua continuidade.<br />" _
            & " Para reabrir o chamado, basta responder esse e-mail a todos.<br />" _
            & "<br />" _
            & "-----------------------------------<br />" _
            & "Horário do atendimento <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "-----------------------------------<br />" _
            & " <br />" _
            & " Informações adicionais:<br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::arquivar::" & UID(Msg.Subject) & "::<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br /></span>" _
            & "-----------------------------------</span><br>" _
            & "</span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 20}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Solicitacao_Cliente()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantaoVisita(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) And Not chamadoVisita(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    DefineHorarioAtendimento ("SolicitacaoCliente")
    
    If (FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
    
    Set MsgReply = Msg.ReplyAll
     
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                    & "Prezado Cliente,<br /><br />" _
                    & "Para darmos continuidade em sua solicitação precisaremos das informações abaixo.<br />" _
                    & "Aguardamos retorno.<br />" _
                    & "<br />" _
                    & "-----------------------------------<br />" _
                    & "Horário do atendimento <br />" _
                    & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
                    & "-----------------------------------<br />" _
                    & "<br />" _
                    & "Informações necessárias:<br />" _
                    & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
                    & "::chamado::waiting_customer::" & UID(Msg.Subject) & "::<br />" _
                    & "forma_atendimento|" & FormaAtendimento & "|<br />" _
                    & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
                    & "hora_inicial|" & HoraInicial & "|<br />" _
                    & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
                    & "hora_final|" & HoraFinal & "|<br />" _
                    & "solicitacao_cliente|" & SolicitacaoCliente & "|<br /></span>" _
                    & "-----------------------------------</span><br />" _
                    & .HTMLBody
        .Display
        SendKeys "{DOWN 21}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Agendar()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim objMailMessage As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    ExibeRecorrencia = chamadoRecorrencia(Msg.Subject)
    
    HabilitarSolicitacaoCliente = True
    
    DefineAgendamentoHorarioAtendimento
                
    If (DataAgendamento = Empty Or HoraAgendamento = Empty Or FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
        
    Set MsgReply = Msg.ReplyAll
        
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
            & "Prezado Cliente, <br /> <br />" _
            & "Sua atividade está agendada conforme informações abaixo.<br />" _
            & "Por favor, nos envie telefone e e-mail do responsável para eventuais dúvidas.<br /> <br />" _
            & "Agendamento:<br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::agendado::" & UID(Msg.Subject) & "::<br />" _
            & "data_agendamento|" & DataAgendamento & "|<br />" _
            & "hora_agendamento|" & HoraAgendamento & "|<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br />ticket_recorrencia|" & TicketRecorrencia & "|<br />" _
            & "solicitacao_cliente|" & SolicitacaoCliente & "|<br /></span>" _
            & "-----------------------------------------------------------------<br />" _
            & "Data: " & DataAgendamento & "<br />" _
            & "Horário: " & HoraAgendamento & "<br /><br />" _
            & "-----------------------------------<br />" _
            & "Horário do atendimento <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "-----------------------------------<br /> <br />" _
            & "Informações importantes:<br />" _
            & "-----------------------------------</span><br></span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 29}"
    End With
        
    'Cancela agendamento do mesmo ticket
    Dim oCalendar As Outlook.Folder
    Dim oItems As Outlook.Items
    Dim oItemsInDateRange As Outlook.Items
    Dim oFinalItems As Outlook.Items
    Dim oAppt As Outlook.AppointmentItem
    Dim strRestriction As String
    Dim bolAtualizado As Boolean
         
    'Cria pesquisa da data atual até 90 dias
    strRestriction = "[Start] >= '" & _
                     Format$(Now, "dd/mm/yyyy hh:mm") _
                     & "' AND [End] <= '" & _
                     Format$(DateAdd("d", 120, Now), "dd/mm/yyyy hh:mm") & "'"
                    
    Debug.Print strRestriction
    Set oCalendar = Application.Session.GetDefaultFolder(olFolderCalendar)
    Set oItems = oCalendar.Items
    oItems.IncludeRecurrences = True
    oItems.Sort "[Start]"
    
    Set oItemsInDateRange = oItems.Restrict(strRestriction)
    
    If (InStr(1, Msg.Subject, "'") > 0) Then
        strAssunto = Mid(Msg.Subject, 1, InStr(1, Msg.Subject, "'") - 1)
    Else
        strAssunto = Msg.Subject
    End If
    
    'Cria pesquisa com o titulo do e-mail
    Const PropTag  As String = "http://schemas.microsoft.com/mapi/proptag/"
    strRestriction = "@SQL=" & Chr(34) & PropTag _
        & "0x0037001E" & Chr(34) & " like '%" & strAssunto & "%'"
    
    Set oFinalItems = oItemsInDateRange.Restrict(strRestriction)
    
    'Pesquisa compromissos
    oFinalItems.Sort "[Start]"
    
    Count = 0
    
    'Cancela os compromissos agendados
    For Each oAppt In oFinalItems
        If (Count = 0) Then
            oAppt.Start = DataAgendamento & " " & HoraAgendamento
            oAppt.Duration = 30
            oAppt.ReminderSet = True
            oAppt.Send
            
            bolAtualizado = True
        Else
            oAppt.Delete
        End If
        
        Count = Count + 1
    Next
        
    If (bolAtualizado = False) Then
        'Cria compromisso na agenda do outlook
        Dim myItem As Object
        Dim myRequiredAttendee, myOptionalAttendee As Outlook.Recipient
  
        Set myItem = Application.CreateItem(olAppointmentItem)
        myItem.MeetingStatus = olMeeting
        myItem.Subject = Msg.Subject
        myItem.Location = "InterSolution"
        myItem.Start = DataAgendamento & " " & HoraAgendamento
        myItem.Duration = 30
        myItem.ReminderSet = True
                myItem.Location = ""
   
        Set myRequiredAttendee = myItem.Recipients.Add(Msg.SendUsingAccount.SmtpAddress)
        myRequiredAttendee.Type = olRequired

        myItem.Send
    End If
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
    Set strTicket = Nothing
    Set objMailMessage = Nothing
End Sub

Sub AgendarReuniao()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim objMailMessage As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
        
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    ExibeRecorrencia = False
    
    HabilitarSolicitacaoCliente = True
    
    DefineAgendamentoHorarioAtendimento
                
    If (DataAgendamento = Empty Or HoraAgendamento = Empty Or FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
        
    Set MsgReply = Msg.ReplyAll
        
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "-------------------<span style=""font-size : 6pt"">" & VERSAO & "</span>------------------<br>" _
            & "Prezado Cliente, <br /> <br />" _
            & "Segue agendamento de nossa reunião.<br /><br />" _
            & "Agendamento:<br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::agendado::" & UID(Msg.Subject) & "::<br />" _
            & "data_agendamento|" & DataAgendamento & "|<br />" _
            & "hora_agendamento|" & HoraAgendamento & "|<br />" _
            & "tipo_agendamento|reuniao|<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br />" _
            & "solicitacao_cliente|" & SolicitacaoCliente & "|<br /></span>" _
            & "-----------------------------------------<br />" _
            & "Data: " & DataAgendamento & "<br />" _
            & "Horário: " & HoraAgendamento & "<br /><br />" _
            & "-----------------------------------------<br />" _
            & "Horário do atendimento <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "-----------------------------------------<br /> <br />" _
            & "Informações importantes:<br />" _
            & "-----------------------------------------</span><br></span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 28}"
    End With
        
    'Cancela agendamento do mesmo ticket
    Dim oCalendar As Outlook.Folder
    Dim oItems As Outlook.Items
    Dim oItemsInDateRange As Outlook.Items
    Dim oFinalItems As Outlook.Items
    Dim oAppt As Outlook.AppointmentItem
    Dim strRestriction As String
    Dim bolAtualizado As Boolean
         
    'Cria pesquisa da data atual até 90 dias
    strRestriction = "[Start] >= '" & _
                     Format$(Now, "dd/mm/yyyy hh:mm") _
                     & "' AND [End] <= '" & _
                     Format$(DateAdd("d", 120, Now), "dd/mm/yyyy hh:mm") & "'"
                    
    Debug.Print strRestriction
    Set oCalendar = Application.Session.GetDefaultFolder(olFolderCalendar)
    Set oItems = oCalendar.Items
    oItems.IncludeRecurrences = True
    oItems.Sort "[Start]"
    
    Set oItemsInDateRange = oItems.Restrict(strRestriction)
    
    If (InStr(1, Msg.Subject, "'") > 0) Then
        strAssunto = "Reunião - " + Replace(Mid(Msg.Subject, 1, InStr(1, Msg.Subject, "'") - 1), "RES:", "")
    Else
        strAssunto = "Reunião - " + Replace(Msg.Subject, "RES:", "")
    End If
    
    'Cria pesquisa com o titulo do e-mail
    Const PropTag  As String = "http://schemas.microsoft.com/mapi/proptag/"
    strRestriction = "@SQL=" & Chr(34) & PropTag _
        & "0x0037001E" & Chr(34) & " like '%" & strAssunto & "%'"
    
    Set oFinalItems = oItemsInDateRange.Restrict(strRestriction)
    
    'Pesquisa compromissos
    oFinalItems.Sort "[Start]"
    
    Count = 0
    
    'Cancela os compromissos agendados
    For Each oAppt In oFinalItems
        If (Count = 0) Then
            oAppt.Start = DataAgendamento & " " & HoraAgendamento
            oAppt.Duration = 60
            oAppt.ReminderSet = True
            oAppt.Display
            
            bolAtualizado = True
        Else
            oAppt.Delete
        End If
        
        Count = Count + 1
    Next
               
        
    If (bolAtualizado = False) Then
        'Cria compromisso na agenda do outlook
        Dim myItem As Object
        Dim myRequiredAttendee, myOptionalAttendee As Outlook.Recipient
        Dim strContatos
        
        strContatos = Replace(Replace(Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", ""), "ticket@intersolution.inf.br", ""), "ticket@intersolution.com.br", "")
        
        strContatos = strContatos + ";" + Replace(Replace(Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", ""), "ticket@intersolution.inf.br", ""), "ticket@intersolution.com.br", "")
  
        Set myItem = Application.CreateItem(olAppointmentItem)
        myItem.MeetingStatus = olMeeting
        myItem.Subject = strAssunto
        myItem.Start = DataAgendamento & " " & HoraAgendamento
        myItem.Duration = 60
        myItem.ReminderSet = True
     
        Set myRequiredAttendee = myItem.Recipients.Add(strContatos)
       
        myRequiredAttendee.Type = olRequired

        myItem.Display
    End If
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
    Set strTicket = Nothing
    Set objMailMessage = Nothing
End Sub

Sub Prazo_Final()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
  
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
            
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    DefinePrazoFinal
                    
    If DataAgendamento = Empty Or HoraAgendamento = Empty Then Exit Sub
    
    Set MsgReply = Msg.ReplyAll
    
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
        & "Prezado Cliente, <br />" _
        & "<br />" _
        & "A previsão de conclusão para este atendimento é:<br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::prazo_final::" & UID(Msg.Subject) & "::<br />" _
        & "data_prazo|" & Replace(DataAgendamento, "/", "-") & "|<br />" _
        & "hora_prazo|" & HoraAgendamento & "|<br /></span>" _
        & "-----------------------------------------------------------------<br />" _
        & "Data: " & DataAgendamento & "<br />" _
        & "Horário: " & HoraAgendamento & "<br />" _
        & "<br />" _
        & "Informações importantes:<br />" _
        & "-----------------------------------</span><br />" & .HTMLBody
        .Display
        SendKeys "{DOWN 14}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Iniciar()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
   
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    DefineIniciar
    
    If SolicitacaoCliente = "" Then Exit Sub
        
    Set MsgReply = Msg.ReplyAll
    
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                    & "Prezado Cliente, <br /><br />" _
                    & "Estou iniciando a sua solicitação.<br /><br />" _
                    & "Informações importantes:<br /> " _
                    & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
                    & "::chamado::iniciar::" & UID(Msg.Subject) & "::<br />" _
                    & "solicitacao_cliente|" & SolicitacaoCliente & "|<br /></span>" _
                    & "-----------------------------------</span><br />" & .HTMLBody
        .Display
        
        SendKeys "{DOWN 10}"
    End With

ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Responder_Interno()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
        
    If Msg Is Nothing Then GoTo ExitProc
        
    Set MsgReply = Msg.Reply

    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If (strTo = Empty) Then
        If (chamadoAberto(Msg.Subject) = False) Then
            strTo = "naoabrir@intersolution.com.br"
        Else
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = "naoabrir@intersolution.com.br"
        End If
    End If
    
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
        
    With MsgReply
        .To = strTo
        .CC = strCC
        If (InStr(1, strTo, "naoabrir@intersolution.com.br", vbTextCompare) <= 0 And InStr(1, strCC, "naoabrir@intersolution.com.br", vbTextCompare) <= 0) And chamadoInterno(Msg.Subject) = False Then
            .Recipients.Add ("naoabrir@intersolution.com.br")
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
        & "</span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 1}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Cobranca_Interna()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
        
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    DefineCobranca
    
    If EnderecoConsultor = "" Or EnderecoCorporativo = "" Or Area = "" Then Exit Sub
        
    Set MsgReply = Msg.Reply

    With MsgReply
        .To = LCase(Area) & "@intersolution.com.br"
        .Recipients.Add (LCase(EnderecoCorporativo) & "@intersolution.com.br")
        .Recipients.Add (LCase(EnderecoConsultor) & "@intersolution.com.br")
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::cobranca_interna::" & UID(Msg.Subject) & "::<br /></span>" _
        & "========= INTERNO - COBRANCA ==============<br />" _
        & "Esta notificação é registrada e será utilizada em sua avaliação.<br />" _
        & "======================================<br />" _
        & "</span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 5}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Deletar_Ticket()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
    
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoEmailEncerramento(Msg.Subject, True) Then Exit Sub
        
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEnderecoEmail(Msg, "abrir.chamado@intersolution", "Abrir Chamado", True, "Não é permitido deletar o ticket de erro crítico.") Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If strTo = Empty Then
        strTo = "coordenadores@intersolution.inf.br"
    End If
    
    Set MsgReply = Msg.Reply

    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "========= INTERNO " & VERSAO & " =============<br />" _
        & "Prezados, <br />" _
        & "Estou deletando este ticket.<br />" _
        & "<br />" _
        & "Descreva o motivo da exclusão do ticket:<br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::deletar_ticket::" & UID(Msg.Subject) & "::<br /></span>" _
        & "===============================<br />" _
        & "</span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 8}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Mesclar_Ticket()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    Dim Mensagem As String
    
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
    
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormal(Msg.Subject, True) Then Exit Sub
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEnderecoEmail(Msg, "abrir.chamado@intersolution", "Abrir Chamado", True, "Não é permitido mesclar o ticket de erro crítico.") Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    With CreateObject("vbscript.regexp")
        .Pattern = "[0-9]"
        Do
            If ClienteEmCopia Then
                Mensagem = "Insira número do ticket a ser continuado"
            Else
                Mensagem = "Insira número do ticket a ser continuado" & vbNewLine & vbNewLine & "(Considere incluir o cliente caso este chamado não seja interno)"
            End If
            
            strTicket = InputBox(Mensagem)
            
            If StrPtr(strTicket) = 0 Then Exit Sub
                        
            If strTicket = "" Then
                MsgBox "É obrigatório informar o número do ticket.", vbExclamation
            ElseIf Not .test(strTicket) Then
                MsgBox "Número do ticket incorreto.", vbExclamation
            ElseIf Int(strTicket) > Int(Mid(Msg.Subject, InStr(1, Msg.Subject, "#") + 1, InStr(1, Msg.Subject, "]") - InStr(1, Msg.Subject, "#") - 1)) Then
                MsgBox "O número do ticket informado deve ser menor que o ticket atual.", vbExclamation
                strTicket = ""
            End If
        Loop Until .test(strTicket)
    End With
        
    Set MsgReply = Msg.ReplyAll
    
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
        & "Prezados, <br /><br />" _
        & "Estamos transferindo as informações para o atendimento com ticket #" & strTicket & ".<br />" _
        & "Este e-mail não deverá ser respondido, pois novos conteúdos serão desconsiderados.<br />" _
        & "<br />" _
        & "Informações:<br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::mesclar_ticket::" & UID(Msg.Subject) & "::<br />" _
        & "mesclar_ticket|" & strTicket & "|<br /></span>" _
        & "-----------------------------------</span><br>" _
        & .HTMLBody
        .Display
        SendKeys "{DOWN 11}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Abrir_Visita()
    Dim objOutlook As Object
    Dim objMailMessage As Outlook.MailItem
        
    DefineAbrirVisita
           
    If EnderecoCorporativo = "" Or Tipo = "" Or Area = "" Or HoraEntrada = "" Then Exit Sub
    
    Set objOutlook = CreateObject("Outlook.Application")
    Set objMailMessage = objOutlook.CreateItem(0)
    
    With objMailMessage
        .Recipients.Add (LCase(Area) & "@intersolution.com.br")
        .Recipients.Add (LCase(EnderecoCorporativo) & "@intersolution.com.br")
        .Subject = EnderecoCorporativo & " Relatório Técnico " & Tipo & " em " & Replace(DataEntrada, "/", "-")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                & "Prezado Cliente, <br />" _
                & "<br />" _
                & "Hoje a InterSolution está executando a manutenção preventiva periódica em seu ambiente.<br />" _
                & "Você receberá um e-mail com um ticket de controle para facilitar seu acompanhamento.<br />" _
                & "Ao fim das atividades você receberá o seu relatório com informações de seu ambiente.<br />" _
                & "<span style=""font-family : verdana;font-size : 1pt; color:white"">" _
                & "area|" & Area & "|<br />" _
                & "data_entrada|" & Replace(DataEntrada, "/", "-") & "|<br />" _
                & "hora_entrada|" & HoraEntrada & "|<br />" _
                & "justificativa|" & Justificativa & "|<br /></span>" _
                & "-----------------------------------<br /></span><br>" _
                & " " & Justificativa & "<br />" _
                & .HTMLBody
        .Display
        SendKeys "{DOWN 17}"
    End With
End Sub

Sub Fechar_Visita()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim MsgReplyJust As Outlook.MailItem
     On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
        
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoVisita(Msg.Subject, True) Then Exit Sub
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
            
    Set MsgReply = Msg.ReplyAll
    
    strRetorno = DefineFecharVisita(Replace(Mid(MsgReply.HTMLBody, InStr(1, MsgReply.HTMLBody, "data_entrada|", vbTextCompare) + 13, 10), "-", "/"), Mid(MsgReply.HTMLBody, InStr(1, MsgReply.HTMLBody, "hora_entrada|", vbTextCompare) + 13, 5))
    
    If (FormaAtendimento = Empty Or HoraFechamento = Empty) Then GoTo ExitProc
    
    If (JustificativaDataVisita <> Empty) Then
        Set MsgReplyJust = Msg.ReplyAll

        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    
        With MsgReplyJust
            .To = strTo
            .CC = strCC
            If (InStr(1, strTo, "naoabrir@intersolution.com.br", vbTextCompare) <= 0 And InStr(1, strCC, "naoabrir@intersolution.com.br", vbTextCompare) <= 0) Then
                .Recipients.Add ("naoabrir@intersolution.com.br")
            End If
            .Subject = corrigeAssunto(Msg.Subject)
            .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
            .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
            & "Abertura da visita com data anterior a data atual.<br /><br />" _
            & "Justificativa: " & JustificativaDataVisita & "<br />" _
            & "===============================<br />" _
            & "</span>" & .HTMLBody
            .Send
        End With
       
    End If
    
    With MsgReply
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = Replace(.HTMLBody, "::tempo::", "__tempo__")
        .HTMLBody = Replace(.HTMLBody, "::tipo::", "__tipo__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                    & "Prezado Cliente, <br /> " _
                    & " <br />" _
                    & "Estou encerrando a manutenção preventiva periódica em seu ambiente. <br />" _
                    & "Leia o relatório com as informações e qualquer dúvida estou à disposição para esclarecimentos. <br />" _
                    & "Segue relatório em anexo e informações importantes abaixo no corpo do e-mail.<br />" _
                    & " <br />" _
                    & "Informações importantes: <br />" _
                    & "----------------------------------------<br />" _
                    & "Horário de fechamento: " & HoraFechamento & " <br />" _
                    & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
                    & "::chamado::fechar_visita::" & UID(Msg.Subject) & "::<br />" _
                    & "data_entrada|" & Replace(DataEntrada, "/", "-") & "|<br />" _
                    & "hora_fechamento|" & HoraFechamento & "|<br />" _
                    & "forma_atendimento|" & FormaAtendimento & "|<br />" _
                    & "versao|" & VERSAO & "|<br />" _
                    & "</span>" _
                    & "----------------------------------------</span><br>" _
                    & "</span>" _
                    & .HTMLBody
                    .Display
                    SendKeys "{DOWN 17}"
                    
    End With
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub
    
Sub Abrir_Plantao()
    Dim objOutlook As Object
    Dim objMailMessage As Outlook.MailItem
    Dim strDate As String
        
    DefineAbrirPlantao
           
    If EnderecoCorporativo = "" Or Tipo = "" Or Area = "" Then Exit Sub
    
    strDate = Format(Now, "dd-mm-yyyy")
        
    Set objOutlook = CreateObject("Outlook.Application")
    Set objMailMessage = objOutlook.CreateItem(0)
    
    With objMailMessage
        .Recipients.Add (LCase(Area) & "@intersolution.com.br")
        .Recipients.Add (EnderecoCorporativo & "@intersolution.com.br")
        .Subject = "Relatório de Plantão " & Tipo & " em " & strDate
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>------------------<br>" _
                & "Prezado Cliente, <br />" _
                & "<br />" _
                & "Estamos registrando o acionamento de Plantão 24x7.<br />" _
                & "Você receberá um e-mail com um ticket de controle para facilitar seu acompanhamento.<br />" _
                & "O ticket gerado será encerrado com relatório de atendimento.<br />" _
                & " <br />" _
                & "Informações importantes: <br />" _
                & "-----------------------------------<br />" _
                & "<br /><br /></span><br />" & .HTMLBody
        .Display
        SendKeys "{DOWN 15}"
    End With
    
End Sub

Sub Fechar_Plantao()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
     On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
    
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, True) Then Exit Sub
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
        
    DefineFecharPlantao
    
    If (FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty Or Area = Empty) Then GoTo ExitProc

    Set MsgReply = Msg.ReplyAll
            
    With MsgReply
        .CC = .CC & "; " & LCase(Area) & "@intersolution.com.br"
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = Replace(.HTMLBody, "::area::", "__area__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
            & "Prezado cliente, <br /> " _
            & " <br />" _
            & " Estou encerrando o atendimento de plantão. <br />" _
            & " Leia o relatório com as informações e qualquer dúvida estou à disposição para esclarecimentos. <br />" _
            & " Segue relatório em anexo e informações importantes abaixo no corpo do e-mail.<br />" _
            & " <br />" _
            & "-----------------------------------<br />" _
            & "Horário do atendimento: <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "-----------------------------------<br />" _
            & " <br />" _
            & " Informações importantes: <br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::plantao::" & UID(Msg.Subject) & "::<br />" _
            & "area|" & Area & "|<br /> " _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br /></span>" _
            & "-----------------------------------</span><br>" _
            & "</span>" & .HTMLBody
            .Display
            SendKeys "{DOWN 22}"
                    
    End With
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Responder_A_Todos()
    Dim strTo As String
    Dim strCC As String
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
     On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
    
    If Msg Is Nothing Then GoTo ExitProc
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    Set MsgReply = Msg.ReplyAll
    
    If (InStr(MsgReply.SendUsingAccount.DisplayName, "is.adm@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.adm #")) Then
        strTituloEmail = " Administrativo InterSolution "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "comercial@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.comercial #")) Then
        strTituloEmail = " Comercial InterSolution "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "diretoria@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.diretoria #")) Then
        strTituloEmail = " Diretoria InterSolution "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "financeiro@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.financeiro #")) Then
        strTituloEmail = " Financeiro InterSolution "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "juridico@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.juridico #")) Then
        strTituloEmail = " Jurídico InterSolution "
    Else
        strTituloEmail = " Suporte InterSolution "
    End If
    
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                    & strTituloEmail & " <br />" _
                    & "-----------------------------------</span><br>" _
                    & .HTMLBody
        .Display
        SendKeys "{DOWN 3}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Reabrir_chamado()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
    
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    Set MsgReply = Msg.ReplyAll
        
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                    & "Prezado Cliente, <br />" _
                    & "<br />" _
                    & "Estou reabrindo seu chamado.<br />" _
                    & "<br />" _
                    & "Informações adicionais: <br />" _
                    & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
                    & "::chamado::reabrir::" & UID(Msg.Subject) & "::<br /></span>" _
                    & "-----------------------------------</span><br>" _
                    & .HTMLBody
        .Display
        SendKeys "{DOWN 9}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Abrir_chamado()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
   
    If Msg Is Nothing Then GoTo ExitProc
        
    If chamadoNormalPlantaoVisita(Msg.Subject, False) Then
        MsgBox "Assunto do e-mail corresponde a um Plantão, Visita ou Chamado." & vbNewLine & "Verifique se esta respondendo um e-mail sem ticket.", vbExclamation
        Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
        
    DefineAbrirChamado
        
    If EnderecoCorporativo = "" Or Area = "" Then Exit Sub
    
    Set MsgReply = Msg.ReplyAll
    
    If (InStr(MsgReply.SendUsingAccount.DisplayName, "is.adm@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.adm #")) Then
        strTituloEmail = " Departamento Administrativo. "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "comercial@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.comercial #")) Then
        strTituloEmail = " Departamento Comercial. "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "diretoria@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.diretoria #")) Then
        strTituloEmail = " Diretoria. "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "financeiro@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.financeiro #")) Then
        strTituloEmail = " Departamento Financeiro. "
    ElseIf (InStr(MsgReply.SendUsingAccount.DisplayName, "juridico@intersolution") > 0 Or InStr(MsgReply.Subject, "[is.juridico #")) Then
        strTituloEmail = " Departamento Jurídico. "
    Else
        strTituloEmail = " Equipe de suporte. "
    End If
        
    With MsgReply
        .Recipients.Add (LCase(Area) & "@intersolution.com.br")
        .Recipients.Add (LCase(EnderecoCorporativo) & "@intersolution.com.br")
        .Subject = .Subject
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
                    & "Prezado Cliente,<br />" _
                    & "<br />" _
                    & "Você receberá automaticamente uma nova mensagem de e-mail com um ticket de controle no assunto para seu chamado.<br />" _
                    & "Qualquer informação ou solicitação deverá ser respondida a todos por essa nova mensagem. <br />" _
                    & "Por favor, sempre envie solicitações ao endereço e-mail <b> " & EnderecoCorporativo & "@intersolution.com.br  </b> e não diretamente ao consultor. <br />" _
                    & "<br />" _
                    & strTituloEmail & " <br /> " _
                    & "-----------------------------------</span><br />" & .HTMLBody
        .Display
        SendKeys "{DOWN 9}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Resolver_Interno()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strHoraNormal As String
    Dim strHoraExtra As String
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
   
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormal(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
        
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    ' Esconde mensagem de cliente em copia, pois estamos num chamado interno
    ClienteEmCopia = True
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    DefineArquivarResolver
           
    If (HoraInicial = Empty Or HoraFinal = Empty And FormaAtendimento = Empty) Then Exit Sub
                  
    Set MsgReply = Msg.ReplyAll
     
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", False, Empty) Then
        strTo = Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
        strCC = Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
    End If
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
     
    If strTo = Empty Then
        strTo = "coordenadores@intersolution.inf.br"
    End If
    
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "========= <span style=""font-size : 1pt"">.</span>INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
        & "Prezado, <br />" _
        & " <br />" _
        & "Sua solicitação foi concluída. <br />" _
        & "Por favor, faça os testes necessários e qualquer problema ou necessidade basta responder a todos neste mesmo e-mail solicitando a reabertura. <br />" _
        & "Segue relatório em anexo ou informações abaixo  no corpo do e-mail.<br />" _
        & " <br />" _
        & "==========================<br />" _
        & "Horário do atendimento: <br />" _
        & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
        & "==========================<br />" _
        & " <br />" _
        & "Informações importantes: <br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::resolved_interno::" & UID(Msg.Subject) & "::<br />" _
        & "forma_atendimento|" & FormaAtendimento & "|<br />" _
        & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
        & "hora_inicial|" & HoraInicial & "|<br />" _
        & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
        & "hora_final|" & HoraFinal & "|<br /></span>" _
        & "==========================</span><br />" _
        & "</span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 21}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Resolver()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
    ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
   
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormal(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
        
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTo = EmailToInterno(Msg)
        strCC = EmailCCInterno(Msg)
        
        If strTo = Empty Then
            strTo = EmailInterno(Msg.Subject)
        End If
        
        ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
        If (strTo = Empty) Then
            strTo = chamadoFilaCorporativo(Msg.Subject)
        End If
    Else
        strTo = EmailTo(Msg)
        strCC = EmailCC(Msg)
        If VerificaTextoEmail(Msg, "== INTERNO ", True) Then Exit Sub
    End If
    
    ClienteEmCopia = VerificaCopiaCliente(Msg)
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)

    DefineArquivarResolver
    
    If (FormaAtendimento = Empty Or HoraInicial = Empty And HoraFinal = Empty) Then Exit Sub
    
    Set MsgReply = Msg.ReplyAll
     
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "-----------------<span style=""font-size : 6pt"">" & VERSAO & "</span>----------------<br>" _
            & "Prezado Cliente, <br />" _
            & " <br />" _
            & "Sua solicitação foi concluída. <br />" _
            & "Por favor, faça os testes necessários e qualquer problema ou necessidade basta responder a todos neste mesmo e-mail solicitando a reabertura. <br />" _
            & "Segue relatório em anexo ou informações abaixo  no corpo do e-mail.<br />" _
            & " <br />" _
            & "-----------------------------------<br />" _
            & "Horário do atendimento: <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "-----------------------------------<br />" _
            & " <br />" _
            & "Informações importantes: <br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::resolved::" & UID(Msg.Subject) & "::<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br /></span>" _
            & "-----------------------------------</span><br />" _
            & "</span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 22}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing

End Sub

' Sub Assumir_Chamado()
    ' Dim Msg As Outlook.MailItem
    ' Dim MsgReply As Outlook.MailItem
    ' Dim strTo As String
    ' Dim strCC As String
    
    ' ' set reference to open/selected mail item
    ' On Error Resume Next
    ' Select Case TypeName(Application.ActiveWindow)
    ' Case "Explorer"
        ' Set Msg = ActiveExplorer.Selection.Item(1)
    ' Case "Inspector"
        ' Set Msg = ActiveInspector.CurrentItem
    ' Case Else
    ' End Select
    ' On Error GoTo 0
        
    ' If Msg Is Nothing Then GoTo ExitProc
    ' If Not chamadoAberto(Msg.Subject) Then Exit Sub
    ' If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    
    ' If Not chamadoPlantao(Msg.Subject, False) Then
        ' If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    ' End If
       
    ' Set MsgReply = Msg.ReplyAll
     
    ' strTo = EmailToInterno(Msg)
    ' strCC = EmailCCInterno(Msg)
    
    ' If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", False, Empty) Then
        ' strTo = Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
        ' strCC = Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
    ' End If
    ' If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
   
    ' If strTo = Empty Then
        ' strTo = "coordenadores@intersolution.inf.br"
    ' End If
    
    ' On Error Resume Next

    ' With MsgReply
        ' .To = strTo
        ' .CC = strCC
        ' .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        ' .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                  ' & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
                  ' & "Estou assumindo esse chamado, informarei a todos assim que iniciar as atividades. <br />" _
                  ' & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
                  ' & "::chamado::assumir::" & UID(Msg.Subject) & "::<br /></span>" _
                  ' & "==========================</span><br />" & .HTMLBody
        ' .Display
        ' SendKeys "{DOWN 5}"
        
    ' End With

' ExitProc:
    ' Set Msg = Nothing
    ' Set MsgReply = Nothing
' End Sub

Sub Alterar_Dono()
     
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strDonoName As String
    Dim strTo As String
    Dim strCC As String
     
    'set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
     
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    Set MsgReply = Msg.ReplyAll
     
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", False, Empty) Then
        strTo = Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
        strCC = Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
    End If
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    If strTo = Empty Then
        strTo = "coordenadores@intersolution.inf.br"
    End If
           
    On Error Resume Next
    
    strDonoName = InputBox("E-mail do novo dono sem @intersolution.com.br:")
    If strDonoName = "" Then Exit Sub
    
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
        & "Prezados, <br />" _
        & "Novo dono será: " & strDonoName & "@intersolution.com.br <br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::dono::" & UID(Msg.Subject) & "::<br />" _
        & "dono|" & strDonoName & "@intersolution.com.br|<br /> </span> " _
        & "==========================</span><br />" & .HTMLBody
        .Display
        SendKeys "{DOWN 7}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Roteador()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
     
    If Msg Is Nothing Then GoTo ExitProc
     
    If Not ValidaTicket(Msg.ReplyRecipientNames, True) Then Exit Sub
    If Not ValidaTicketNormal(Msg.Subject, True) Then Exit Sub
    If Not chamadoEmailEncerramento(Msg.Subject, True) Then Exit Sub
    
    If chamadoInterno(Msg.Subject) Then
        strTipoAtendimento = "Interno"
    Else
        strTipoAtendimento = "Suporte"
    End If
    
    DefineRoteador (strTipoAtendimento)
    
    If TipoAtendimento = Empty Or Area = Empty Then Exit Sub
    
    On Error Resume Next
        Set MsgReply = Msg.ReplyAll
        CopyAttachments Msg, MsgReply
         
    With MsgReply
        .Recipients.Add (LCase(Area) + "@intersolution.com.br")
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:blue"">" _
        & "-----------------------------------------------<span style=""font-size : 6pt"">" & VERSAO & "</span>---------------------------------------------------<br>" _
        & "Prezado Cliente,<br />" _
        & "Sua solicitação está sendo encaminhada à equipe de consultores responsáveis.<br />" _
        & "<br />" _
        & "Tipo de Atendimento: " & TipoAtendimento & "<br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::rotear::" & UID(Msg.Subject) & "::<br />" _
        & "tipo_atendimento|" & TipoAtendimento & "| <br />" _
        & "area|" & Area & "|</span> <br /> " _
        & "Informações importantes: <br />" _
        & "-----------------------------------------------------------------------------------------------------</span><br>" _
        & .HTMLBody
        .Display
        SendKeys "{DOWN 11}"
        End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub Dependencia_Ticket()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
    
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoNormal(Msg.Subject, True) Then Exit Sub
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    TicketDependencia = Empty
    RTDependencia = Empty
            
    DefineDependencia
                        
    If (TicketDependencia = Empty Or RTDependencia = Empty) Then Exit Sub
    TicketDependencia = Replace(TicketDependencia, " ", "")
    
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If strTo = Empty Then
        strTo = "coordenadores@intersolution.inf.br"
    End If
        
    Set MsgReply = Msg.ReplyAll
    
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
        & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
        & "Prezados, <br />" _
        & "<br />" _
        & "A execução deste ticket depende da conclusão de outros: " & Replace(TicketDependencia, ",", ", ") & "<br />" _
        & "<br />" _
        & "Será enviado um e-mail para o ticket atual informando que o mesmo poderá ser executado assim que as pendências forem finalizadas.<br />" _
        & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
        & "::chamado::vincular_ticket::" & UID(Msg.Subject) & "::<br />" _
        & "vincular_ticket|" & TicketDependencia & "|<br />" _
        & "rt_ticket|" & RTDependencia & "|<br /></span>" _
        & "==========================</span><br>" _
        & .HTMLBody
        .Display
        SendKeys "{DOWN 11}"
    End With
     
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Function TextoAlertaCopiaCliente()
   TextoAlertaCopiaCliente = "Atenção: nenhum contato de Cliente encontrado. Caso este ticket não seja interno, inclua o cliente por favor."
End Function

Function TextoAlertaCopiaCorporativo()
   TextoAlertaCopiaCorporativo = "Atenção: Email corporativo não encontrado, mas será incluído. Solicite ao cliente que sempre Responda a Todos"
End Function

Function TextoAlertaCopiaArea()
   TextoAlertaCopiaArea = "Atenção: Email de Sistemas, DBA ou Infra não encontrado em cópia. Por favor inclua"
End Function

Function CorAlertaCopiaCliente()
   CorAlertaCopiaCliente = &HFF&
End Function

Function CorAlertaCopiaCorporativo()
   CorAlertaCopiaCorporativo = &H8000&
End Function

Function CorAlertaCopiaArea()
   CorAlertaCopiaArea = &HC000C0
End Function

Sub CopyAttachments(objSourceItem, objTargetItem)
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set fldTemp = fso.GetSpecialFolder(2) ' TemporaryFolder
   strPath = fldTemp.Path & "\"
   For Each objAtt In objSourceItem.Attachments
      strFile = strPath & objAtt.FileName
      objAtt.SaveAsFile strFile
      objTargetItem.Attachments.Add strFile, , , objAtt.DisplayName
      fso.DeleteFile strFile
   Next

   Set fldTemp = Nothing
   Set fso = Nothing
End Sub

Sub Agendar_Interno()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim objMailMessage As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    'If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", False, Empty) Then
        strTo = Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
        strCC = Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
    End If
    If strTo = Empty Then
        strTo = EmailInterno(Msg.Subject)
    End If
        
    ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
    If (strTo = Empty) Then
        strTo = chamadoFilaCorporativo(Msg.Subject)
    End If
    
    ' Esconde mensagem de cliente em copia, pois estamos num chamado interno
    ClienteEmCopia = True
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    ExibeRecorrencia = False
    
    HabilitarSolicitacaoCliente = False
    
    DefineAgendamentoHorarioAtendimento
                
    If (DataAgendamento = Empty Or HoraAgendamento = Empty Or FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
        
    Set MsgReply = Msg.ReplyAll
        
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "================ INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =================<br>" _
            & "Prezado Consultor, <br /><br />" _
            & "Sua atividade interna está agendada conforme informações abaixo.<br /><br />" _
            & "Agendamento Interno:<br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::agendar_interno::" & UID(Msg.Subject) & "::<br />" _
            & "data_agendamento|" & DataAgendamento & "|<br />" _
            & "hora_agendamento|" & HoraAgendamento & "|<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br />" _
            & "solicitacao_cliente|" & SolicitacaoCliente & "|<br /></span>" _
            & "==========================================<br />" _
            & "Data: " & DataAgendamento & "<br />" _
            & "Horário: " & HoraAgendamento & "<br /><br />" _
            & "==========================================<br />" _
            & "Horário do atendimento <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "==========================================<br /> <br />" _
            & "Informações importantes:<br />" _
            & "==========================================</span><br></span>" & .HTMLBody
        .Display
        SendKeys "{DOWN 27}"
    End With
        
    'Cancela agendamento do mesmo ticket
    Dim oCalendar As Outlook.Folder
    Dim oItems As Outlook.Items
    Dim oItemsInDateRange As Outlook.Items
    Dim oFinalItems As Outlook.Items
    Dim oAppt As Outlook.AppointmentItem
    Dim strRestriction As String
    Dim bolAtualizado As Boolean
         
    'Cria pesquisa da data atual até 90 dias
    strRestriction = "[Start] >= '" & _
                     Format$(Now, "dd/mm/yyyy hh:mm") _
                     & "' AND [End] <= '" & _
                     Format$(DateAdd("d", 120, Now), "dd/mm/yyyy hh:mm") & "'"
                    
    Debug.Print strRestriction
    Set oCalendar = Application.Session.GetDefaultFolder(olFolderCalendar)
    Set oItems = oCalendar.Items
    oItems.IncludeRecurrences = True
    oItems.Sort "[Start]"
    
    Set oItemsInDateRange = oItems.Restrict(strRestriction)
    
    If (InStr(1, Msg.Subject, "'") > 0) Then
        strAssunto = Mid(Msg.Subject, 1, InStr(1, Msg.Subject, "'") - 1)
    Else
        strAssunto = Msg.Subject
    End If
    
    'Cria pesquisa com o titulo do e-mail
    Const PropTag  As String = "http://schemas.microsoft.com/mapi/proptag/"
    strRestriction = "@SQL=" & Chr(34) & PropTag _
        & "0x0037001E" & Chr(34) & " like '%" & strAssunto & "%'"
    
    Set oFinalItems = oItemsInDateRange.Restrict(strRestriction)
    
    'Pesquisa compromissos
    oFinalItems.Sort "[Start]"
    
    Count = 0
    
    'Cancela os compromissos agendados
    For Each oAppt In oFinalItems
        If (Count = 0) Then
            oAppt.Start = DataAgendamento & " " & HoraAgendamento
            oAppt.Duration = 30
            oAppt.ReminderSet = True
            oAppt.Send
            
            bolAtualizado = True
        Else
            oAppt.Delete
        End If
        
        Count = Count + 1
    Next
        
    If (bolAtualizado = False) Then
        'Cria compromisso na agenda do outlook
        Dim myItem As Object
        Dim myRequiredAttendee, myOptionalAttendee As Outlook.Recipient
  
        Set myItem = Application.CreateItem(olAppointmentItem)
        myItem.MeetingStatus = olMeeting
        myItem.Subject = "ATIVIDADE INTERNA - " & Msg.Subject
        myItem.Location = "InterSolution"
        myItem.Start = DataAgendamento & " " & HoraAgendamento
        myItem.Duration = 30
        myItem.ReminderSet = True
        myItem.Location = ""
   
        Set myRequiredAttendee = myItem.Recipients.Add(Msg.SendUsingAccount.SmtpAddress)
        myRequiredAttendee.Type = olRequired

        myItem.Send
    End If
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
    Set strTicket = Nothing
    Set objMailMessage = Nothing
End Sub

Sub Status_Interno()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    Dim strTextoEmail As String
    
    ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0

    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
    
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub

    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", False, Empty) Then
        strTo = Replace(Replace(strTo, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
        strCC = Replace(Replace(strCC, "naoabrir@intersolution.com.br", ""), "naoabrir@intersolution.inf.br", "")
    End If
    If strTo = Empty Then
        strTo = EmailInterno(Msg.Subject)
    End If
        
    ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
    If (strTo = Empty) Then
        strTo = chamadoFilaCorporativo(Msg.Subject)
    End If
    
    ' Esconde mensagem de cliente em copia, pois estamos num chamado interno
    ClienteEmCopia = True
    AreaEmCopia = VerificaCopiaArea(Msg)
    CorporativoEmCopia = VerificaCopiaCorporativo(Msg)
    
    HabilitarSolicitacaoCliente = False
    
    DefineStatusInterno
            
    If (FormaAtendimento = Empty Or HoraInicial = Empty Or HoraFinal = Empty) Then Exit Sub
    
    If (EncerramentoAtividade = "S") Then
        strTextoEmail = "Sua atividade foi concluída."
    Else
        strTextoEmail = "Sua atividade continua em andamento."
    End If
            
    Set MsgReply = Msg.ReplyAll
     
    With MsgReply
        .To = strTo
        .CC = strCC
        If Not CorporativoEmCopia Then
            .Recipients.Add (chamadoFilaCorporativo(Msg.Subject))
        End If
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
            & "================ INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =================<br>" _
            & "Prezado Consultor,<br /><br />" _
            & strTextoEmail & "<br />" _
            & "<br />" _
            & "==========================================<br />" _
            & "Horário do atendimento: <br />" _
            & "Das " & HoraInicial & " às " & HoraFinal & " <br />" _
            & "==========================================<br />" _
            & " <br />" _
            & "Informações importantes: <br />" _
            & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
            & "::chamado::status_interno::" & UID(Msg.Subject) & "::<br />" _
            & "forma_atendimento|" & FormaAtendimento & "|<br />" _
            & "data_inicial|" & Replace(DataInicial, "/", "-") & "|<br />" _
            & "hora_inicial|" & HoraInicial & "|<br />" _
            & "data_final|" & Replace(DataFinal, "/", "-") & "|<br />" _
            & "hora_final|" & HoraFinal & "|<br />" _
            & "solicitacao_cliente|" & SolicitacaoCliente & "|<br />" _
            & "finalizar_atividade|" & EncerramentoAtividade & "|<br /></span>" _
            & "==========================================</span><br />" _
            & .HTMLBody
        .Display
        SendKeys "{DOWN 21}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Sub ManutencaoDB()
    Dim Msg As Outlook.MailItem
    Dim MsgReply As Outlook.MailItem
    Dim strTo As String
    Dim strCC As String
    Dim strStatusManutencao As String
    
     ' set reference to open/selected mail item
    On Error Resume Next
    Select Case TypeName(Application.ActiveWindow)
    Case "Explorer"
        Set Msg = ActiveExplorer.Selection.Item(1)
    Case "Inspector"
        Set Msg = ActiveInspector.CurrentItem
    Case Else
    End Select
    On Error GoTo 0
   
    If Msg Is Nothing Then GoTo ExitProc
    If Not chamadoAberto(Msg.Subject) Then Exit Sub
    If Not chamadoNormalPlantao(Msg.Subject, True) Then Exit Sub
    If Not chamadoPlantao(Msg.Subject, False) Then
        If Not ValidaRemetente(Msg.ReplyRecipientNames, True) Then Exit Sub
    End If
        
    If VerificaEnderecoEmail(Msg, "naoabrir@intersolution", "Nao Abrir Ticket", True, Empty) Then Exit Sub
    If VerificaEmailRTADM(Msg, True, Empty) Then Exit Sub
    
    strTo = EmailToInterno(Msg)
    strCC = EmailCCInterno(Msg)
    
    If strTo = Empty Then
        strTo = "coordenadores@intersolution.inf.br"
    End If
        
    ' Se permanece em branco eh necessario setar, senao sera considerado o TO original, chamado 55088
    If (strTo = Empty) Then
        strTo = chamadoFilaCorporativo(Msg.Subject)
    End If
    
    fila = chamadoFila(Msg.Subject)
    
    DefineManutencaoDB
    
    If (DesativarMonitoramento = "") Then Exit Sub
    
    If (DesativarMonitoramento = "S") Then
        strStatusManutencao = "Estão sendo temporariamente desativados os monitoramentos SIGMon-Cloud dos Servidores/Bases abaixo:"
        strStatusManutencao = strStatusManutencao & "<br />" & Replace(FormManutencaoDB.retorna_selecionados(), ";", "<br />")
    Else
        strStatusManutencao = "Estão sendo reativados todos os monitoramentos SIGMon-Cloud desativados previamente neste chamado"
    End If
    
    Set MsgReply = Msg.ReplyAll
    
    With MsgReply
        .To = strTo
        .CC = strCC
        .Subject = corrigeAssunto(Msg.Subject)
        .HTMLBody = Replace(.HTMLBody, "::chamado::", "__chamado__")
        .HTMLBody = "<span style=""font-family : verdana;font-size : 10pt; color:red"">" _
                    & "========= INTERNO <span style=""font-size : 6pt"">" & VERSAO & "</span> =========<br>" _
                    & "Prezados, <br />" _
                    & "<br />" _
                    & strStatusManutencao & "<br /><br />" _
                    & "Informações importantes:<br /> " _
                    & "<span style=""font-family : verdana;font-size : 1pt; color:white""><br />" _
                    & "::chamado::manutencaodb::" & UID(Msg.Subject) & "::<br />" _
                    & "desativar_monitoramento|" & DesativarMonitoramento & "|<br />" _
                    & "bases_manutencao|" & FormManutencaoDB.retorna_selecionados() & "|<br /></span>" _
                    & "-----------------------------------</span><br />" & .HTMLBody
        .Display
        
        SendKeys "{DOWN " & (12 + Module1.strCount(FormManutencaoDB.retorna_selecionados(), ";")) & "}"
    End With
    
ExitProc:
    Set Msg = Nothing
    Set MsgReply = Nothing
End Sub

Public Function strCount(value As String, ch As String) As Integer
  strCount = Len(value) - Len(Replace(value, ch, ""))
End Function
