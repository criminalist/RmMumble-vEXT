class 'MumbleServerManager'

function MumbleServerManager:__init()
    self:SubscribeEvents()
end

function MumbleServerManager:SubscribeEvents()
    NetEvents:Subscribe('MumbleServerManager:RequestServerUuid', self, self.OnRequestServerUuid)
    Events:Subscribe('Player:SquadChange', self, self.SquadChange)
    Events:Subscribe('Player:TeamChange', self, self.TeamChange)
    Events:Subscribe('Engine:Message', self, self.OnEngineMessage)
end

function MumbleServerManager:OnRequestServerUuid(player)
    NetEvents:SendTo('MumbleServerManager:OnServerUuid', player, tostring(RCON:GetServerGUID()))
end
function MumbleServerManager:SquadChange(p_Player, p_SquadID)
    if p_Player == nil then
        return
    end
    NetEvents:SendTo('MumbleServerManager:OnContextChange', p_Player, p_Player.squadID, p_Player.teamID, p_Player.isSquadLeader)
end

function MumbleServerManager:TeamChange(p_Player, p_TeamID, p_SquadID)
    if p_Player == nil then
        return
    end
    NetEvents:SendTo('MumbleServerManager:OnContextChange', p_Player, p_Player.squadID, p_Player.teamID, p_Player.isSquadLeader)
end

function MumbleServerManager:OnEngineMessage(p_Message)
    if p_Message.type == MessageType.ServerPlayerSquadLeaderStatusChangedMessage then 
        --self:OnContextChange()
    end
end


local mumbleServerManager = MumbleServerManager()
return mumbleServerManager