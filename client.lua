local QBCore = exports['qb-core']:GetCoreObject()

function GodsEyes()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local jobName = PlayerData.job.name

    if not Config.AllowedJobs[jobName] then
        lib.notify({
            title = 'Access Denied',
            description = 'You do not have permission to use God\'s Eye.',
            type = 'error',
            position = 'center-right',
            duration = 6000,
        })
        return
    end

    if foundPlayer then
        GodsEye(true)
        foundPlayer = false
        lib.notify({
            title = 'God\'s Eye Reset',
            description = 'Removed the blip, you are still on cooldown for ' .. 300 - count .. ' seconds',
            type = 'success',
            position = 'center-right',
            duration = 6000,
        })
        return
    end

    local input = lib.inputDialog("God's Eye Menu", {
        {type = 'number', label = 'Player ID', description = 'Input a Player ID to track using God\'s Eye', icon = 'hashtag'}
    })

    if not input then return end

    targetId = input[1]

    if targetId == cache.serverId then
        lib.notify({
            title = 'God\'s Eye',
            description = 'You cannot track yourself.',
            type = 'error',
            position = 'center-right',
            duration = 6000,
        })
        targetId = nil
        return
    end

    if count ~= 0 then
        lib.notify({
            title = 'Active Cooldown',
            description = 'You are still on cooldown for ' .. 300 - count .. ' seconds',
            type = 'warning',
            position = 'center-right',
            duration = 6000,
        })
        return
    end

    if foundPlayer then
        lib.notify({
            title = 'Search In-Progress',
            description = 'Player search already in-progress',
            type = 'error',
            position = 'center-right',
            duration = 6000,
        })
        return
    end

    GodsEye(false)

    Wait(100)

    if foundPlayer then
        lib.notify({
            title = 'Located Player',
            description = 'We have successfully located player with ID: ' .. targetId .. ' God\'s Eye active for 5 minutes.',
            type = 'success',
            position = 'center-right',
            duration = 6000,
        })
    end
end
