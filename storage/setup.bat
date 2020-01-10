cd c:\
mkdir run

mkdir C:\ProgramData\ssh
mkdir C:\ProgramData\ssh\logs

REM we copy the files inside the main volume in order to have full
REM filesystem access
xcopy /e /y build run

copy run\placeholder_key c:\ProgramData\ssh\ssh_host_dsa_key
copy run\placeholder_key c:\ProgramData\ssh\ssh_host_ecdsa_key
copy run\placeholder_key c:\ProgramData\ssh\ssh_host_ed25519_key
copy run\ssh_host_rsa_key c:\ProgramData\ssh\ssh_host_rsa_key

copy run\sshd_config c:\ProgramData\ssh\sshd_config
REM set the right permissions to the SSH host key
REM removing all the inherited config don't always work
REM this is why we explicitly remove some permissions.
icacls c:/ProgramData/ssh/ssh_host_rsa_key /inheritance:r
icacls c:/ProgramData/ssh/ssh_host_rsa_key /grant BUILTIN\Administrators:(F)
icacls c:/ProgramData/ssh/ssh_host_rsa_key /grant "NT AUTHORITY\SYSTEM:(F)"
icacls c:/ProgramData/ssh/ssh_host_rsa_key /remove "User Manager\ContainerAdministrator"
REM setting owner at the end. after that we no longer have access to the file.
icacls c:/ProgramData/ssh/ssh_host_rsa_key /setowner "NT AUTHORITY\SYSTEM"

REM create test account: test-user/pass
net user /add test-user SuperPass123

REM create the windows service
REM make sure to have the space and double quoted after binpath=
sc create sshd start= "demand" binpath= "C:\run\OpenSSH-Win64\sshd.exe -E c:\run\sshd.log"
sc privs sshd SeAssignPrimaryTokenPrivilege/SeTcbPrivilege/SeBackupPrivilege/SeRestorePrivilege/SeImpersonatePrivilege
