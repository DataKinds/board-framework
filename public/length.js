function commentSubmitButtonHandler() {
	var commentOK = !(commentLength > maxCommentLength || document.getElementById("comment").value.replace(/\s/g, "").length < minCommentLength);
	var imageUpload = document.getElementById("image");
	var fileOK = function() {
					if(document.getElementById("submitImageCheck").checked) {
					 	if(imageUpload.value != "") {
					 		return imageUpload.files[0].size <= maxFileSize;
					 	} else {
					 		return false;
					 	}
					 } else {
					 	return true;
					 }
				 }();
	var submitButton = document.getElementById("commentSubmit");
	if (commentOK && fileOK) {
		submitButton.disabled = false;
	} else {
		submitButton.disabled = true;
	}
}

function commentLimitHandler() {
	commentLengthBox = document.getElementById("commentLength");
	comment = document.getElementById("comment").value;
	commentLength = comment.length;
	commentLengthBox.innerHTML = commentLength + "/" + maxCommentLength;
	if(commentLength > maxCommentLength) { //too long
		commentLengthBox.setAttribute("style", "color: red;");
		document.getElementById("commentSubmit").disabled = true;
	} else if(comment.replace(/\s/g, "").length < minCommentLength) {
		commentLengthBox.innerHTML = commentLength + "/" + maxCommentLength + " (you need at least " + minCommentLength + " letters to post)";
		commentLengthBox.setAttribute("style", "color: red;");
		document.getElementById("commentSubmit").disabled = true;
	} else { //of a good posting length
		commentLengthBox.setAttribute("style", "");
		document.getElementById("commentSubmit").disabled = false;
	}
	commentSubmitButtonHandler();
}

function postSubmitButtonHandler() {
	var titleOK = !(titleLength > maxTitleLength || document.getElementById("title").value.replace(/\s/g, "").length < minTitleLength);
	var bodyOK = !(bodyLength > maxBodyLength || document.getElementById("body").value.replace(/\s/g, "").length < minBodyLength);
	var fileOK = document.getElementById("fileInput").files[0].size <= maxFileSize;
	var submitButton = document.getElementById("submitButton");
	if (titleOK && bodyOK && fileOK) {
		submitButton.disabled = false;
		submitButton.setAttribute("style", "background: green");
	} else {
		submitButton.disabled = true;
		submitButton.setAttribute("style", "background: white");
	}
}

function titleLimitHandler() {
	titleLengthBox = document.getElementById("titleLength");
	title = document.getElementById("title").value;
	titleLength = title.length;
	titleLengthBox.innerHTML = titleLength + "/" + maxTitleLength;
	submitButton = document.getElementById("submitButton");
	if(titleLength > maxTitleLength) { //too long
		titleLengthBox.setAttribute("style", "color: red;");
	} else if(title.replace(/\s/g, "").length < minTitleLength) {
		titleLengthBox.innerHTML = titleLength + "/" + maxTitleLength + " (you need at least " + minTitleLength + " letters to post)";
		titleLengthBox.setAttribute("style", "color: red;");
	} else { //of a good posting length
		titleLengthBox.setAttribute("style", "");
	}
	postSubmitButtonHandler();
}

function bodyLimitHandler() {
	bodyLengthBox = document.getElementById("bodyLength");
	body = document.getElementById("body").value;
	bodyLength = body.length;
	bodyLengthBox.innerHTML = "&nbsp;" + bodyLength + "/" + maxBodyLength;
	submitButton = document.getElementById("submitButton");
	if(bodyLength > maxBodyLength) { //too long
		bodyLengthBox.setAttribute("style", "color: red;");
	} else if(body.replace(/\s/g, "").length < minBodyLength) {
		bodyLengthBox.innerHTML = "&nbsp;" + bodyLength + "/" + maxBodyLength + " (you need at least " + minBodyLength + " letters to post)";
		bodyLengthBox.setAttribute("style", "color: red;");
	} else { //of a good posting length
		bodyLengthBox.setAttribute("style", "");
	}
	postSubmitButtonHandler();
}