
param ( $Srvr = "localhost", $Ref = "Retail", $Usr = "Intellect", $Pwd = "756", $ExchangeCode = "001")

#������ ������ CodeProvider, ��� ���������� ���� c# � ����� ��������
$cp = new-object Microsoft.CSharp.CSharpCodeProvider
#� ���� ���������� ����� ������ ��������� ��� ���������� ����
$cpar = New-Object System.CodeDom.Compiler.CompilerParameters
#��������� �������� �������� ������� SetWindowPos
$HideWindow = 0x0080
$ShowWindow = 0x0040

#� ������� ����������� "HereString" �������� � ���������� $Code ��� c#
#����������� ������� SetWindowPos
$Code = @"
using System;
using System.Runtime.InteropServices;
namespace Win32API
{
    public class Window
    {
        [DllImport("user32.dll")]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int x, int y, int cx, int cy, uint uFlags);
    }
}
"@

#��������� ��� c#
$cp.CompileAssemblyFromSource($cpar, $code)

#�������� ��������� (Handle) �������� ���� PowerShell, ��������� ����������� ���������� $pid
$PSHandle = (Get-Process �id $pid).MainWindowHandle

#���������� ����������� ������� �� PowerShell
[Win32API.Window]::SetWindowPos($PSHandle, 0, 0, 0, 0, 0, $HideWindow)

$connector = new-object -comobject "v83.COMConnector"
$connection=$connector.connect("srvr=$Srvr; ref=$Ref; Usr=$Usr; Pwd = $Pwd;")
#$connection=$connector.connect("File=""C:\Users\Michael\Documents\InfoBase1""; Usr=$Usr; Pwd = $Pwd;")
$ChangeCode=$ExchangeCode

$cats = [System.__ComObject].InvokeMember("�����������",[System.Reflection.BindingFlags]::GetProperty,$null,$connection,$null)
$nod = [System.__ComObject].InvokeMember("����������������������",[System.Reflection.BindingFlags]::GetProperty,$null,$cats,$null)  
$fnd = [System.__ComObject].InvokeMember("�����������",[System.Reflection.BindingFlags]::InvokeMethod,$null,$nod,$ChangeCode)  
$ref = [System.__ComObject].InvokeMember("������",[System.Reflection.BindingFlags]::GetProperty,$null,$fnd,$null) 
$pod=  [System.__ComObject].InvokeMember("����������������������",[System.Reflection.BindingFlags]::GetProperty,$null,$connection,$null)  
$vodppn=[System.__ComObject].InvokeMember("��������������������������������������������",[System.Reflection.BindingFlags]::InvokeMethod,$null,$pod,$ref)  
