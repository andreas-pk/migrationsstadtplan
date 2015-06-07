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
  jQuery('div#chosentree');
});


var getFilters = function() {
  //var data_org = jQuery.extend(true, {}, node);
  //loadChildren(data_org, 0);
  //console.log(data_org.children, 'org data');


  jQuery.ajax('map/map-filter', {
    dataType: 'json',
    success: function (data, textStatus, jqXHR) {

     jQuery.each(data, function(index){
       this.level = 1;
       this.has_children = 0;
       this.children = [];
      });
      console.log(data, 'requested data');
      return data;
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.log(errorThrown);
    }
  });
};