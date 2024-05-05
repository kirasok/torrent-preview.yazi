local M = {}

function M:peek()
	-- launch process
	local process, code = Command("transmission-show")
		:args({
			tostring(self.file.url),
		})
		:stdout(Command.PIPED)
		:spawn()

	local limit = self.area.h
	-- read and count lines from process
	local i, lines = 0, ""
	repeat
		local next, event = process:read_line()
		if event ~= 0 then
			break
		end

		i = i + 1
		-- only concatenate lines that are past 'skip' number of STDOUT
		if i > self.skip then
			lines = lines .. next
		end
	until i >= self.skip + limit -- until reader reaches max number of lines on screen plus skip

	process:start_kill()

	-- if paged below all output, run peek again with smaller skip
	if self.skip > 0 and i < self.skip + limit then
		ya.manager_emit(
			"peek",
			{ tostring(math.max(0, i - limit)), only_if = tostring(self.file.url), upper_bound = "" }
		)
	-- preview torrent
	else
		ya.preview_widgets(self, { ui.Paragraph.parse(self.area, lines):wrap(ui.Paragraph.WRAP) })
	end
end

function M:seek(units)
	local h = cx.active.current.hovered
	if h and h.url == self.file.url then
		local step = math.floor(units * self.area.h / 10)
		ya.manager_emit("peek", {
			math.max(0, cx.active.preview.skip + step),
			only_if = self.file.url,
		})
	end
end

return M
