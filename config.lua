Config = {}

Config.firstinstall = false -- Set it to true for first installation!

Config.CoreName = "qb-core"
Config.TargetName = "qb-target" -- Supports QB target only, new options will be in new updates
Config.ServerPrefix = "QBCore"

function Config.Fuel(veh,fuelnumber)
    exports['qb-fuel']:SetFuel(veh, fuelnumber)
end

Config.Garages = {
    ["police"] = {
        garageName = "L.S.P.D Garage",
        buyVehicleLocationPed = vector4(446.60391, -1011.192, 28.522699, 181.08587),
        spawnLocation = vector4(455.28576, -1023.582, 28.456205, 47.567989),
        ped = "s_m_y_cop_01",
        logo = './images/lspdnobackground.png',
        plateStart = 'POL', -- First 3 letters of your license.
        Vehicles = {
            [1] = {
                model = "npolvic",
                name = "Ford Victoria",
                price = 5000,
                image = "./images/victoria.png",
                -- You can change the image from path to a link as well
            },
            [2] = {
                model = "npolexp",
                name = "Ford Explorer",
                price = 15000,
                image = "./images/explorer.png",
            },
            [3] = {
                model = "npolstang",
                name = "Ford Mustang",
                price = 25000,
                image = "./images/mustang.png",
            },
            [4] = {
                model = "npolchar",
                name = "Dodge Charger",
                price = 25000,
                image = "https://media.discordapp.net/attachments/1028221434666954763/1183062859085783171/charger.jpeg?ex=6586f825&is=65748325&hm=149e0f5137dbb34a97c60ac88d2dd1fe108a4fa1c2377a1646a1e6dc03aee74e&=&format=webp&width=1193&height=671",
            },
            [5] = {
                model = "npolmm",
                name = "Police Bike",
                price = 25000,
                image = "https://media.discordapp.net/attachments/1032367722182496296/1183087368425701447/image.png?ex=65870ef9&is=657499f9&hm=4bef6b5bb20f5d3b027bc9e7505549e1a664d36e6a26adffac7b3ef94a3e7825&=&format=webp&quality=lossless&width=987&height=671",
            },
            [6] = {
                model = "bcat",
                name = "Swat Riot",
                price = 25000,
                image = "https://media.discordapp.net/attachments/1032367722182496296/1183084680338231377/872145-bcatpic.png?ex=65870c78&is=65749778&hm=cbd697f3f4183e5f7e5cd966eaa0487910f77f2b82a8fdd1c5fc5b330a096207&=&format=webp&quality=lossless&width=1090&height=671",
            },
            [7] = {
                model = "npolvette",
                name = "Chevrolet Corvette",
                price = 25000,
                image = "https://media.discordapp.net/attachments/1032367722182496296/1183088788906455112/image.png?ex=6587104c&is=65749b4c&hm=d06462b7e1fb65cdde8a6c1a7cb33f5adc46d91b244f147cafa6f0db23911cbc&=&format=webp&quality=lossless",
            },
        }
    },
    ["ambulance"] = {
        garageName = "E.M.S Garage",
        buyVehicleLocationPed = vector4(337.07354, -578.3853, 28.566738, 340.49267),
        spawnLocation = vector4(455.28576, -1023.582, 28.456205, 47.567989),
        ped = "s_f_y_scrubs_01",
        logo = 'https://brookfieldfd.com/wp-content/uploads/2014/09/blue_star_of_life_medical_symbol.png',
        plateStart = 'EMS', -- First *3* letters of your license.
        Vehicles = {
            [1] = {
                model = "ambulance",
                name = "Ambulance",
                price = 5000,
                image = "https://cdn.redneckmods.com/img/RedneckScreenshots/2019Generic4500ClassMultifunctionVanAmbulance/20.png",
            },
            [2] = {
                model = "ambulance",
                name = "Dodge Charger",
                price = 5000,
                image = "https://img.gta5-mods.com/q95/images/dodge-charger-rt-ems-for-fivem-and-sp/18f6fe-3.jpg",
            },
            [3] = {
                model = "ambulance",
                name = "Sedan",
                price = 5000,
                image = "https://media.indiedb.com/images/articles/1/297/296982/auto/c20de91e000ba2912daf.jpg",
            },
            [4] = {
                model = "ambulance",
                name = "Ford Explorer",
                price = 5000,
                image = "https://media.discordapp.net/attachments/421702737739120643/1184916766330200145/Battalion_Chief_FPIU_Front_Lights.png?ex=658db6bb&is=657b41bb&hm=e854b0f8aa7f5515c5e3c971c827da6bcd31b138c23dd5b4f1a9fd03fcf02fdc&=&format=webp&quality=lossless&width=1194&height=671",
            },
        }
    },
}

Config.lang = {
    nomoney = "You have no money to purchase this vehicle.",
    buyvehicle = "You have successfuly purchased this vehicle."
}