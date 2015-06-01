var postWindowOpen = false;

function cancelPost() {
	document.body.removeChild(document.getElementById("postFormHolder"));
	document.body.removeChild(document.getElementById("shade"));
	postWindowOpen = false;
}

function displayPostForm() {
	if(!postWindowOpen) {
		postWindowOpen = true;
		var shade =document.createElement("div");
		shade.setAttribute("class", "darken");
		shade.setAttribute("id", "shade");
		shade.setAttribute("onclick", "cancelPost()");
		document.body.appendChild(shade);

		var postFormHolder = document.createElement("div");
		postFormHolder.setAttribute("class", "postFormHolder");
		postFormHolder.setAttribute("id", "postFormHolder");
		document.body.appendChild(postFormHolder);
		var postForm = document.createElement("form");
		postForm.setAttribute("action", "/createpost");
		postForm.setAttribute("method", "post");
		postForm.setAttribute("class", "postForm");
		postForm.setAttribute("autocomplete", "off");
		postFormHolder.appendChild(postForm);

		var titleHolder = document.createElement("div");
		postForm.appendChild(titleHolder);
		//var titleLabel = document.createElement("label");
		//titleLabel.setAttribute("for", "title");
		//titleLabel.innerHTML = "Title:";
		//titleHolder.appendChild(titleLabel);
		var titleInput = document.createElement("input");
		titleInput.setAttribute("type", "text");
		titleInput.setAttribute("id", "title");
		titleInput.setAttribute("name", "title");
		titleInput.setAttribute("class", "titleInput");
		titleInput.setAttribute("placeholder", "Title here...");
		titleInput.setAttribute("autocomplete", "off");
		titleInput.setAttribute("onkeypress", "return(event.keyCode != 13)") //disallow enter
		titleHolder.appendChild(titleInput);

		var bodyHolder = document.createElement("div");
		postForm.appendChild(bodyHolder);
		//var bodyLabel = document.createElement("label");
		//bodyLabel.setAttribute("for", "body");
		//bodyLabel.innerHTML = "Body:";
		//bodyHolder.appendChild(bodyLabel);
		var bodyInput = document.createElement("textarea");
		bodyInput.setAttribute("type", "text");
		bodyInput.setAttribute("id", "body");
		bodyInput.setAttribute("name", "body");
		bodyInput.setAttribute("class", "bodyInput");
		bodyInput.setAttribute("placeholder", "Body here...");
		bodyInput.setAttribute("autocomplete", "off");
		bodyHolder.appendChild(bodyInput);

		var submit = document.createElement("button");
		submit.setAttribute("type", "submit");
		submit.setAttribute("class", "submitButton");
		submit.innerHTML = "Submit";
		postForm.appendChild(submit);

		var cancel = document.createElement("button");
		cancel.setAttribute("type", "button");
		cancel.setAttribute("class", "cancelButton");
		cancel.setAttribute("onclick", "cancelPost()");
		cancel.innerHTML = "Cancel";
		postForm.appendChild(cancel);
	}
}
