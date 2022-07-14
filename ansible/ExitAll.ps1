
param ( $Srvr = "localhost", $Ref = "Retail", $Usr = "Intellect", $Pwd = "7")

function ExitAll{
    # �������� ��������� ��� ������ ������������� �� ���� �� �� ��������� �������� ������� ���������� 1�
    # ���� ����� ������ �������� ��������� ����� �����, �� �� ������������� ��� ������� �������� ��������

    # ��������� ������� ��������: ����� �������, �������� ���� ��������
    $SrvAddr = "tcp://127.0.0.1"
    ########################################
    $V83Com = New-Object -COMObject "V83.COMConnector"
    # ����������� � ������ �������

    $ServerAgent = $V83Com.ConnectAgent($SrvAddr)
    $ClusterFound = $FALSE
    #������� ������ ��������� �������

    $Clasters = $ServerAgent.GetClusters()
    foreach ($Claster in $Clasters){
        # �������������� � ���������� ��������
        # ���� � ������������, ��� ������� ����� ����������� �������� ��� ���� �� �������,
        # ����� ��������� ���� ��� ������������ � ������ �������������� ��������

        $ServerAgent.Authenticate($Claster,"","")

        #�������� ������ ������ �������� � ��������� ��
        $Sessions = $ServerAgent.GetSessions($Claster)
        write-host "�����������" $Sessions.Count "������..."
        foreach ($Session in $Sessions){
        $ServerAgent.TerminateSession($Claster,$Session)}
    	
        if (($Sessions.Count -eq 0)){
        continue}

        # ���� ����� ������ �������� �������� ����� ���������� ������� ��������
        # ��� �������������� ������������� ������� ���������� ��������, �� ��� "��������" ������

        # �������� ������ ������� ��������� ��������
        $WorkingProcesses = $ServerAgent.GetWorkingProcesses($Claster)

        foreach ($WorkingProcess in $WorkingProcesses){
            if ($WorkingProcess.Running -eq 1){
                write-host "������������� ������� � PID =" $WorkingProcess.PID
                #!!!����� ������ �� ��������� ��� ��������� � �������� ������� �������� ��� ��������� � ���������� ������� ������ ���������� 1�
                Stop-Process $WorkingProcess.PID -Force}}

    }
    $V83Com = ""
}

#��������� ��� � 1�
ExitAll
