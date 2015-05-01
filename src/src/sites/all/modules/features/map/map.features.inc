<?php
/**
 * @file
 * map.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function map_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "openlayers" && $api == "default_openlayers_layers") {
    return array("version" => "1");
  }
  if ($module == "openlayers" && $api == "default_openlayers_maps") {
    return array("version" => "1");
  }
  if ($module == "openlayers" && $api == "default_openlayers_sources") {
    return array("version" => "1");
  }
}

/**
 * Implements hook_views_api().
 */
function map_views_api($module = NULL, $api = NULL) {
  return array("api" => "3.0");
}
