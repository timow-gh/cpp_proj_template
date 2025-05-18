<#
.SYNOPSIS
    Removes <InstallPath>\bin from the system PATH.

.PARAMETER InstallPath
    The root directory that was passed to the installer.
    The script removes the literal "<InstallPath>\bin" entry
    (case-insensitive, with or without a trailing back-slash).
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InstallPath
)

try {
    $target   = Join-Path $InstallPath '\bin'
    $machine  = [EnvironmentVariableTarget]::Machine
    $pathVal  = [Environment]::GetEnvironmentVariable('Path', $machine)

    if ([string]::IsNullOrWhiteSpace($pathVal)) {
        Write-Host 'System Path is empty – nothing to do.'
        exit 0
    }

    # Split filter out the exact bin path (ignore trailing "\" and case)
    $paths      = $pathVal -split ';'
    $remaining  = $paths | Where-Object {
        -not ( $_.TrimEnd('\') -ieq $target.TrimEnd('\') )
    }

    # Only update the environment if something really changed
    if ($remaining.Count -eq $paths.Count) {
        Write-Host "$target not found in system Path – nothing to remove."
        exit 0
    }

    # Join the remaining segments, omitting leading/trailing semicolons
    $newPathVal = ($remaining -join ';').Trim(';')

    [Environment]::SetEnvironmentVariable('Path', $newPathVal, $machine)

    # Broadcast WM_SETTINGCHANGE so other processes pick up the new Path
    Add-Type -TypeDefinition @'
        using System;
        using System.Runtime.InteropServices;
        public static class Win32 {
            [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
            public static extern int SendMessageTimeout(
                IntPtr hWnd, uint Msg, IntPtr wParam, string lParam,
                uint fuFlags, uint uTimeout, out IntPtr lpdwResult);
        }
'@

    $HWND_BROADCAST   = [IntPtr]0xffff
    $WM_SETTINGCHANGE = 0x1a
    $result           = [IntPtr]::Zero

    [void][Win32]::SendMessageTimeout(
        $HWND_BROADCAST,
        $WM_SETTINGCHANGE,
        [IntPtr]::Zero,
        'Environment',
        0,        # SMTO_NORMAL
        5000,     # 5-second timeout
        [ref]$result
    )

    Write-Host "Removed $target from system Path"
    exit 0
}
catch {
    Write-Error $_
    exit 1
}
