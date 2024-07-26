local function sizeFromAutomaticSize(automaticSize: Enum.AutomaticSize): UDim2
	return if automaticSize == Enum.AutomaticSize.None
		then UDim2.fromScale(1, 1)
		elseif automaticSize == Enum.AutomaticSize.X then UDim2.fromScale(0, 1)
		elseif automaticSize == Enum.AutomaticSize.Y then UDim2.fromScale(1, 0)
		else UDim2.new()
end

return sizeFromAutomaticSize
