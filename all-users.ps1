# removing all group members from group
$group = "GROUP NAME"  # Replace GROUP NAME with the actual group name

# Get the group object and its members
$groupObj = Get-ADGroup $group -ErrorAction SilentlyContinue
$members = Get-ADGroupMember $groupObj

# Check if the group exists
if ($null -eq $groupObj) {
    Write-Output "Group $group not found"
} else {
    # Check if the group has any members
    if ($members.Count -eq 0) {
        Write-Output "Group $group has no members"
    } else {
        # Remove all members from the group
        $question = Read-Host ("Are you sure you want to remove $members from $groupObj? [yes/no]")
        if ($question -eq "yes") {
            Remove-ADGroupMember -Identity $group -Members $members -Confirm:$false
            Write-Output "All members removed from group $groupObj"
        }
        else {
            Write-Host "Removing $members from $groupObj stopped"
            break
        }
    }
}
