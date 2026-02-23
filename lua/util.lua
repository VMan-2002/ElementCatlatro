--- what do you mean this had to be implimented by oratlab?
--- whatever

--- Returns whether a table contains a specific value
function table.contains(table, element)
	return topuplib.getValueIndex(tbl, val) ~= nil
end

-- Returns the size of any table
function table.size(table)
	return topuplib.countKeys(table)
end