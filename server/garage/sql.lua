sql_setGarageName = function(jobname, value)
	jobinfo = Callback_Framework_GetJobInfo(jobname)
	if jobinfo then
		jobinfo.garage_name = value

		-- insert it into the sql again (jobinfo fully)

		local result = MySQL.update.await(
			"UPDATE ludaro_jobs_info SET ludaro_jobs_info = ? WHERE `label` = ? LIMIT 1 ",
			{ value, jobname }
		)
		return true
	else
		return false
	end
end

sql_setGarageEnabled = function(jobname, value)
    jobinfo = Callback_Framework_GetJobInfo(jobname)
    if jobinfo then
        jobinfo.garage_enabled = value

        -- insert it into the sql again (jobinfo fully)

        local result = MySQL.update.await(
            "UPDATE ludaro_jobs_info SET ludaro_jobs_info = ? WHERE `label` = ? LIMIT 1 ",
            { value, jobname }
        )
        return true
    else
        return false
    end
end

sql_setGarageMinGrade = function(jobname, value)
    jobinfo = Callback_Framework_GetJobInfo(jobname)
    if jobinfo then
        jobinfo.garage_min_grade = value

        -- insert it into the sql again (jobinfo fully)

        local result = MySQL.update.await(
            "UPDATE ludaro_jobs_info SET ludaro_jobs_info = ? WHERE `label` = ? LIMIT 1 ",
            { value, jobname }
        )
        return true
    else
        return false
    end
end

sql_setGarageSocietyName = function(jobname, value)
    jobinfo = Callback_Framework_GetJobInfo(jobname)
    if jobinfo then
        jobinfo.garage_society_name = value

        -- insert it into the sql again (jobinfo fully)

        local result = MySQL.update.await(
            "UPDATE ludaro_jobs_info SET ludaro_jobs_info = ? WHERE `label` = ? LIMIT 1 ",
            { value, jobname }
        )
        return true
    else
        return false
    end
end

sql_setGarageCoords = function(jobname, value)
    jobinfo = Callback_Framework_GetJobInfo(jobname)
    if jobinfo then
        jobinfo.garage_coords = value

        -- insert it into the sql again (jobinfo fully)

        local result = MySQL.update.await(
            "UPDATE ludaro_jobs_info SET ludaro_jobs_info = ? WHERE `label` = ? LIMIT 1 ",
            { value, jobname }
        )
        return true
    else
        return false
    end
end

sql_setGarageBlip = function(jobname, value)
    jobinfo = Callback_Framework_GetJobInfo(jobname)
    if jobinfo then
        jobinfo.garage_blip = value

        -- insert it into the sql again (jobinfo fully)

        local result = MySQL.update.await(
            "UPDATE ludaro_jobs_info SET ludaro_jobs_info = ? WHERE `label` = ? LIMIT 1 ",
            { value, jobname }
        )
        return true
    else
        return false
    end
end
