if Config.AutoSQL then
    MySQL.ready(function()
        MySQL.Async.execute('ALTER TABLE jobs ADD COLUMN IF NOT EXISTS interactions VARCHAR(255) DEFAULT \'[]\'')
        MySQL.Async.execute('ALTER TABLE jobs ADD COLUMN IF NOT EXISTS ludaro_jobs_info VARCHAR(255) DEFAULT \'[]\'')
        debug2("^2[ludaro_jobs]^0: ^2SQL has been updated!^0")
    end)
end

print("what")