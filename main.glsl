//vec4 iMouse = vec4(MouseXY*RENDERSIZE, MouseClick, MouseClick);

#define 	twpi  	6.283185307179586  	// two pi, 2*pi
#define 	pi   	3.141592653589793 	// pi

#define time TIME

vec4 renderMainImage() {
	vec4 fragColor = vec4(0.0);
	vec2 fragCoord = _xy;

    vec2 v = (_xy.xy / RENDERSIZE.xy) + RENDERSIZE.y;
    v.y -= 0.5;

    vec2 uvc = _uvc;
    uvc.x += positionXY.x;
    uvc.y += positionXY.y;

    float position_time = mix(script_time*0.5, bass_time*4.0, reactive_time);
    float perspective_time = mix(script_time*0.5, bass_time*4.0, reactive_time);
    if (position == 1) {
        uvc.x += sin(position_time*(position_momentum.x*0.1));
        uvc.y += sin(position_time*(position_momentum.y*0.1));
    }

    float th = v.y * pi,
        ph = v.x * twpi;
    vec3 sp = vec3( sin(ph) * cos(th), sin(th), cos(ph) * cos(th) );
    vec3 pos = vec3( pi, 0, 0);
    pos *= zoom;
    sp = mix(sp, normalize(vec3(uvc, 1.0)), max_perspective * (perspective == 1 ? sin(perspective_time) : 1));

    sp.yz = _rotate(sp.yz, lookXY.y*PI);
    sp.xy = _rotate(sp.xy, lookXY.x*PI);

    if (_exists(syn_UserImage)) {
        fragColor = texture(syn_UserImage, (vec2(dot(pos, sp.zxy), dot(pos.yzx, sp.zxy))));
    }
    return fragColor;
}

vec4 renderMain(){
	if(PASSINDEX == 0){
		return renderMainImage();
	}
}
