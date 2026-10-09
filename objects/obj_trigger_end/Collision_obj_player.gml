if (triggered == false) {
show_debug_message("End, triggered");
triggered = true;

// 1. Spawn the text object on the screen
instance_create_layer(0, 0, "Instances", obj_end_txt);

// 2. Destroy this trigger so it doesn't spawn 100 text objects
instance_destroy();

}