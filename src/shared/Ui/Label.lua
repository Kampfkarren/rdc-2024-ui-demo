local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Pane = require(ReplicatedStorage.Ui.Pane)
local React = require(ReplicatedStorage.Packages.React)
local Stroke = require(ReplicatedStorage.Ui.Stroke)
local Styles = require(ReplicatedStorage.Ui.Styles)
local sizeFromAutomaticSize = require(ReplicatedStorage.Ui.sizeFromAutomaticSize)

local e = React.createElement

local FONT_SCALES = {
	[Enum.Font.Cartoon] = 1.209,
	[Enum.Font.LuckiestGuy] = 1.000,
}

local function Label(props: {
	text: string,
	textSize: number,
	color: Color3 | ColorSequence | Styles.Palette,
	font: Enum.Font,

	stroke: Color3?,
	dropShadows: number?,
	wrap: boolean?,

	automaticSize: Enum.AutomaticSize?,

	native: { [any]: any }?,
	children: React.Node,
})
	local automaticSize = props.automaticSize or Enum.AutomaticSize.XY

	local dropShadows: { [string]: React.Node } = {}

	if props.dropShadows ~= nil then
		assert(props.stroke ~= nil, "You need to set a stroke to use dropShadows")
		for index = 1, props.dropShadows do
			dropShadows[`DropShadow{index}`] = e(Label, {
				text = props.text,
				textSize = props.textSize,
				color = props.stroke,
				stroke = props.stroke,
				font = props.font,
				wrapped = props.wrap,

				native = {
					Position = UDim2.fromOffset(0, 4 * index),
				},
			})
		end
	end

	return e(Pane, {
		automaticSize = automaticSize,
		native = props.native,
	}, {
		Label = e("TextLabel", {
			AutomaticSize = automaticSize,
			BackgroundTransparency = 1,
			Font = props.font,
			Size = sizeFromAutomaticSize(automaticSize),
			Text = props.text,
			TextColor3 = if typeof(props.color) == "Color3" then props.color else Color3.new(1, 1, 1),
			TextSize = props.textSize * (FONT_SCALES[props.font] or 1),
			TextWrapped = props.wrap,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			ZIndex = 2,
		}, {
			Gradient = typeof(props.color) ~= "Color3" and e("UIGradient", {
				Color = props.color,
				Rotation = 90,
			}),

			Stroke = props.stroke and e(Stroke, {
				applyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				color = props.stroke,
			}),
		}),
	}, dropShadows, props.children)
end

return Label
