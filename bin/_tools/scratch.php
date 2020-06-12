<?php

use Drupal\node\Entity\Node;
use Drupal\paragraphs\Entity\Paragraph;

$node = Node::load(1);

if ($node != NULL) {
  $node->set('field_content_block', array(
    'target_id' => 2,
    'target_revision_id' => 2,
  ));

//$node->save();
}
