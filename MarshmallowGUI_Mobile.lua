-- Mobile-Optimized Marshmallow Cooking System GUI

local MarshmallowGUI = {}

function MarshmallowGUI:Create()
    -- Create main frame for the GUI
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundColor3 = Color3.new(1, 1, 1)

    -- Create title label
titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Text = "Marshmallow Cooking System"
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)

    -- Create button to start cooking
    local cookButton = Instance.new("TextButton", frame)
    cookButton.Text = "Cook Marshmallow"
    cookButton.Size = UDim2.new(0.5, 0, 0.2, 0)
    cookButton.Position = UDim2.new(0.25, 0, 0.3, 0)
    cookButton.BackgroundColor3 = Color3.new(0, 1, 0)

    return frame
end

return MarshmallowGUI