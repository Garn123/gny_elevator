Config = {}

Config.Elevators = {
    ['PillBox Hospital'] = {                                      --Hospital name, title for the menu
        [1] = {
            name = 'pillbox1',                                    --Unique elevator name
            title = 'Roof',                                       --Title shown in the menu
            coords = vector4(338.779, -583.936, 74.166, 247.307), --spawn cords, it has to be vector4, last value is heading
            jobs = { 'ambulance' }                                --Job table able to see this teleport option, nil to disable
        },
        [2] = {
            name = 'pillbox2',
            title = 'Entrance',
            coords = vector4(298.289, -584.525, 43.261, 77.897),
            jobs = nil
        },
        [3] = {
            name = 'pillbox3',
            title = 'Garage',
            coords = vector4(319.686, -559.799, 28.744, 23.296),
            jobs = nil
        },
    },
    --To create more elevators, copy and paste format below
}
