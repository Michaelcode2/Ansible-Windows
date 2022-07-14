
param ( $Srvr = "localhost", $Ref = "Retail", $Usr = "Intellect", $Pwd = "756", $ExchangeCode = "001")

#Создаём объект CodeProvider, для выполнения кода c# в нашем сценарии
$cp = new-object Microsoft.CSharp.CSharpCodeProvider
#В этой переменной можно задать параметры для выполнения кода
$cpar = New-Object System.CodeDom.Compiler.CompilerParameters
#Константы задающие действие функции SetWindowPos
$HideWindow = 0x0080
$ShowWindow = 0x0040

#С помощью конструкции "HereString" помещаем в переменную $Code код c#
#объявляющий функцию SetWindowPos
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

#Выполняем код c#
$cp.CompileAssemblyFromSource($cpar, $code)

#Получаем указатель (Handle) текущего окна PowerShell, используя специальную переменную $pid
$PSHandle = (Get-Process –id $pid).MainWindowHandle

#Используем объявленную функцию из PowerShell
[Win32API.Window]::SetWindowPos($PSHandle, 0, 0, 0, 0, 0, $HideWindow)

$connector = new-object -comobject "v83.COMConnector"
$connection=$connector.connect("srvr=$Srvr; ref=$Ref; Usr=$Usr; Pwd = $Pwd;")
#$connection=$connector.connect("File=""C:\Users\Michael\Documents\InfoBase1""; Usr=$Usr; Pwd = $Pwd;")
$ChangeCode=$ExchangeCode

$cats = [System.__ComObject].InvokeMember("Справочники",[System.Reflection.BindingFlags]::GetProperty,$null,$connection,$null)
$nod = [System.__ComObject].InvokeMember("НастройкиОбменаДанными",[System.Reflection.BindingFlags]::GetProperty,$null,$cats,$null)  
$fnd = [System.__ComObject].InvokeMember("НайтиПоКоду",[System.Reflection.BindingFlags]::InvokeMethod,$null,$nod,$ChangeCode)  
$ref = [System.__ComObject].InvokeMember("Ссылка",[System.Reflection.BindingFlags]::GetProperty,$null,$fnd,$null) 
$pod=  [System.__ComObject].InvokeMember("ПроцедурыОбменаДанными",[System.Reflection.BindingFlags]::GetProperty,$null,$connection,$null)  
$vodppn=[System.__ComObject].InvokeMember("ВыполнитьОбменДаннымиПоПроизвольнойНастройке",[System.Reflection.BindingFlags]::InvokeMethod,$null,$pod,$ref)  
