local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Items = require(ReplicatedStorage.Data.Items)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

local function ItemIcon(props: {
	item: Items.Item,
})
	return e("ImageLabel", {
		BackgroundTransparency = 1,
		Image = props.item.icon,
		Size = UDim2.fromScale(1, 1),
	}, {
		UIAspectRatioConstraint = e("UIAspectRatioConstraint"),
	})
end

return ItemIcon
