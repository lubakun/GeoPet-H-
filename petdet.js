

var VisualRecognitionV3 = require('watson-developer-cloud/visual-recognition/v3');
var fs = require('fs');

var visualRecognition = new VisualRecognitionV3({
	version: '2018-03-19',
	iam_apikey: 'w9W3gJwDfHVPPBlqqBbOl0mGehBGVnMYArZ5N3YnVbg0'
});

var images_file= fs.createReadStream('./perro.jpg');
var classifier_ids = ["DefaultCustomModel_1777506609"];
var threshold = 0.6;

var params = {
	images_file: images_file,
	classifier_ids: classifier_ids,
	threshold: threshold
};

visualRecognition.classify(params, function(err, response) {
	if (err) { 
		console.log(err);
	} else {
        var x = JSON.stringify(response, null, 2);
        
        console.log("Class: %j", x.classes.class);
        
	}
});