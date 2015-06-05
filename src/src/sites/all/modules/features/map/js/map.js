/**
 * Created by andreas.pinto on 31.05.15.
 */

//now fetch the data
var fetchData = function () {
  var locations_feed = new ol.source.GeoJSON();

  jQuery.ajax('/locations-feed',
    {
      dataType: 'json',
      success: function (data, textStatus, jqXHR) {
        locations_feed.clear(); //remove existing features
        locations_feed.addFeatures(locations_feed.readFeatures(data));
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.log(errorThrown);
      }
    });

  //call this again in 5 seconds time
  //updateTimer = setTimeout(function () {
  //    fetchData();
  //}, 5000);
};
fetchData(); //must actually call the function!

jQuery(function () {
  console.log('create tree');
  jQuery('div#chosentree').chosentree({
    width: 500,
    deepLoad: true,
    load: function (node, callback) {
        return dummyData();
     }
  });
});

var dummyData = function() {
  var data = '"employees":[{"firstName":"John", "lastName":"Doe"},{"firstName":"Anna", "lastName":"Smith"},{"firstName":"Peter","lastName":"Jones"}]';
  return data;
};