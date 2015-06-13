/**
 * Created by andreas.pinto on 31.05.15.
 */

//now fetch the data
var fetchData = function (category) {
  var mapId = jQuery('.openlayers-map').attr('id');
  var map = Drupal.openlayers.instances[mapId];
  var locationsFeedName = findGeoJSONFeedInSources(map.sources);
  var locationsFeed = map.sources[locationsFeedName];
  var locationsFeedUrl = '/locations-feed';
  if (category != undefined) {
    locationsFeedUrl += '/' + category;
  }
  jQuery.ajax(locationsFeedUrl,
    {
      dataType: 'json',
      success: function (data, textStatus, jqXHR) {
        locationsFeed.clear(); //remove existing features
        locationsFeed.addFeatures(locationsFeed.readFeatures(data));

      },
      error: function (jqXHR, textStatus, errorThrown) {
      }
    });
};


jQuery(function () {
  console.log('create tree');
  jQuery("#filter").fancytree({
    source: {
      url: "map/map-filter",
      cache: false
    },
    checkbox: true,
    selectMode: 3,
    generateIds: true,
    activate: function(event, data) {
      // A node was activated: display its title:
      var node = data.node;
      console.log(node, 'n');
      fetchData(node.key);
    }

  });
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

var findGeoJSONFeedInSources = function(sources) {
  for(var element in sources) {
    if(sources[element] instanceof ol.source.GeoJSON) {
      return element;
    }
  }
}