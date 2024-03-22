Config.Interactions = {
    ["cuff"] = {
        prio = 1,          -- the prio of the interaction in the menu ( 1 = its on the top)
        name = "Put on Cuffs", -- name of the event in the menu
        client = false,    -- if false then its server side
        eventname = nil,
        eventargs = { true, true },
        icon = "cuff", --read readme for icons
    },
    ["uncuff"] = {
        prio = 2,           -- the prio of the interaction in the menu ( 1 = its on the top)
        name = "Put off Cuffs", -- name of the event in the menu
        client = false,     -- if false then its server side
        eventname = "ljobs:cuff",
        icon = 4,           -- read readme for icons
    }
}
