#version 130
/* MakeUp Ultra Fast - composite.fsh
Render: DoF

Javier Garduño - GNU Lesser General Public License v3.0
*/

#define NO_SHADOWS

#include "/lib/config.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform float far;
uniform float near;
uniform float blindness;
uniform int isEyeInWater;
uniform float rainStrength;

#if DOF == 1
  uniform float centerDepthSmooth;
  uniform float inv_aspect_ratio;
  uniform float pixel_size_x;
  uniform float pixel_size_y;
  uniform float viewWidth;
  uniform float viewHeight;
  uniform float frameTimeCounter;
  uniform sampler2D colortex5;
  uniform float fov_y_inv;
#endif

#if DOF == 1
  const bool colortex0MipmapEnabled = true;
#endif

// Varyings (per thread shared variables)
varying vec2 texcoord;

#if BLOOM == 1
  varying float exposure;
#endif

#include "/lib/depth.glsl"
#include "/lib/luma.glsl"

#if DOF == 1
  #include "/lib/dither.glsl"
  #include "/lib/blur.glsl"
#endif

void main() {
  vec3 block_color = texture(colortex0, texcoord).rgb;
  float d = texture(depthtex0, texcoord).r;
  float linear_d = ld(d);

  #if DOF == 1
    block_color = noised_blur(
      vec4(block_color, d),
      colortex0,
      texcoord,
      DOF_STRENGTH
      );

  #endif

  if (blindness > .01) {
    block_color =
    mix(block_color, vec3(0.0), blindness * linear_d * far * .12);
  }

  #if BLOOM == 1
    // // Exposure
    // float candle_bright = eyeBrightnessSmooth.x * 0.0003125;  // (0.004166666666666667 * 0.075)
    // float exposure_coef =
    //   mix(
    //     ambient_exposure[current_hour_floor],
    //     ambient_exposure[current_hour_ceil],
    //     current_hour_fract
    //   );
    // float exposure =
    //   ((eyeBrightnessSmooth.y * 0.004166666666666667) * exposure_coef) + candle_bright;
    //
    // // Map from 1.0 - 0.0 to 1.0 - 3.6
    // exposure = (exposure * -2.6) + 3.6;

    // Bloom source
    float bloom_luma =
      smoothstep(0.85, 0.97, luma(block_color * exposure)) * 0.4;

    /* DRAWBUFFERS:0123 */
    gl_FragData[1] = vec4(block_color, d);
    gl_FragData[2] = vec4(block_color * bloom_luma, 1.0);
  #else
    /* DRAWBUFFERS:01 */
    gl_FragData[1] = vec4(block_color, d);
  #endif
}
