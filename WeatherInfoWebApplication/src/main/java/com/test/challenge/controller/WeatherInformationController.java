package com.test.challenge.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.test.challenge.model.Request;

/**
 * 
 * @author Sashank
 * Description: Weather infromation controller
 *
 */
@Controller
public class WeatherInformationController {
	
	private static final Logger logger = LogManager.getLogger(WeatherInformationController.class.getName());

	/**
	 * Return the weather information for a city
	 * @param data
	 * @return weather data
	 */
	@RequestMapping(value = "/weather", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public String weatherInfomarion(@RequestBody Request data) {
		logger.debug("Recieved request:"+data);
		RestTemplate restTemplate = new RestTemplate();	
		logger.debug("Calling weather information webservices START");
		String weather = restTemplate.getForObject("https://samples.openweathermap.org/data/2.5/weather?q="+data.getCity()+"&appid=b6907d289e10d714a6e88b30761fae22", String.class);
		logger.debug("Calling weather information webservices END");
		return weather;
	}

}
