local M = {}

function M:peek()
	local output, code = Command("transmission-show")
		:args({
			tostring(self.file.url),
		})
		:stdout(Command.PIPED)
		:output()

	local p
	p = ui.Paragraph.parse(self.area, output.stdout)

	ya.preview_widgets(self, { p:wrap(ui.Paragraph.WRAP) })
end

function M:seek() end

return M
