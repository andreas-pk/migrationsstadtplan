<?php
/**
 * @file
 * map.default_openlayers_maps.inc
 */

/**
 * Implements hook_default_openlayers_maps().
 */
function map_default_openlayers_maps() {
  $export = array();

  $ol_map = new stdClass();
  $ol_map->disabled = FALSE; /* Edit this to true to make a default ol_map disabled initially */
  $ol_map->api_version = 1;
  $ol_map->machine_name = 'locations_map';
  $ol_map->name = 'Locations map';
  $ol_map->description = '';
  $ol_map->factory_service = 'openlayers.map.internal.OLMap';
  $ol_map->options = array(
    'width' => 'auto',
    'height' => '500px',
    'view' => array(
      'center' => array(
        'lat' => '13.058607886443964',
        'lon' => '52.40368720078567',
      ),
      'rotation' => '0',
      'zoom' => '12',
      'minZoom' => '0',
      'maxZoom' => '0',
    ),
    'renderer' => 'canvas',
    'layers' => array(
      0 => 'openlayers_geofield_layer_openstreetmap',
    ),
    'sources' => array(
      0 => 'openlayers_source_mapquest_osm',
      1 => 'source_views_map_openlayers_1',
    ),
    'controls' => array(
      0 => 'openlayers_control_zoom',
    ),
    'interactions' => array(
      0 => 'openlayers_interaction_doubleclickzoom',
    ),
  );
  $export['locations_map'] = $ol_map;

  $ol_map = new stdClass();
  $ol_map->disabled = FALSE; /* Edit this to true to make a default ol_map disabled initially */
  $ol_map->api_version = 1;
  $ol_map->machine_name = 'map_views_map_page_1';
  $ol_map->name = 'Views Map: map:page_1';
  $ol_map->description = 'Map from <a href="/admin/structure/views/view/map/edit/page_1">this</a> views map';
  $ol_map->factory_service = 'openlayers.map.internal.Views';
  $ol_map->options = array(
    'views_display' => 'map:page_1',
    'view' => array(
      'center' => array(
        'lat' => '',
        'lon' => '',
      ),
      'rotation' => '0',
      'zoom' => '2',
      'minZoom' => '',
      'maxZoom' => '',
    ),
    'sources' => array(
      0 => 'source_map_views_map_page_1',
    ),
    'layers' => array(
      0 => 'layer_map_views_map_page_1',
    ),
  );
  $export['map_views_map_page_1'] = $ol_map;

  return $export;
}
