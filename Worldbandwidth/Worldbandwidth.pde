/*  This processing sketch vizualizes the average broadband bandwidth of each country.
 *  The greener a country is filled the higher average bandwidth it has. (As of March 2021)
 *  Sources:
 *  Countryborders (countries.json): https://datahub.io/core/geo-countries
 *  Bandwidth (data.json): https://www.speedtest.net/global-index
 */

JSONArray countries;
JSONObject data;
void setup() {
  size(3600, 1800);
  countries = loadJSONArray("countries.json");
  data = loadJSONObject("data.json");

  drawMap(countries, data);
  
  save("bwpcountry.png");
}


void drawMap(JSONArray countries, JSONObject data) {
  for (int i = 0; i<countries.size(); i++) {
    JSONObject country = countries.getJSONObject(i);
    JSONObject properties = country.getJSONObject("properties");
    String name = properties.getString("ADMIN");
    JSONObject geometry = country.getJSONObject("geometry");
    JSONArray coordinates = geometry.getJSONArray("coordinates");
    String type = geometry.getString("type");
    //we lerp the bandwidth
    float bw = 0.0;
    try {
      bw = data.getFloat(name);
      data.setBoolean(name, true);
    }catch(Exception e) {
      //println(name + " is not in data");
    }
    color c = lerpColor(color(255, 0, 0), color(0, 255, 0), bw/250);
    fill(c);
    if (type.equals("Polygon")) { 
    //country borders that are of the form of a single polygon.
    //We parse the data and draw the border.
      for (int k = 0; k<coordinates.size(); k++) {   
        JSONArray coords = coordinates.getJSONArray(k);
        beginShape();
        for (int l = 0; l<coords.size(); l++) {
          JSONArray pair = coords.getJSONArray(l);
          float x = map(pair.getFloat(0), -180, 180, 0, width);
          float y = map(pair.getFloat(1), -90, 90, height, 0);
          vertex(x, y);
        }
        endShape();
      }
    } else { 
      //multipolygons are stored in a 4D array in the used dataset.
      //They need special treatment.
      for (int k = 0; k<coordinates.size(); k++) {
        JSONArray polygon = coordinates.getJSONArray(k);
        for (int p = 0; p<polygon.size(); p++) {
          JSONArray coords = polygon.getJSONArray(p);
          beginShape();
          for (int l = 0; l<coords.size(); l++) {
            JSONArray pair = coords.getJSONArray(l);
            float x = map(pair.getFloat(0), -180, 180, 0, width);
            float y = map(pair.getFloat(1), -90, 90, height, 0);
            vertex(x, y);
          }
          endShape();
        }
      }
    }
  }
}
