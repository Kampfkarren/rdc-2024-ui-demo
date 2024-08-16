export type Item = {
	name: string,
	description: string,
	icon: string,
}

local function item(x: Item): Item
	return x
end

local Items = {}

Items.magnet = item({
	name = "Magnet",
	description = "If you're not a fan of magnets, I'd consider us polar opposites.",
	icon = "rbxassetid://18974110121",
})

Items.book = item({
	name = "Book",
	description = "The cover makes it hard to know if you're reading it upside down or not, but nobody else will know either.",
	icon = "rbxassetid://18974108003",
})

Items.board = item({
	name = "Wooden Board",
	description = "A crucial part of building any home. Not this one though, you found it on the curb.",
	icon = "rbxassetid://18974105514",
})

return Items
