VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} FormIniciar 
   Caption         =   "Iniciar"
   ClientHeight    =   2130
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4725
   OleObjectBlob   =   "FormIniciar.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "FormIniciar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub ExibirLblMsgEmailCopia()
    If Not ClienteEmCopia Or Not AreaEmCopia Or Not CorporativoEmCopia Then
        lblMsgEmailCopia.Visible = True
        If Not ClienteEmCopia Then
            lblMsgEmailCopia.Caption = Projeto1.TextoAlertaCopiaCliente
            lblMsgEmailCopia.ForeColor = Projeto1.CorAlertaCopiaCliente
        ElseIf Not AreaEmCopia Then
            lblMsgEmailCopia.Caption = Projeto1.TextoAlertaCopiaArea
            lblMsgEmailCopia.ForeColor = Projeto1.CorAlertaCopiaArea
        ElseIf Not CorporativoEmCopia Then
            lblMsgEmailCopia.Caption = Projeto1.TextoAlertaCopiaCorporativo
            lblMsgEmailCopia.ForeColor = Projeto1.CorAlertaCopiaCorporativo
        End If
    Else
        lblMsgEmailCopia.Visible = False
    End If
End Sub

Private Sub btnCancelar_Click()
    ExibirLblMsgEmailCopia
    
    optSolicitacaoClienteSim.value = False
    optSolicitacaoClienteNao.value = False
            
    btnOK.Enabled = False
    
    Projeto1.FormIniciar.Hide
End Sub

Private Sub btnOK_Click()
    If (optSolicitacaoClienteSim.value = "Verdadeiro" Or optSolicitacaoClienteSim.Enabled = False) Then
        SolicitacaoCliente = "S"
    Else
        SolicitacaoCliente = "N"
    End If
        
    Projeto1.FormIniciar.Hide

    optSolicitacaoClienteSim.value = False
    optSolicitacaoClienteNao.value = False
            
    btnOK.Enabled = False
End Sub

Private Sub optSolicitacaoClienteNao_Click()
    If (optSolicitacaoClienteSim.value = "Falso" And optSolicitacaoClienteNao.value = "Falso") Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub optSolicitacaoClienteSim_Click()
    If (optSolicitacaoClienteSim.value = "Falso" And optSolicitacaoClienteNao.value = "Falso") Then
        btnOK.Enabled = False
    Else
        btnOK.Enabled = True
    End If
End Sub

Private Sub UserForm_Activate()
    ExibirLblMsgEmailCopia
    
    optSolicitacaoClienteSim.value = False
    optSolicitacaoClienteNao.value = False
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Click()
    ExibirLblMsgEmailCopia
    
    optSolicitacaoClienteSim.value = False
    optSolicitacaoClienteNao.value = False
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Initialize()
    ExibirLblMsgEmailCopia
    
    optSolicitacaoClienteSim.value = False
    optSolicitacaoClienteNao.value = False
    btnOK.Enabled = False
End Sub

Private Sub UserForm_Terminate()
    ExibirLblMsgEmailCopia
    
    optSolicitacaoClienteSim.value = False
    optSolicitacaoClienteNao.value = False
    btnOK.Enabled = False
End Sub
