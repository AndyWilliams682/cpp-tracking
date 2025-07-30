

function get_joker_gold_sticker(_center, index)
    if get_joker_win_sticker(_center, index) >= 8 then return 1 end
    return 0
  end
  
function set_profile_progress()
    G.PROGRESS = G.PROGRESS or {
    joker_stickers = {tally = 0, of = 0},
    deck_stakes = {tally = 0, of = 0},
    challenges = {tally = 0, of = 0},
    }
    for _, v in pairs(G.PROGRESS) do
    if type(v) == 'table' then
        v.tally = 0
        v.of = 0
    end
    end

    for _, v in pairs(G.P_CENTERS) do
    if v.set == 'Back' and not v.omit then
        G.PROGRESS.deck_stakes.of = G.PROGRESS.deck_stakes.of + #G.P_CENTER_POOLS.Stake
        G.PROGRESS.deck_stakes.tally = G.PROGRESS.deck_stakes.tally + get_deck_win_stake(v.key)
    end
    if v.set == 'Joker' then 
        G.PROGRESS.joker_stickers.of = G.PROGRESS.joker_stickers.of + 1
        G.PROGRESS.joker_stickers.tally = G.PROGRESS.joker_stickers.tally + get_joker_gold_sticker(v, true)
    end
    end

    for _, v in pairs(G.CHALLENGES) do
    G.PROGRESS.challenges.of = G.PROGRESS.challenges.of + 1
    if G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id] then
        G.PROGRESS.challenges.tally = G.PROGRESS.challenges.tally + 1
    end
    end

    G.PROFILES[G.SETTINGS.profile].progress.joker_stickers = copy_table(G.PROGRESS.joker_stickers)
    G.PROFILES[G.SETTINGS.profile].progress.deck_stakes = copy_table(G.PROGRESS.deck_stakes)
    G.PROFILES[G.SETTINGS.profile].progress.challenges = copy_table(G.PROGRESS.challenges)
end