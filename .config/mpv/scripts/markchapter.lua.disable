-- usage at input.conf, add e.g. "M script_message mark-chapter"
mp.register_script_message("mark-chapter", function()
	local time_pos = mp.get_property_number("time-pos")
	local curr_chapter = mp.get_property_number("chapter")
	local chapter_count = mp.get_property_number("chapter-list/count")
	local all_chapters = mp.get_property_native("chapter-list")

	-- the script will bork if we don't already have chapters
	-- this special case just creates one chapter
	if chapter_count == 0 then
		all_chapters[1] = {title=(tostring(time_pos)), time=time_pos}

		-- We just set it to zero here so when we add 1 later it ends up as 1
		-- otherwise it's probably "nil"
		curr_chapter = 0

		-- note that mpv will treat the beginning of the file as all_chapters[0] when using pageup/pagedown
		-- so we don't actually have to worry if the file doesn't start with a chapter
	else

		-- to insert a chapter we have to increase the index on all subsequent chapters
		-- otherwise we'll end up with duplicate chapter IDs which will confuse mpv

		-- +2 looks weird, but remember mpv indexes at 0 and lua indexes at 1
		-- adding two will turn "current chapter" from mpv notation into "next chapter" from lua's notation

		-- count down because these areas of memory overlap
		for i=chapter_count,curr_chapter+2,-1 do

			all_chapters[i + 1] = all_chapters[i]
		end

		-- again the +2 is because we want to insert the chapter as a new one after the "current one"
		all_chapters[curr_chapter+2] = {title=(tostring(time_pos)), time=time_pos}
	end


	mp.set_property_native("chapter-list", all_chapters)
	
	-- We increment the chatper count so it's now the chapter we just created
	mp.set_property_number("chapter", curr_chapter+1)
	
end)
