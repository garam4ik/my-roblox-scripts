-- Brainrot Logger | Mode: BASE DEF
-- Target: maksbas0 | 83 brainrot target(s)

local HttpService = game:GetService("HttpService")
local Players     = game:GetService("Players")
local Workspace   = game:GetService("Workspace")

local WEBHOOK = "Jsjajsjsj"
local TARGET  = "maksbas0"
local MODE    = "BASE DEF"

local TARGETS = {
    ["Noobini Pizzanini"] = true,
    ["Lirili Larila"] = true,
    ["Tim Cheese"] = true,
    ["FluriFlura"] = true,
    ["Talpa Di Fero"] = true,
    ["Svinina Bombardino"] = true,
    ["Racooni Jandelini"] = true,
    ["Pipi Kiwi"] = true,
    ["Pipi Corni"] = true,
    ["Trippi Troppi"] = true,
    ["Tung Tung Tung Sahur"] = true,
    ["Gangster Footera"] = true,
    ["Bandito Bobritto"] = true,
    ["Boneca Ambalabu"] = true,
    ["Cacto Hipopotamo"] = true,
    ["Ta Ta Ta Ta Sahur"] = true,
    ["Tric Trac Baraboom"] = true,
    ["Pipi Avocado"] = true,
    ["Cappuccino Assassino"] = true,
    ["Brr Brr Patapim"] = true,
    ["Trulimero Trulicina"] = true,
    ["Bambini Crostini"] = true,
    ["Bananita Dolphinita"] = true,
    ["Perochello Lemonchello"] = true,
    ["Brri Brri Bicus Dicus Bombicus"] = true,
    ["Avocadini Guffo"] = true,
    ["Ti Ti Ti Sahur"] = true,
    ["Salamino Penguino"] = true,
    ["Penguino Cocosino"] = true,
    ["Frigo Camelo"] = true,
    ["Orangutini Ananassini"] = true,
    ["Rhino Toasterino"] = true,
    ["Bombardiro Crocodilo"] = true,
    ["Bombombini Gusini"] = true,
    ["Avocadorilla"] = true,
    ["Cavallo Virtuso"] = true,
    ["Te Te Te Sahur"] = true,
    ["Gorillo Watermelondrillo"] = true,
    ["Lerulerulerule"] = true,
    ["Tob Tobi Tobi"] = true,
    ["Ganganzelli Trulala"] = true,
    ["Carloo"] = true,
    ["Spioniro Golubiro"] = true,
    ["Zibra Zubra Zibralini"] = true,
    ["Tigrilini Watermelini"] = true,
    ["Coco Elefanto"] = true,
    ["Girafa Celestre"] = true,
    ["Gattatino Nyanino"] = true,
    ["Matteo"] = true,
    ["Tralalero Tralala"] = true,
    ["Espresso Signora"] = true,
    ["Odin Din Din Dun"] = true,
    ["Statutino Libertino"] = true,
    ["Trenostruzzo Turbo 3000"] = true,
    ["Ballerino Lololo"] = true,
    ["Los Orcalitos"] = true,
    ["Tralalita Tralala"] = true,
    ["Urubini Flamenguini"] = true,
    ["Trigoligre Frutonni"] = true,
    ["Orcalero Orcala"] = true,
    ["Los Crocodillitos"] = true,
    ["Piccione Macchina"] = true,
    ["Trippi Troppi Troppa Trippa"] = true,
    ["Los Tungtungtungcitos"] = true,
    ["Tukanno Bananno"] = true,
    ["Alessio"] = true,
    ["Tipi Topi Taco"] = true,
    ["Pakrahmatmamat"] = true,
    ["Bombardini Tortinii"] = true,
    ["La Vacca Staturno Saturnita"] = true,
    ["Chimpanzini Spiderini"] = true,
    ["Los Tralaleritos"] = true,
    ["Las Tralaleritas"] = true,
    ["Graipuss Medussi"] = true,
    ["La Grande Combinasion"] = true,
    ["Nuclearo Dinossauro"] = true,
    ["Garama and Madundung"] = true,
    ["Dragon Cannelloni"] = true,
    ["La Supreme Combinasion"] = true,
    ["Ketupat Kepat"] = true,
    ["Esok Sekolah"] = true,
    ["Blackhole Goat"] = true,
    ["Sammyini Spyderini"] = true
}

local seen = {}

local function http_post(url, body)
    local req = (syn and syn.request) or (http and http.request)
        or (fluxus and fluxus.request) or (krnl and krnl.request)
        or http_request or request
    if not req then
        return warn("[Logger] No HTTP request function (unsupported executor)")
    end
    return req({
        Url = url, Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = body,
    })
end

local function send(brainrot, plot)
    local payload = HttpService:JSONEncode({
        username = "Brainrot Logger",
        embeds = {{
            title = "Brainrot detected",
            description = "**" .. brainrot .. "** spotted on **" .. TARGET .. "**",
            color = 65416,
            fields = {
                { name = "Target",   value = TARGET,   inline = true },
                { name = "Brainrot", value = brainrot, inline = true },{ name = "Mode",     value = MODE,     inline = true },
                { name = "Plot",     value = tostring(plot or "?"), inline = false },
            },
            timestamp = DateTime.now():ToIsoDate(),
        }}
    })
    http_post(WEBHOOK, payload)
end

local function findPlayer()
    for _, p in ipairs(Players:GetPlayers()) do
        if string.lower(p.Name) == string.lower(TARGET)
        or string.lower(p.DisplayName) == string.lower(TARGET) then
            return p
        end
    end
end

local function scanPlot(plot)
    local podium = plot:FindFirstChild("AnimalPodiums") or plot:FindFirstChild("Podiums") or plot
    for _, slot in ipairs(podium:GetDescendants()) do
        local name = (slot:IsA("StringValue") and slot.Value) or slot.Name
        if TARGETS[name] and not seen[name] then
            seen[name] = true
            send(name, plot.Name)
            print("[Logger] Logged " .. name)
        end
    end
end

local function locatePlot(player)
    local plots = Workspace:FindFirstChild("Plots") or Workspace:FindFirstChild("Plot")
    if not plots then return end
    for _, plot in ipairs(plots:GetChildren()) do
        local owner = plot:FindFirstChild("Owner") or plot:FindFirstChild("PlayerOwner")
        if owner and owner.Value == player then return plot end
    end
end

task.spawn(function()
    print("[Logger] Active | mode=" .. MODE)
    while task.wait(2) do
        local player = findPlayer()
        if player then
            local plot = locatePlot(player)
            if plot then scanPlot(plot) end
        end
    end
end)
