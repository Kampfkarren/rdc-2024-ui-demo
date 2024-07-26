local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Inventory = require(script.Parent.Inventory)
local Items = require(ReplicatedStorage.Data.Items)
local Pane = require(ReplicatedStorage.Ui.Pane)
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)

local e = React.createElement

return function(target)
	local root = ReactRoblox.createRoot(target)

	root:render(e(
		Pane,
		{
			automaticSize = Enum.AutomaticSize.XY,

			native = {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
			},
		},
		e(Inventory, {
			inventory = {
				{
					item = Items.strawberry,
					amount = 30,
				},

				{
					item = Items.pepper,
					amount = 5,
				},

				{
					item = Items.watermelon,
					amount = 9,
				},

				{
					item = Items.tomato,
					amount = 1,
				},
			},

			close = function()
				print("close")
			end,
		})
	))

	return function()
		root:unmount()
	end
end
