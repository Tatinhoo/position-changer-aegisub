-- Position Changer versão 0.1, feito por oTatinho (@otatinhoo)
-- A função dessa automação é mudar a posição de uma linha no Aegisub

local automation_name = "⭐ Position Changer v0.1 ⭐"
local automation_description = "This automation by oTatinho changes the subtitle position to the desired one."

function positionChanger(subs, sel)

    local interface = {
        {
            class = "label",
            label = "Insira a posição",
            x = 0, y = 0;
        },
        {
            class = "label",
            label = "X:",
            x = 0, y = 1;
        },
        {
            class = "edit",
            name = "x_value",
            x = 1, y = 1;
            width = 20
        },
        {
            class = "label",
            label = "Y:",
            x = 0, y = 2;
        },
        {
            class = "edit",
            name = "y_value",
            x = 1, y = 2;
            width = 20
        }
    }
    local canceled = {
        {
            class = "label",
            label = "Ação cancelada",
        }
    }
local button, result = aegisub.dialog.display(interface, {"Apply", "Cancel"})

    if button == "Apply" then
        local x_value = result.x_value;
        local y_value = result.y_value;

        for i, sub in ipairs(sel) do
            local line = subs[sub]
            line.text = "{\\pos(".. x_value ..",".. y_value ..")}".. line.text
            subs[sub] = line
        end
    else
        aegisub.dialog.display(canceled, {"Ação cancelada"})
    end 
end

aegisub.register_macro(automation_name, automation_description, positionChanger)

