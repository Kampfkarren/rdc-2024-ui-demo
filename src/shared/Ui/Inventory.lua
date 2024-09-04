local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CloseButton = require(ReplicatedStorage.Ui.CloseButton)
local ItemIcon = require(ReplicatedStorage.Ui.ItemIcon)
local Items = require(ReplicatedStorage.Data.Items)
local Label = require(ReplicatedStorage.Ui.Label)
local Pane = require(ReplicatedStorage.Ui.Pane)
local React = require(ReplicatedStorage.Packages.React)
local Stroke = require(ReplicatedStorage.Ui.Stroke)
local Styles = require(ReplicatedStorage.Ui.Styles)
local TextButton = require(ReplicatedStorage.Ui.TextButton)
local createNextOrder = require(ReplicatedStorage.Libraries.createNextOrder)

local e = React.createElement

local INVENTORY_PALETTE = Styles.colors.yellow
local INVENTORY_SLOTS = 16

local function Inventory(props: {
	inventory: {
		{
			item: Items.Item,
			amount: number,
		}
	},

	close: () -> (),
})
	local selectedSlot, setSelectedSlot = React.useState(1)
	local selectedItem = props.inventory[selectedSlot].item

	local nextOrder = createNextOrder()

	local inventorySlots: { [string]: React.Node } = {}
	for slot = 1, INVENTORY_SLOTS do
		local inventoryItem = props.inventory[slot]

		inventorySlots[`InventoryItem{slot}`] = e(Pane, {
			background = INVENTORY_PALETTE.stroke.light,
			cornerRadius = Styles.corners.mid,
			layoutOrder = nextOrder(),

			onClick = inventoryItem and function()
				setSelectedSlot(slot)
			end,

			native = {
				Size = UDim2.fromOffset(64, 64),
			},
		}, {
			Inner = e(Pane, {
				padding = 8,
			}, {
				SelectedBackground = slot == selectedSlot and e(Pane, {
					background = INVENTORY_PALETTE.fill.light,
					cornerRadius = UDim.new(1, 0),

					native = {
						BackgroundTransparency = 0.5,
						ZIndex = nextOrder(),
					},
				}),

				ItemIcon = inventoryItem and e(
					Pane,
					{
						native = {
							ZIndex = nextOrder(),
						},
					},
					e(ItemIcon, {
						item = inventoryItem.item,
					})
				),
			}),

			Quantity = inventoryItem and e(
				Pane,
				{
					automaticSize = Enum.AutomaticSize.XY,
					background = if slot == selectedSlot
						then INVENTORY_PALETTE.fill.light
						else INVENTORY_PALETTE.stroke.dark,
					cornerRadius = Styles.corners.mid,

					padding = {
						horizontal = 8,
					},

					native = {
						AnchorPoint = Vector2.new(1, 0.5),
						Position = UDim2.new(1, 4, 1, -8),
						Rotation = -10,
					},
				},
				e(Label, {
					text = `x{inventoryItem.amount}`,
					textSize = Styles.textSizes.tooltip,
					color = if slot == selectedSlot then INVENTORY_PALETTE.text else INVENTORY_PALETTE.fill.light,
					font = Enum.Font.Cartoon,
				})
			),
		})
	end

	return e(Pane, {
		background = ColorSequence.new(INVENTORY_PALETTE.fill.mid, INVENTORY_PALETTE.fill.dark),
		cornerRadius = Styles.corners.large,

		native = {
			Size = UDim2.fromOffset(600, 362),
		},
	}, {
		Stroke = e(Stroke, {
			color = ColorSequence.new(INVENTORY_PALETTE.stroke.light, INVENTORY_PALETTE.stroke.mid),
		}),

		CloseButton = e(CloseButton, {
			onClick = props.close,
		}),

		InventoryLabel = e(Label, {
			text = "Inventory",
			textSize = Styles.textSizes.title,
			font = Enum.Font.LuckiestGuy,

			color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Styles.colors.platinum.fill.light),
				ColorSequenceKeypoint.new(0.4, Styles.colors.platinum.fill.mid),
				ColorSequenceKeypoint.new(0.6, Styles.colors.platinum.fill.dark),
				ColorSequenceKeypoint.new(1.0, Styles.colors.platinum.fill.dark),
			}),

			stroke = Styles.colors.platinum.text,
			dropShadows = 2,

			native = {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0, 12),
			},
		}),

		Contents = e(Pane, {
			layout = Enum.FillDirection.Vertical,
			spacing = 32,

			native = {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.5, 0, 1, -16),
				Size = UDim2.new(1, -32, 1, -66),
			},
		}, {
			Inventory = e(Pane, {
				layoutOrder = nextOrder(),
				flexMode = Enum.UIFlexMode.Shrink,

				layout = Enum.FillDirection.Horizontal,
				layoutWraps = true,
				spacing = 8,
			}, inventorySlots),

			Bottom = e(Pane, {
				layoutOrder = nextOrder(),

				layout = Enum.FillDirection.Horizontal,
				spacing = 16,

				native = {
					Size = UDim2.new(1, 0, 0, 128),
				},
			}, {
				Preview = e(Pane, {
					background = INVENTORY_PALETTE.stroke.light,
					cornerRadius = Styles.corners.mid,
					layoutOrder = nextOrder(),
					aspectRatio = 1,
					padding = 16,
				}, {
					ItemIcon = e(ItemIcon, {
						item = selectedItem,
					}),
				}),

				Details = e(Pane, {
					layoutOrder = nextOrder(),
					flexMode = Enum.UIFlexMode.Fill,

					layout = Enum.FillDirection.Vertical,
					spacing = 4,
				}, {
					Name = e(Label, {
						text = selectedItem.name,
						textSize = Styles.textSizes.header,
						font = Enum.Font.LuckiestGuy,
						color = INVENTORY_PALETTE.text,
					}),

					Description = e(Label, {
						text = selectedItem.description,
						textSize = Styles.textSizes.body,
						font = Enum.Font.Cartoon,
						color = INVENTORY_PALETTE.text,

						wrap = true,
					}, {
						UIFlexItem = e("UIFlexItem", {
							FlexMode = Enum.UIFlexMode.Fill,
						}),
					}),

					Actions = e(Pane, {
						automaticSize = Enum.AutomaticSize.XY,
						layoutOrder = nextOrder(),

						layout = Enum.FillDirection.Horizontal,
						spacing = 13,
					}, {
						Equip = e(TextButton, {
							text = "EQUIP",
							palette = Styles.colors.green,
							layoutOrder = nextOrder(),

							onClick = function()
								-- Behavior...
							end,
						}),

						Give = e(TextButton, {
							text = "GIVE",
							palette = Styles.colors.platinum,
							layoutOrder = nextOrder(),

							onClick = function()
								-- Behavior...
							end,
						}),

						Throw = e(TextButton, {
							text = "THROW",
							palette = Styles.colors.platinum,
							layoutOrder = nextOrder(),

							onClick = function()
								-- Behavior...
							end,
						}),
					}),
				}),
			}),
		}),
	})
end

return Inventory
