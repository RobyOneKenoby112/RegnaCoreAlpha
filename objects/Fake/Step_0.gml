if (is_fading) {
    image_alpha -= fade_speed; // Reduce transparency
    
    // Once it is invisible, delete it
    if (image_alpha <= 0) {
        instance_destroy();
    }
}