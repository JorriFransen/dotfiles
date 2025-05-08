return require("telescope").register_extension {
    setup = function(ext_config, config)
    end,
    exports = {
        colorpicker = require("colorpicker").colorpicker
    }
}
