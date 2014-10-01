Micro Services
==============

This is a project for Internal Systems Engineers. It intends to capture your programming and system design skills.


### Geocoding

- Given a feed of page view log objects in JSON format with 3 fields:
  - path (string)
  - time (unix timestamp, integer)
  - ip (string)
- Objects show up in a Amazon SQS message queue http://aws.amazon.com/sqs/
- Task: implememnt a service which geolocates the IP address and adds `lat` and `long` to the object then sends the new objects to a second queue.
  
Incoming object:

```json
{page: "/users", time: 1411615161, ip: "12.130.117.132"}
```

Outgoing object:

```json
{page: "/users", time: 1411615161, ip: "12.130.117.132", lat: 40.3908, long: -74.1116}
```

Requirements:
 - Any technology/language (there is no penalty for using PHP :-) )
 - Use 2 SQS queues (one for incoming, one for geolocated data)
 - Cache already geolocated IPs for 24 hours




