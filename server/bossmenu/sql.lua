function getalljobinfo()
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs', {})
    for k,v in pairs(row)do
        row[k] = json.encode(v)
    end
return row
end
