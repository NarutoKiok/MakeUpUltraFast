/* MakeUp Ultra Fast - color_utils.glsl
Usefull data for color manipulation.

Javier Garduño - GNU Lesser General Public License v3.0
*/

uniform sampler2D gaux3;
uniform float current_hour;
// Direct light color per hour
// const vec3 ambient_baselight[25] =
//   vec3[25](
//   vec3(0.75, 0.37941176, 0.16470588), // 6
//   vec3(0.75, 0.56470588, 0.32141544), // 7
//   vec3(0.75, 0.65735294, 0.39977022), // 8
//   vec3(0.75, 0.70367647, 0.43894761), // 9
//   vec3(0.75, 0.75, 0.478125), // 10
//   vec3(0.75, 0.75, 0.478125), // 11
//   vec3(0.75, 0.75, 0.478125), // 12
//   vec3(0.75, 0.75, 0.478125), // 1
//   vec3(0.75, 0.75, 0.478125), // 2
//   vec3(0.75, 0.70367647, 0.43894761), // 3
//   vec3(0.75, 0.65735294, 0.39977022), // 4
//   vec3(0.75, 0.56470588, 0.32141544), // 5
//   vec3(0.75, 0.37941176, 0.16470588), // 6
//   vec3(0.02720588, 0.02941177, 0.03474265), // 7
//   vec3(0.02720588, 0.02941177, 0.03474265), // 8
//   vec3(0.02720588, 0.02941177, 0.03474265), // 9
//   vec3(0.02720588, 0.02941177, 0.03474265), // 10
//   vec3(0.02720588, 0.02941177, 0.03474265), // 11
//   vec3(0.02720588, 0.02941177, 0.03474265), // 12
//   vec3(0.02720588, 0.02941177, 0.03474265), // 1
//   vec3(0.02720588, 0.02941177, 0.03474265), // 2
//   vec3(0.02720588, 0.02941177, 0.03474265), // 3
//   vec3(0.02720588, 0.02941177, 0.03474265), // 4
//   vec3(0.02720588, 0.02941177, 0.03474265), // 5
//   vec3(0.75, 0.37941176, 0.16470588) // 6
// );
//
// #if MAKEUP_COLOR == 1
//   // Sky color per hour
//   const vec3 hi_sky_color_array[25] =
//     vec3[25](
//     vec3(0.17647059, 0.34901961, 0.82745098), // 6
//     vec3(0.21568627, 0.42352941, 1.0), // 7
//     vec3(0.21568627, 0.42352941, 1.0), // 8
//     vec3(0.21568627, 0.42352941, 1.0), // 9
//     vec3(0.21568627, 0.42352941, 1.0), // 10
//     vec3(0.21568627, 0.42352941, 1.0), // 11
//     vec3(0.21568627, 0.42352941, 1.0), // 12
//     vec3(0.21568627, 0.42352941, 1.0), // 1
//     vec3(0.21568627, 0.42352941, 1.0), // 2
//     vec3(0.21568627, 0.42352941, 1.0), // 3
//     vec3(0.21568627, 0.42352941, 1.0), // 4
//     vec3(0.21568627, 0.42352941, 1.0), // 5
//     vec3(0.17647059, 0.34901961, 0.82745098), // 6
//     vec3(0.04897059, 0.09678431, 0.22936274), // 7
//     vec3(0.00647058, 0.01270587, 0.03), // 8
//     vec3(0.00647058, 0.01270587, 0.03), // 9
//     vec3(0.00647058, 0.01270587, 0.03), // 10
//     vec3(0.00647058, 0.01270587, 0.03), // 11
//     vec3(0.00647058, 0.01270587, 0.03), // 12
//     vec3(0.00647058, 0.01270587, 0.03), // 1
//     vec3(0.00647058, 0.01270587, 0.03), // 2
//     vec3(0.00647058, 0.01270587, 0.03), // 3
//     vec3(0.00647058, 0.01270587, 0.03), // 4
//     vec3(0.04897059, 0.09678431, 0.22936274), // 5
//     vec3(0.17647059, 0.34901961, 0.82745098) // 6
//   );
//
//   // Low sky color per hour
//   const vec3 low_sky_color_array[25] =
//     vec3[25](
//     vec3(1.0, 0.50588235, 0.21960784), // 6
//     vec3(0.80588236, 0.6882353 , 0.60980392), // 7
//     vec3(0.61176471, 0.87058824, 1.0), // 8
//     vec3(0.61176471, 0.87058824, 1.0), // 9
//     vec3(0.61176471, 0.87058824, 1.0), // 10
//     vec3(0.61176471, 0.87058824, 1.0), // 11
//     vec3(0.61176471, 0.87058824, 1.0), // 12
//     vec3(0.61176471, 0.87058824, 1.0), // 1
//     vec3(0.61176471, 0.87058824, 1.0), // 2
//     vec3(0.61176471, 0.87058824, 1.0), // 3
//     vec3(0.61176471, 0.87058824, 1.0), // 4
//     vec3(0.80588236, 0.6882353 , 0.60980392), // 5
//     vec3(1.0, 0.50588235, 0.21960784), // 6
//     vec3(0.30124182833333335, 0.30124182833333335, 0.30124182833333335), // 7
//     vec3(0.01078431, 0.02117647, 0.05), // 8
//     vec3(0.01078431, 0.02117647, 0.05), // 9
//     vec3(0.01078431, 0.02117647, 0.05), // 10
//     vec3(0.01078431, 0.02117647, 0.05), // 11
//     vec3(0.01078431, 0.02117647, 0.05), // 12
//     vec3(0.01078431, 0.02117647, 0.05), // 1
//     vec3(0.01078431, 0.02117647, 0.05), // 2
//     vec3(0.01078431, 0.02117647, 0.05), // 3
//     vec3(0.01078431, 0.02117647, 0.05), // 4
//     vec3(0.30124182833333335, 0.30124182833333335, 0.30124182833333335), // 5
//     vec3(1.0, 0.50588235, 0.21960784) // 6
//   );
//
// #endif

// Ambient color luma per hour in exposure calculation
const float ambient_exposure[25] =
  float[25](
  1.0, // 6
  1.0, // 7
  1.0, // 8
  1.0, // 9
  1.0, // 10
  1.0, // 11
  1.0, // 12
  1.0, // 1
  1.0, // 2
  1.0, // 3
  1.0, // 4
  1.0, // 5
  1.0, // 6
  .75, // 7
  .1, // 8
  .1, // 9
  .1, // 10
  .1, // 11
  .1, // 12
  .1, // 1
  .1, // 2
  .1, // 3
  .1, // 4
  .75, // 5
  1.0 // 6
  );

// How many sky_color vs. fog_color is used for fog.
const float fog_color_mix[25] =
  float[25](
  .9, // 6
  .7, // 7
  .5, // 8
  .5, // 9
  .5, // 10
  .5, // 11
  .5, // 12
  .5, // 13
  .5, // 14
  .5, // 15
  .5, // 16
  .7, // 17
  .9, // 18
  .9, // 19
  .9, // 20
  .9, // 21
  .9, // 22
  .9, // 23
  .9, // 24
  .9, // 1
  .9, // 2
  .9, // 3
  .9, // 4
  .9, // 5
  .9 // 6
  );

// Fog parameter per hour
const float fog_density[25] =
  float[25](
  1.0, // 6
  2.5, // 7
  3.0, // 8
  3.0, // 9
  3.0, // 10
  3.0, // 11
  3.0, // 12
  3.0, // 13
  3.0, // 14
  3.0, // 15
  3.0, // 16
  2.5, // 17
  1.0, // 18
  1.0, // 19
  2.5, // 20
  3.0, // 21
  3.0, // 22
  3.0, // 23
  3.0, // 24
  3.0, // 1
  3.0, // 2
  3.0, // 3
  2.5, // 4
  1.0, // 5
  1.0 // 6
  );

const vec3 candle_baselight = vec3(0.4995, 0.38784706, 0.1998);
