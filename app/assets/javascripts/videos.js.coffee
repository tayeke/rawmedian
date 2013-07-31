$ ->
	$('a[href="#contact"]').click ->
		$text = $('#contactForm h2')
		setTimeout ->
			old_color = $text.css('color')
			$text.css {color: '#840002'}, 250
			setTimeout ->
				$text.css {color: old_color}, 500
			, 250
		, 250