local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Padding = require(ReplicatedStorage.Ui.Padding)
local React = require(ReplicatedStorage.Packages.React)
local joinDicts = require(ReplicatedStorage.Libraries.joinDicts)
local sizeFromAutomaticSize = require(ReplicatedStorage.Ui.sizeFromAutomaticSize)

local e = React.createElement

local function Pane(props: {
	background: (Color3 | ColorSequence)?,
	cornerRadius: (UDim | number)?,

	automaticSize: Enum.AutomaticSize?,

	layoutOrder: number?,

	layout: Enum.FillDirection?,
	spacing: number?,
	horizontalAlignment: Enum.HorizontalAlignment?,
	verticalAlignment: Enum.HorizontalAlignment?,
	layoutWraps: boolean?,

	flexMode: Enum.UIFlexMode?,

	aspectRatio: number?,
	padding: (number | Padding.Props)?,

	onClick: (() -> ())?,
	native: { [any]: any }?,
	children: React.Node,

	[any]: never,
})
	local isTextButton = props.onClick ~= nil

	return e(
		if isTextButton then "TextButton" else "Frame",
		joinDicts({
			AutomaticSize = props.automaticSize,
			BackgroundColor3 = if props.background == nil
				then nil
				elseif typeof(props.background) == "Color3" then props.background
				else Color3.new(1, 1, 1),
			BackgroundTransparency = if props.background == nil then 1 else 0,
			BorderSizePixel = 0,
			LayoutOrder = props.layoutOrder,
			Size = sizeFromAutomaticSize(props.automaticSize or Enum.AutomaticSize.None),

			Text = if isTextButton then "" else nil,

			[React.Event.Activated] = props.onClick,
		}, props.native),
		{
			UIGradient = typeof(props.background) == "ColorSequence" and e("UIGradient", {
				Color = props.background,
				Rotation = 90,
			}),

			UICorner = props.cornerRadius and e("UICorner", {
				CornerRadius = if typeof(props.cornerRadius) == "UDim"
					then props.cornerRadius
					else UDim.new(0, props.cornerRadius),
			}),

			UIListLayout = props.layout and e("UIListLayout", {
				FillDirection = props.layout,
				SortOrder = Enum.SortOrder.LayoutOrder,

				HorizontalAlignment = props.horizontalAlignment,
				VerticalAlignment = props.verticalAlignment,
				Padding = props.spacing and UDim.new(0, props.spacing),
				Wraps = props.layoutWraps,
			}),

			UIFlexItem = props.flexMode and e("UIFlexItem", {
				FlexMode = props.flexMode,
			}),

			UIAspectRatioConstraint = props.aspectRatio and e("UIAspectRatioConstraint", {
				AspectRatio = props.aspectRatio,
			}),

			Padding = props.padding and e(
				Padding,
				if typeof(props.padding) == "number"
					then {
						all = props.padding,
					}
					else props.padding
			),
		},
		props.children
	)
end

return Pane
