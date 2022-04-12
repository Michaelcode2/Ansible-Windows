# Ansible access for windows mashine
Доступ Ansible до windows машин 

Порти для взаємодії: 5986

Windows 2012-1019
------

Для Windows 2012-2016 достатньо виконати скрипт
```ConfigureRemotingForAnsible.ps1```

При виникненні помилки запуску скриптів PowerShell:
```Set-ExecutionPolicy RemoteSigned```

Windows 2008
------

Вимоги:

1. Перевірка
- ОС  Windows 2008 R2 Service Pack 1;
- NET Framework 4.5 або вище;
- Windows Management Framework 3,0   (Windows6.1-KB2506143-x64.msu)

2. Підготовка:
- Install-WMF3Hotfix.ps1  (або вручну Windows6.1-KB2842230-x64.msu);
- ConfigureRemotingForAnsible.ps1 (від імені Administrator);


Перевірка
------

Перевірити наявність звязку:

```ansible store -m win_ping```

store - окрема група серверів у файлі /etc/ansible/hosts
