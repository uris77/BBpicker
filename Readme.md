# BBPicker
A small Marionettejs component for uploading images with filepicker.

# Usage
1. You need to have an account and api key from [Inkfilepicker](http://inkfilepicker.com) in order to use this utility.
2. Import the inkfilepicker js library as stated in their [docs](https://developers.inkfilepicker.com/docs/web/).
4. Set the API Key that was assigned to you:
```javascript
filepicker.setKey("AN_API_KEY");
```
5. Start the BBPicker Application:
```javascript
Backpicker.start();
```
6. Create a callback that is executed when the file is uploaded successfully.
```javascript
var callback = function(optionalArgs){
   ....
}
```
This callback will be passed the result from a successful upload. This contains the url of the file amongst other details.
You can process this information within the callback (e.g. saving the url in a database).

7. Render the view. You can either render directly unto a div:
```javascript
var view = Backpicker.show(callback, context, options);
$('#myDiv').append(view.render().el);
```
Or you can you render within a Marionettejs Layout:
```javascript
var layout = new MyLayout();
var view = Backpicker.show(callback, this, options);
layout.imageRegion.show(view);
```
8. You can also style the image placeholder by passing a 'className' value:
```javascript
var view = Backpicker.show(callback, context, {className: 'someCssClass'});

## Requirements
* Nodejs
* npm
* gruntjs

## License
[GPLv3](http://www.gnu.org/licenses/gpl-3.0.html)