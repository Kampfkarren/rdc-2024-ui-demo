local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

type PaddingValue = number | UDim

export type Props = {
	all: PaddingValue,

	horizontal: nil,
	vertical: nil,
} | {
	all: nil,

	horizontal: PaddingValue?,
	vertical: PaddingValue?,
}

local function paddingValueUDim(paddingValue: PaddingValue): UDim
	return if typeof(paddingValue) == "number" then UDim.new(0, paddingValue) else paddingValue
end

local function Padding(props: Props)
	local horizontalValue = props.all or props.horizontal or UDim.new()
	local verticalValue = props.all or props.vertical or UDim.new()

	return e("UIPadding", {
		PaddingLeft = paddingValueUDim(horizontalValue),
		PaddingRight = paddingValueUDim(horizontalValue),
		PaddingTop = paddingValueUDim(verticalValue),
		PaddingBottom = paddingValueUDim(verticalValue),
	})
end

return Padding
