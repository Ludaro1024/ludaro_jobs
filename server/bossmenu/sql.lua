function sql_getAllJobInfo()
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs', {})
    return row
end

sqlquery = false

function sql_updateJobInfo(name, markerred, markergreen, markerblue, markeralpha)
    print(name)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)

    if markerred then
        jobinfo.markerred = markerred
    end
    if markergreen then
        jobinfo.markergreen = markergreen
    end
    if markerblue then
        jobinfo.markerblue = markerblue
    end
    if markeralpha then
        jobinfo.markeralpha = markeralpha
    end
    print(json.encode(jobinfo))
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setBossMenu(job, value)
    local row = MySQL.single.await('SELECT * FROM jobs WHERE `label` = ? LIMIT 1', { job })
    if row then
        if row.ludaro_jobs_info then
            local ludaro_jobs_info = json.decode(row.ludaro_jobs_info)
            ludaro_jobs_info.bossmenu = value
            local result = MySQL.update.await('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?',
                { json.encode(ludaro_jobs_info), job })

            return result or false
        else
            local result = MySQL.update.await('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?',
                { json.encode({ bossmenu = value }), job })

            return result or false
        end
    else
        return false
    end
end

--

function sql_setMarkerID(name, id)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.markerid = id
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerBobUpAndDown(name, id)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.markerbobupanddown = id
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerScaleX(name, x)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.scalex = x
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerScaleY(name, y)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.scaley = y
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerScaleZ(name, z)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.scalez = z
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerXOffset(name, xoffset)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.xoffset = xoffset
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerYOffset(name, yoffset)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.yoffset = yoffset
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerZOffset(name, zoffset)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.zoffset = zoffset
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerEnabled(name, enabled)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.markerenabled = enabled
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerFaceCamera(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.markerfacecamera = value
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setMarkerColor(name, r, g, b)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })

    local jobinfo = json.decode(row[1].ludaro_jobs_info)

    jobinfo.markerred = r or jobinfo.markerred or Config.DefaultMarker.red
    jobinfo.markergreen = g or jobinfo.markergreen or Config.DefaultMarker.green
    jobinfo.markerblue = b or jobinfo.markerblue or Config.DefaultMarker.blue
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setNPCModel(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.npcmodel = value
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setXOffsetNPC(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.xoffsetnpc = value
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setYOffsetNPC(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.yoffsetnpc = value
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setZOffsetNPC(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.zoffsetnpc = value
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setNpcHeading(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.npcheading = value

    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end

function sql_setNpcEnabled(name, value)
    local row = MySQL.query.await('SELECT ludaro_jobs_info FROM jobs WHERE label = ?', { name })
    local jobinfo = json.decode(row[1].ludaro_jobs_info)
    jobinfo.npcenabled = value
    result = MySQL.Async.execute('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?', { json.encode(jobinfo), name })
end
