<?php
/**
 * @file
 * map.default_openlayers_layers.inc
 */

/**
 * Implements hook_default_openlayers_layers().
 */
function map_default_openlayers_layers() {
  $export = array();

  $ol_layer = new stdClass();
  $ol_layer->disabled = FALSE; /* Edit this to true to make a default ol_layer disabled initially */
  $ol_layer->api_version = 1;
  $ol_layer->machine_name = 'layer_map_views_map_page_1';
  $ol_layer->name = 'Views Map:map:page_1';
  $ol_layer->description = 'Layer for <a href="/admin/structure/views/view/map/edit/page_1">this</a> views map';
  $ol_layer->factory_service = 'openlayers.layer.internal.Vector';
  $ol_layer->options = array(
    'source' => 'source_map_views_map_page_1',
  );
  $export['layer_map_views_map_page_1'] = $ol_layer;

  return $export;
}
