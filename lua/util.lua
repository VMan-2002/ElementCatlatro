--- what do you mean this had to be implimented by oratlab?
--- whatever

--- Returns whether a table contains a specific value
function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

-- Returns the size of any table
function table.size(table)
    local size = 0
    for _,_ in pairs(table) do
        size = size + 1
    end
    return size
end