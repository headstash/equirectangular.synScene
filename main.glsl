//vec4 iMouse = vec4(MouseXY*RENDERSIZE, MouseClick, MouseClick);

#define 	twpi  	6.283185307179586  	// two pi, 2*pi
#define 	pi   	3.141592653589793 	// pi

vec4 renderMainImage() {
	vec4 fragColor = vec4(0.0);
	vec2 fragCoord = _xy;

    vec2 uv = fragCoord.xy / RENDERSIZE.xy;
    vec2 v = zoom*(_xy.xy / RENDERSIZE.xy) + RENDERSIZE.y;
    v.y -= 0.5;

    vec2 uvc = _uvc;

    float position_time = bass_time*4.0;
    float perspective_time = bass_time*4.0;
    if (position == 1) {
        uvc.x += (position_momentum.x)*sin(position_time);
        uvc.y += (position_momentum.y)*sin(position_time);
    }

    float th = v.y * pi,
        ph = v.x * twpi;
    vec3 sp = vec3( sin(ph) * cos(th), sin(th), cos(ph) * cos(th) );
    vec3 pos = vec3( pi, rotate * PI, 0);
    pos *= texture_zoom;
    sp = mix(sp, normalize(vec3(uvc, 1.0)), (perspective == 1 ? (min_perspective * sin(perspective_time)) * max_perspective : min_perspective));

    sp.yz = _rotate(sp.yz, 0.5+lookXY.y*PI);
    sp.xy = _rotate(sp.xy, lookXY.x*PI);

    if (_exists(syn_UserImage)) {
        fragColor = texture(syn_UserImage, mod(vec2(dot(pos, sp.zxy), dot(pos.yzx, sp.zxy))+positionXY.xy, 1.0));
    }
    return fragColor;
}

vec4 renderMain(){
	if(PASSINDEX == 0){
		return renderMainImage();
	}
}
