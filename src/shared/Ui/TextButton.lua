local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

local Label = require(ReplicatedStorage.Ui.Label)
local Pane = require(ReplicatedStorage.Ui.Pane)
local React = require(ReplicatedStorage.Packages.React)
local Stroke = require(ReplicatedStorage.Ui.Stroke)
local Styles = require(ReplicatedStorage.Ui.Styles)

local e = React.createElement

local FONT = Enum.Font.LuckiestGuy
local PADDING_HORIZONTAL = 15
local PADDING_VERTICAL = 8

local function TextButton(props: {
	text: string,
	textSize: number?,

	palette: Styles.Palette,

	layoutOrder: number?,
	size: UDim2?,

	onClick: () -> (),
})
	local textSize = props.textSize or Styles.textSizes.buttons

	local calculatedTextSize = React.useMemo(function()
		return TextService:GetTextSize(props.text, textSize, FONT, Vector2.new(math.huge, math.huge))
	end, { props.text, textSize } :: { unknown })

	return e(Pane, {
		layoutOrder = props.layoutOrder,

		native = {
			Size = props.size
				or UDim2.fromOffset(calculatedTextSize.X + PADDING_HORIZONTAL * 2, textSize + PADDING_VERTICAL * 2),
		},
	}, {
		Button = e(Pane, {
			onClick = props.onClick,

			background = ColorSequence.new({
				ColorSequenceKeypoint.new(0.0, props.palette.fill.light),
				ColorSequenceKeypoint.new(0.4, props.palette.fill.mid),
				ColorSequenceKeypoint.new(0.6, props.palette.fill.dark),
				ColorSequenceKeypoint.new(1.0, props.palette.fill.dark),
			}),

			cornerRadius = Styles.corners.mid,

			native = {
				ZIndex = 2,
			},
		}, {
			Stroke = e(Stroke, {
				color = ColorSequence.new(props.palette.stroke.light, props.palette.stroke.mid),
			}),

			Label = e(Label, {
				text = props.text,
				textSize = textSize,
				font = FONT,
				color = props.palette.text,

				native = {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, 4),
				},
			}),
		}),

		Shadow = e(Pane, {
			background = props.palette.stroke.dark,
			cornerRadius = Styles.corners.mid,

			native = {
				Position = UDim2.fromOffset(0, 4),
			},
		}, {
			Stroke = e(Stroke, {
				color = props.palette.stroke.dark,
			}),
		}),
	})
end

return TextButton
