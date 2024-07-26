local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Pane = require(ReplicatedStorage.Ui.Pane)
local React = require(ReplicatedStorage.Packages.React)
local Styles = require(ReplicatedStorage.Ui.Styles)
local TextButton = require(ReplicatedStorage.Ui.TextButton)

local e = React.createElement

local function CloseButton(props: {
	onClick: () -> (),
})
	return e(
		Pane,
		{
			native = {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(1, -12, 0, 12),
				Size = UDim2.fromOffset(48, 48),
			},
		},
		e(TextButton, {
			text = "X",
			textSize = Styles.textSizes.bigger,

			palette = Styles.colors.red,

			size = UDim2.fromOffset(48, 48),

			onClick = props.onClick,
		})
	)
end

return CloseButton
