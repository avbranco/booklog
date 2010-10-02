$(function() {
	$('#fetch').click(function(e) {
		e.preventDefault();
		$.ajax({
			url: this + '',
			dataType: 'script',
			data: { isbn: $('#book_isbn').val() || $('#book_isbn13').val() },
			beforeSend: function() {
				$('#notice').html('');
				$('#fetch').hide().after("<img id='loading' src='/images/loading.png' />");
			},
			complete: function() {
				$('#loading').remove();
				$('#fetch').show();
			}
		});
	});
});