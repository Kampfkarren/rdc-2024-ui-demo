export type Item = {
	name: string,
	description: string,
	icon: string,
}

local function item(x: Item): Item
	return x
end

local Items = {}

Items.strawberry = item({
	name = "Strawberry",
	description = "Most would argue it tastes more like a berry than a straw, but that's probably preferable.",
	icon = "rbxassetid://534533607",
})

Items.pepper = item({
	name = "Pepper",
	description = "Whether in a dish or in a spray, one thing can be said for sure about the pepper: it isn't salt.",
	icon = "rbxassetid://8981932662",
})

Items.watermelon = item({
	name = "Watermelon",
	description = "In an attempt to modernize, some Halloween parties have started to bob for watermelons instead.",
	icon = "rbxassetid://13259903532",
})

Items.tomato = item({
	name = "Tomato",
	description = "Scientists wonder: is it a fruit or a vegetable? We threw several at them until they stopped asking.",
	icon = "rbxassetid://9147788334",
})

return Items
