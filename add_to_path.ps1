param([string]$InstallPath)

$target = Join-Path $InstallPath '\bin'
$machine = [EnvironmentVariableTarget]::Machine
$pathVal = [Environment]::GetEnvironmentVariable('Path', $machine)

if ($pathVal -notlike "*$target*") {
[Environment]::SetEnvironmentVariable(
    'Path', "$pathVal;$target", $machine)

# Broadcast WM_SETTINGCHANGE so the new PATH is picked up
Add-Type -Name Win32 -Namespace Native -MemberDefinition @'
    [DllImport("user32.dll")]
    public static extern int SendMessageTimeout(
        int hWnd, uint Msg, int wParam, string lParam,
        int fuFlags, int uTimeout, out int lpdwResult);
'@
[void][Native.Win32]::SendMessageTimeout(
    0xffff, 0x1a, 0, 'Environment', 0, 5000, [ref]0)
Write-Host "Added $target to system Path"
}
else {
    Write-Host "$target already present in Path"
}

exit 0
