<?php
/**
 * @file
 * map.default_openlayers_sources.inc
 */

/**
 * Implements hook_default_openlayers_sources().
 */
function map_default_openlayers_sources() {
  $export = array();

  $ol_source = new stdClass();
  $ol_source->disabled = FALSE; /* Edit this to true to make a default ol_source disabled initially */
  $ol_source->api_version = 1;
  $ol_source->machine_name = 'source_map_views_map_page_1';
  $ol_source->name = 'Views Map: map:page_1';
  $ol_source->description = 'Source for <a href="/admin/structure/views/view/map/edit/page_1">this</a> views map';
  $ol_source->factory_service = 'openlayers.source.internal.Vector';
  $ol_source->options = array();
  $export['source_map_views_map_page_1'] = $ol_source;

  $ol_source = new stdClass();
  $ol_source->disabled = FALSE; /* Edit this to true to make a default ol_source disabled initially */
  $ol_source->api_version = 1;
  $ol_source->machine_name = 'source_views_map_openlayers_1';
  $ol_source->name = 'Views Source: map_openlayers_1';
  $ol_source->description = '';
  $ol_source->factory_service = 'openlayers.source.internal.Vector';
  $ol_source->options = array(
    'url' => 'http://default/lol',
  );
  $export['source_views_map_openlayers_1'] = $ol_source;

  return $export;
}
