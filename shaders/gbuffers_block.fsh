#version 120
/* MakeUp - gbuffers_beaconbeam.fsh
Render: Beacon beam

Javier Garduño - GNU Lesser General Public License v3.0
*/

// #define USE_BASIC_SH // Sets the use of a "basic" or "generic" shader for custom dimensions, instead of the default overworld shader. This can solve some rendering issues as the shader is closer to vanilla rendering.

#ifdef USE_BASIC_SH
  #define UNKNOWN_DIM
#endif
#define GBUFFER_BLOCK

#include "/common/solid_blocks_fragment.glsl"
