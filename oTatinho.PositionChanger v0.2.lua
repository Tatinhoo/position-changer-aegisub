-- Position Changer versão 0.2, feito por oTatinho (@otatinhoo)
-- A função dessa automação é mudar a posição de uma linha no Aegisub
-- É possível usar presets de resoluções ou inserir a posição desejada

local automation_name = "⭐ Position Changer v0.2 ⭐"
local automation_description = "This automation by oTatinho changes the subtitle position to the desired one."
local x_value, y_value;

-- Função que cria a janela UI de Presets
function openPresetsTab(subs, sel)

    local presetsTab = {
        -- Cria a label "Tamanho do vídeo" na posição (0,0)
        { 
            class = "label", 
            label = "Tamanho do vídeo:", 
            x = 0, y = 0 
        },
        -- Cria o dropdown com as escolhas de resolução na posição (0,1)
        { 
            class = "dropdown", 
            name = "resolution", 
            x = 0, y = 1, 
            width = 20, 
            items = {"1280x720", "1920x1080"},
            value = "1280x720"
        },
    }
    -- Cria os botões de Aplicar e Cancelar a ação
    local presetsTabButton, opcao = aegisub.dialog.display(presetsTab, {"Aplicar", "Cancelar"});

    -- Verifica se o botão "Aplicar" foi apertado
    if presetsTabButton == "Aplicar" then

        -- Faz a verificação das resoluções via dropdown
        if opcao.resolution == "1280x720" then
            -- Atualiza as variaveis usadas para definir a posição da linha
            x_value = 640;
            y_value = 710;
            positionChanger(subs, sel)
        end
        if opcao.resolution == "1920x1080" then
            -- Atualiza as variaveis usadas para definir a posição da linha
            x_value = 960;
            y_value = 1070;
            positionChanger(subs, sel)
        end
    end

    -- Verifica se o botão "Cancelar" foi apertado
    if presetsTabButton == "Cancelar" then
        -- Envia uma mensagem de debug falando que a ação foi cancelada
        aegisub.debug.out("Ação cancelada!")
    end
end

function openConfigTab(subs, sel)
     local configTab = {
        -- Cria a label "X:" que antecede o campo de texto na posição (0,0)         
        {
            class = "label",
            label = "X:",
            x = 0, y = 1;
        },
        -- Cria o campo de texto para inserir a posição X desejada na posição (1,1)
        {
            class = "edit",
            name = "x_coord",
            x = 1, y = 1;
            width = 20
        },
        -- Cria a label "Y:" que antecede o campo de texto na posição (0,0)   
        {
            class = "label",
            label = "Y:",
            x = 0, y = 2;
        },
        -- Cria o campo de texto para inserir a posição Y desejada posição (1,2)
        {
            class = "edit",
            name = "y_coord",
            x = 1, y = 2;
            width = 20
        }
    }
    local configTabButton, result = aegisub.dialog.display(configTab, {"Aplicar", "Cancelar"});
         -- Verifica se o botão "Aplicar" foi apertado
    if configTabButton == "Aplicar" then
        -- Atualiza as variaveis usadas para definir a posição da linha
        x_value = result.x_coord;
        y_value = result.y_coord;
        positionChanger(subs, sel)

    end

end

function openMainTab(subs, sel)
    -- Janela UI da tela inicial da automação
    local mainTab = {
        -- Cria a label do topo "Escolha..." na posição (0,0)
        {
            class = "label",
            label = "Escolha a opção desejada",
            x = 0, y = 0;
        }
    }
    --Criando os botões de opção "Presets" e "Configurar"
    local mainTabButton = aegisub.dialog.display(mainTab, {"Presets", "Configurar"});

    -- Se a opção escolhida for a de Presets
    if mainTabButton == "Presets" then
    -- Abre a janela UI de Presets
        openPresetsTab(subs, sel)
    end

    -- Se a opção escolhida for a de Configurar
    if mainTabButton == "Configurar" then
        -- Abre a janela UI de Configurar
        openConfigTab(subs, sel)
    end

end

function positionChanger(subs, sel)
    for i, sub in ipairs(sel) do
        local line = subs[sub]
        line.text = "{\\pos(".. x_value ..",".. y_value ..")}".. line.text
        subs[sub] = line
    end
end

aegisub.register_macro(automation_name, automation_description, openMainTab)