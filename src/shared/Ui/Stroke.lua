local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Styles = require(ReplicatedStorage.Ui.Styles)

local e = React.createElement

local function Stroke(props: {
	color: Color3 | ColorSequence | Styles.Palette,
	applyStrokeMode: Enum.ApplyStrokeMode?,
})
	return e("UIStroke", {
		ApplyStrokeMode = props.applyStrokeMode or Enum.ApplyStrokeMode.Border,
		Color = if typeof(props.color) == "Color3" then props.color else Color3.new(1, 1, 1),
		Thickness = 4,
	}, {
		UIGradient = typeof(props.color) ~= "Color3" and e("UIGradient", {
			Color = if typeof(props.color) == "ColorSequence" then props.color else error("nyi"),
			Rotation = 90,
		}),
	})
end

return Stroke
