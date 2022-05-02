// tag::copyright[]
/*******************************************************************************
 * Copyright (c) 2017, 2022 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - Initial implementation
 *******************************************************************************/
// end::copyright[]
package io.openliberty.guides.system;

// CDI
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.RequestScoped;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.ws.rs.GET;
// JAX-RS
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.StringReader;
import java.util.logging.Logger;

@RequestScoped
@Path("/prediction")
@Produces(MediaType.APPLICATION_JSON)
public class PredictionResource {

  @Path("/model")
  @GET
  public Response getPredictionModel() {
    // Add custom integration code here
    // Invoke request to ML Service
    return postPrediction("seldon-model-default");
  }

  @Path("/image")
  @GET
  public Response getPredictionImage() {
    return postPrediction("seldon-image-default");
  }

  private Response postPrediction(String service) {
    Client client = ClientBuilder.newClient();
    WebTarget target = client.target("http://" + service + ":8000/api/v1.0/predictions");
    JsonObject data = Json.createReader(new StringReader("{\"data\": { \"ndarray\": [[1,2,3,4]]}}")).readObject();
    return target.request(MediaType.APPLICATION_JSON).post(Entity.entity(data, MediaType.APPLICATION_JSON));
  }

//  @PostConstruct
  private void postConstruct() {
    Logger logger = Logger.getLogger(PredictionResource.class.getName());
    logger.info("Running PostConstruct");
    logger.info("Image: " + getPredictionImage().readEntity(String.class));
    logger.info("Model: " + getPredictionModel().readEntity(String.class));
  }

}