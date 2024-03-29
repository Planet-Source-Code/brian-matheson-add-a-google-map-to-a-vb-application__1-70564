VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "ieframe.dll"
Begin VB.Form frmMap 
   Caption         =   "Google Map"
   ClientHeight    =   7350
   ClientLeft      =   165
   ClientTop       =   555
   ClientWidth     =   8505
   Icon            =   "frmMap.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7350
   ScaleWidth      =   8505
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      Caption         =   "Map Lat/Long"
      Height          =   375
      Left            =   7200
      TabIndex        =   14
      Top             =   1200
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Map Address"
      Height          =   375
      Left            =   5880
      TabIndex        =   13
      Top             =   1200
      Width           =   1215
   End
   Begin VB.TextBox txtLong 
      Height          =   285
      Left            =   6000
      TabIndex        =   12
      Top             =   720
      Width           =   2415
   End
   Begin VB.TextBox txtLat 
      Height          =   285
      Left            =   6000
      TabIndex        =   11
      Top             =   120
      Width           =   2415
   End
   Begin VB.TextBox txtZipCode 
      Height          =   285
      Left            =   2760
      TabIndex        =   10
      Top             =   1080
      Width           =   1215
   End
   Begin VB.TextBox txtState 
      Height          =   285
      Left            =   960
      TabIndex        =   9
      Top             =   1080
      Width           =   735
   End
   Begin VB.TextBox txtCity 
      Height          =   285
      Left            =   960
      TabIndex        =   8
      Top             =   600
      Width           =   4215
   End
   Begin VB.TextBox txtStreet 
      Height          =   285
      Left            =   960
      TabIndex        =   7
      Top             =   120
      Width           =   4215
   End
   Begin SHDocVwCtl.WebBrowser WebBrowser1 
      Height          =   5655
      Left            =   0
      TabIndex        =   0
      Top             =   1680
      Width           =   8535
      ExtentX         =   15055
      ExtentY         =   9975
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.Label Label6 
      Caption         =   "Long"
      Height          =   255
      Left            =   5520
      TabIndex        =   6
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label5 
      Caption         =   "Lat"
      Height          =   255
      Left            =   5640
      TabIndex        =   5
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "Zip Code"
      Height          =   255
      Left            =   1920
      TabIndex        =   4
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "State"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "City"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   600
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Street"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "frmMap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Type ControlPositionType
    Left As Single
    Top As Single
    Width As Single
    Height As Single
    FontSize As Single
End Type

Private m_ControlPositions() As ControlPositionType
Private m_FormWid As Single
Private m_FormHgt As Single

Private Sub SaveSizes()
Dim i As Integer
Dim ctl As Control
' Save the controls' positions and sizes.
ReDim m_ControlPositions(1 To Controls.Count)
i = 1
For Each ctl In Controls
    With m_ControlPositions(i)
        If TypeOf ctl Is Line Then
            .Left = ctl.X1
            .Top = ctl.Y1
            .Width = ctl.X2 - ctl.X1
            .Height = ctl.Y2 - ctl.Y1
        Else
            .Left = ctl.Left
            .Top = ctl.Top
            .Width = ctl.Width
            .Height = ctl.Height
            On Error Resume Next
            .FontSize = ctl.Font.Size
            On Error GoTo 0
        End If
    End With
    i = i + 1
Next ctl
' Save the form's size.
m_FormWid = ScaleWidth
m_FormHgt = ScaleHeight
End Sub

Private Sub Command1_Click()
Dim street As String
Dim city As String
Dim state As String
Dim zip As String
Dim queryAddress As String
queryAddress = "http://maps.google.com/maps?q="
' build street part of query string
If txtStreet.Text <> "" Then
    street = txtStreet.Text
    queryAddress = queryAddress & street + "," & "+"
End If
' build city part of query string
If txtCity.Text <> "" Then
    city = txtCity.Text
    queryAddress = queryAddress & city + "," & "+"
End If
' build state part of query string
If txtState.Text <> "" Then
    state = txtState.Text
    queryAddress = queryAddress & state + "," & "+"
End If
' build zip code part of query string
If txtZipCode.Text <> "" Then
    zip = txtZipCode.Text
    queryAddress = queryAddress & zip
End If
' pass the url with the query string to web browser control
WebBrowser1.Navigate queryAddress
End Sub

Private Sub Command2_Click()
If txtLat.Text = "" Or txtLong.Text = "" Then
    MsgBox "Supply a latitude and longitude value.", "Missing Data"
End If
Dim lat As String
Dim lon As String
Dim queryAddress As String
queryAddress = "http://maps.google.com/maps?q="
If txtLat.Text <> "" Then
    lat = txtLat.Text
    queryAddress = queryAddress & lat + "%2C"
End If
' build longitude part of query string
If txtLong.Text <> "" Then
    lon = txtLong.Text
    queryAddress = queryAddress & lon
End If
WebBrowser1.Navigate queryAddress
End Sub

Private Sub Form_Load()
SaveSizes
End Sub

Private Sub Form_Resize()
ResizeControls
End Sub

Private Sub ResizeControls()
Dim i As Integer
Dim ctl As Control
Dim x_scale As Single
Dim y_scale As Single
' Don't bother if we are minimized.
If WindowState = vbMinimized Then Exit Sub
' Get the form's current scale factors.
x_scale = ScaleWidth / m_FormWid
y_scale = ScaleHeight / m_FormHgt
' Position the controls.
i = 1
For Each ctl In Controls
    With m_ControlPositions(i)
        If TypeOf ctl Is Line Then
            ctl.X1 = x_scale * .Left
            ctl.Y1 = y_scale * .Top
            ctl.X2 = ctl.X1 + x_scale * .Width
            ctl.Y2 = ctl.Y1 + y_scale * .Height
        Else
            ctl.Left = x_scale * .Left
            ctl.Top = y_scale * .Top
            ctl.Width = x_scale * .Width
            If Not (TypeOf ctl Is ComboBox) Then
                ' Cannot change height of ComboBoxes.
                ctl.Height = y_scale * .Height
            End If
            On Error Resume Next
            ctl.Font.Size = y_scale * .FontSize
            On Error GoTo 0
        End If
    End With
    i = i + 1
Next ctl
End Sub
