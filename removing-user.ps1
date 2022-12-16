$user = "USERNAME"
$group = "GROUP NAME"

$userObj = Get-ADUser $user -ErrorAction SilentlyContinue

# Check if the user exists
if ($null -eq $userObj) {
    Write-Output "User $user not found"
} else {
    # Check if the user is a member of the group
    $isMember = Get-ADPrincipalGroupMembership $user | Where-Object {$_.Name -eq $group}
    if ($null -eq $isMember) {
        Write-Output "User $user is not a member of group $group"
    } else {
        # Remove the user from the group
        $question = Read-Host ("Are you sure you want to remove $user from $group? [yes/no]")
        if ($question -eq "yes") {
            Remove-ADGroupMember -Identity $group -Members $user -Confirm:$false
            Write-Output "User $user removed from group $group"
        }
        else {
            Write-Host "Removing $user from $group stopped"
            break
        }
    }
}
