# must be run under posh-git shell.
function Get-ModuleGitStatus {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   Position=0)]
        [Alias("FullName","Path","LiteralPath")]
        $ModuleFolder='.\'
    )
    Process {
        Foreach ($Folder in $ModuleFolder) {
            # go to the folder and fetch. 
            Set-Location -Path ($Folder.FullName)
            git fetch

            # Get status
            $st = Get-GitStatus
            
            # Act on condition
            if ($st.Working.count) {
                Write-Warning "Module $($st.RepoName) is on branch $($st.Branch) and has $($st.Working.count) uncommitted changes."
            } else {
                Write-Verbose "Module $($st.RepoName) is on branch $($st.Branch) with no pending files in working dir."
            }
        }
    }
}
# this doesn't work. 