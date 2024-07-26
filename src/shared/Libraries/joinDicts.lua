local EMPTY = {}

local function joinDicts<K, V>(...: { [K]: V }?): { [K]: V }
	local final = nil
	local changed = false

	for index = 1, select("#", ...) do
		local dict = select(index, ...)
		if dict == nil then
			continue
		end

		if next(dict) == nil then
			continue
		end

		if final == nil then
			final = dict
		else
			assert(final ~= nil, "Luau")

			if not changed then
				final = table.clone(final)
				changed = true
			end

			for key, value in dict do
				final[key] = value
			end
		end
	end

	return final or EMPTY
end

return joinDicts
