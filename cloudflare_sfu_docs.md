---
title: Realtime SFU
description: Build real-time serverless video, audio, and data applications with Cloudflare Realtime SFU.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Realtime SFU

Build real-time serverless video, audio and data applications.

Cloudflare Realtime SFU is infrastructure for real-time audio/video/data applications. It allows you to build real-time apps without worrying about scaling or regions. It can act as a selective forwarding unit (WebRTC SFU), as a fanout delivery system for broadcasting (WebRTC CDN) or anything in between.

Cloudflare Realtime SFU runs on [Cloudflare's global cloud network ↗](https://www.cloudflare.com/network/) in hundreds of cities worldwide.

[ Get started ](https://developers.cloudflare.com/realtime/sfu/get-started/) [ Realtime dashboard ](https://dash.cloudflare.com/?to=/:account/calls) [ Orange Meets demo app ](https://github.com/cloudflare/orange) 

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}}]}
```

---
title: Introduction
description: Cloudflare Realtime SFU adds low-latency WebRTC audio, video, and data to your applications.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Introduction

Cloudflare Realtime can be used to add realtime audio, video and data into your applications. Cloudflare Realtime uses WebRTC, which is the lowest latency way to communicate across a broad range of platforms like browsers, mobile, and native apps.

Realtime integrates with your backend and frontend application to add realtime functionality.

## Why Cloudflare Realtime exists

* **It is difficult to scale WebRTC**: Many struggle scaling WebRTC servers. Operators run into issues about how many users can be in the same "room" or want to build unique solutions that do not fit into the current concepts in high level APIs.
* **High egress costs**: WebRTC is expensive to use as managed solutions charge a high premium on cloud egress and running your own servers incur system administration and scaling overhead. Cloudflare already has 300+ locations with upwards of 1,000 servers in some locations. Cloudflare Realtime scales easily on top of this architecture and can offer the lowest WebRTC usage costs.
* **WebRTC is growing**: Developers are realizing that WebRTC is not just for video conferencing. WebRTC is supported on many platforms, it is mature and well understood.

## What makes Cloudflare Realtime unique

* **Unopinionated**: Cloudflare Realtime does not offer a SDK. It instead allows you to access raw WebRTC to solve unique problems that might not fit into existing concepts. The API is deliberately simple.
* **No rooms**: Unlike other WebRTC products, Cloudflare Realtime lets you be in charge of each track (audio/video/data) instead of offering abstractions such as rooms. You define the presence protocol on top of simple pub/sub. Each end user can publish and subscribe to audio/video/data tracks as they wish.
* **No lock-in**: You can use Cloudflare Realtime to solve scalability issues with your SFU. You can use in combination with peer-to-peer architecture. You can use Cloudflare Realtime standalone. To what extent you use Cloudflare Realtime is up to you.

## What exactly does Cloudflare Realtime do?

* **SFU**: Realtime is a special kind of pub/sub server that is good at forwarding media data to clients that subscribe to certain data. Each client connects to Cloudflare Realtime via WebRTC and either sends data, receives data or both using WebRTC. This can be audio/video tracks or DataChannels.
* **It scales**: All Cloudflare servers act as a single server so millions of WebRTC clients can connect to Cloudflare Realtime. Each can send data, receive data or both with other clients.

## How most developers get started

1. Get started with the echo example, which you can download from the Cloudflare dashboard when you create a Realtime App or from [demos](https://developers.cloudflare.com/realtime/sfu/demos/). This will show you how to send and receive audio and video.
2. Understand how you can manipulate who can receive what media by passing around session and track ids. Remember, you control who receives what media. Each media track is represented by a unique ID. It is your responsibility to save and distribute this ID.

Realtime is not a presence protocol

Realtime does not know what a room is. It only knows media tracks. It is up to you to make a room by saving who is in a room along with track IDs that unique identify media tracks. If each participant publishes their audio/video, and receives audio/video from each other, you have got yourself a video conference!

1. Create an app where you manage each connection to Cloudflare Realtime and the track IDs created by each connection. You can use any tool to save and share tracks. Check out the example apps at [demos](https://developers.cloudflare.com/realtime/sfu/demos/), such as [Orange Meets ↗](https://github.com/cloudflare/orange), which is a full-fledged video conferencing app that uses [Workers Durable Objects](https://developers.cloudflare.com/durable-objects/) to keep track of track IDs.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/introduction/","name":"Introduction"}}]}
```
---
title: Quickstart guide
description: Create your first Realtime SFU app and get your App ID and secret.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Quickstart guide

Before you get started:

You must first [create a Cloudflare account](https://developers.cloudflare.com/fundamentals/account/create-account/).

## Create your first app

Every Realtime App is a separate environment, so you can make one for development, staging and production versions for your product. Either using [Dashboard ↗](https://dash.cloudflare.com/?to=/:account/realtime/sfu), or the [API](https://developers.cloudflare.com/api/resources/calls/subresources/sfu/methods/create/) create a Realtime App. When you create a Realtime App, you will get:

* App ID
* App Secret

These two combined will allow you to make API Realtime from your backend server to Realtime.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/get-started/","name":"Quickstart guide"}}]}
```
---
title: Sessions and Tracks
description: Understand Realtime SFU core concepts including applications, sessions, and tracks.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Sessions and Tracks

Cloudflare Realtime offers a simple yet powerful framework for building real-time experiences. At the core of this system are three key concepts: **Applications**, **Sessions** and **Tracks**. Familiarizing yourself with these concepts is crucial for using Realtime.

## Application

A Realtime Application is an environment within different Sessions and Tracks can interact. Examples of this could be production, staging or different environments where you'd want separation between Sessions and Tracks. Cloudflare Realtime usage can be queried at Application, Session or Track level.

## Sessions

A **Session** in Cloudflare Realtime correlates directly to a WebRTC PeerConnection. It represents the establishment of a communication channel between a client and the nearest Cloudflare data center, as determined by Cloudflare's anycast routing. Typically, a client will maintain a single Session, encompassing all communications between the client and Cloudflare.

* **One-to-One Mapping with PeerConnection**: Each Session is a direct representation of a WebRTC PeerConnection, facilitating real-time media data transfer.
* **Anycast Routing**: The client connects to the closest Cloudflare data center, optimizing latency and performance.
* **Unified Communication Channel**: A single Session can handle all types of communication between a client and Cloudflare, ensuring streamlined data flow.

## Tracks

Within a Session, there can be one or more **Tracks**.

* **Tracks map to MediaStreamTrack**: Tracks align with the MediaStreamTrack concept, facilitating audio, video, or data transmission.
* **Globally Unique Ids**: When you push a track to Cloudflare, it is assigned a unique ID, which can then be used to pull the track into another session elsewhere.
* **Available globally**: The ability to push and pull tracks is central to what makes Realtime a versatile tool for real-time applications. Each track is available globally to be retrieved from any Session within an App.

## Realtime as a Programmable "Switchboard"

The analogy of a switchboard is apt for understanding Realtime. Historically, switchboard operators connected calls by manually plugging in jacks. Similarly, Realtime allows for the dynamic routing of media streams, acting as a programmable switchboard for modern real-time communication.

## Beyond "Rooms", "Users", and "Participants"

While many SFUs utilize concepts like "rooms" to manage media streams among users, this approach has scalability and flexibility limitations. Cloudflare Realtime opts for a more granular and flexible model with Sessions and Tracks, enabling a wide range of use cases:

* Large-scale remote events, like 'fireside chats' with thousands of participants.
* Interactive conversations with the ability to bring audience members "on stage."
* Educational applications where an instructor can present to multiple virtual classrooms simultaneously.

### Presence Protocol vs. Media Flow

Realtime distinguishes between the presence protocol and media flow, allowing for scalability and flexibility in real-time applications. This separation enables developers to craft tailored experiences, from intimate calls to massive, low-latency broadcasts.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/sessions-tracks/","name":"Sessions and Tracks"}}]}
```
---
title: Realtime vs Regular SFUs
description: Compare Cloudflare Realtime SFU with traditional centralized SFUs for WebRTC applications.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Realtime vs Regular SFUs

## Cloudflare Realtime vs. Traditional SFUs

Cloudflare Realtime represents a paradigm shift in building real-time applications by leveraging a distributed real-time data plane. It creates a seamless experience in real-time communication, transcending traditional geographical limitations and scalability concerns. Realtime is designed for developers looking to integrate WebRTC functionalities in a server-client architecture without delving deep into the complexities of regional scaling or server management.

### The Limitations of Centralized SFUs

Selective Forwarding Units (SFUs) play a critical role in managing WebRTC connections by selectively forwarding media streams to participants in a video call. However, their centralized nature introduces inherent limitations:

* **Regional Dependency:** A centralized SFU requires a specific region for deployment, leading to latency issues for global users except for those in proximity to the selected region.
* **Scalability Concerns:** Scaling a centralized SFU to meet global demand can be challenging and inefficient, often requiring additional infrastructure and complexity.

### How is Cloudflare Realtime different?

Cloudflare Realtime addresses these limitations by leveraging Cloudflare's global network infrastructure:

* **Global Distribution Without Regions:** Unlike traditional SFUs, Cloudflare Realtime operates on a global scale without regional constraints. It utilizes Cloudflare's extensive network of over 250 locations worldwide to ensure low-latency video forwarding, making it fast and efficient for users globally.
* **Decentralized Architecture:** There are no dedicated servers for Realtime. Every server within Cloudflare's network contributes to handling Realtime, ensuring scalability and reliability. This approach mirrors the distributed nature of Cloudflare's products such as 1.1.1.1 DNS or Cloudflare's CDN.

Tip 

**See it in action:** Explore our [interactive Global SFU visualization ↗](https://realtime-sfu.dev-demos.workers.dev) to see how participants connect to their nearest Cloudflare datacenter and how media flows across the global backbone.

## How Cloudflare Realtime Works

### Establishing Peer Connections

To initiate a real-time communication session, an end user's client establishes a WebRTC PeerConnection to the nearest Cloudflare location. This connection benefits from anycast routing, optimizing for the lowest possible latency.

### Signaling and Media Stream Management

* **HTTPS API for Signaling:** Cloudflare Realtime simplifies signaling with a straightforward HTTPS API. This API manages the initiation and coordination of media streams, enabling clients to push new MediaStreamTracks or request these tracks from the server.
* **Efficient Media Handling:** Unlike traditional approaches that require multiple connections for different media streams from different clients, Cloudflare Realtime maintains a single PeerConnection per client. This streamlined process reduces complexity and improves performance by handling both the push and pull of media through a singular connection.

### Application-Level Management

Cloudflare Realtime delegates the responsibility of state management and participant tracking to the application layer. Developers are empowered to design their logic for handling events such as participant joins or media stream updates, offering flexibility to create tailored experiences in applications.

## Getting Started with Cloudflare Realtime

Integrating Cloudflare Realtime into your application promises a straightforward and efficient process, removing the hurdles of regional scalability and server management so you can focus on creating engaging real-time experiences for users worldwide.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/calls-vs-sfus/","name":"Realtime vs Regular SFUs"}}]}
```
---
title: Connection API
description: Manage Realtime SFU sessions and media tracks using the HTTPS connection API.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Connection API

Cloudflare Realtime simplifies the management of peer connections and media tracks through HTTPS API endpoints. These endpoints allow developers to efficiently manage sessions, add or remove tracks, and gather session information.

## API Endpoints

* **Create a New Session**: Initiates a new session on Cloudflare Realtime, which can be modified with other endpoints below.  
   * `POST /apps/{appId}/sessions/new`
* **Add a New Track**: Adds a media track (audio or video) to an existing session.  
   * `POST /apps/{appId}/sessions/{sessionId}/tracks/new`
* **Renegotiate a Session**: Updates the session's negotiation state to accommodate new tracks or changes in the existing ones.  
   * `PUT /apps/{appId}/sessions/{sessionId}/renegotiate`
* **Close a Track**: Removes a specified track from the session.  
   * `PUT /apps/{appId}/sessions/{sessionId}/tracks/close`
* **Retrieve Session Information**: Fetches detailed information about a specific session.  
   * `GET /apps/{appId}/sessions/{sessionId}`

[View full API and schema (OpenAPI format)](https://developers.cloudflare.com/realtime/static/realtime-api-2024-05-21.yaml)

## Handling Secrets

It is vital to manage App ID and its secret securely. While track and session IDs can be public, they should be protected to prevent misuse. An attacker could exploit these IDs to disrupt service if your backend server does not authenticate request origins properly, for example by sending requests to close tracks on sessions other than their own. Ensuring the security and authenticity of requests to your backend server is crucial for maintaining the integrity of your application.

## Using STUN and TURN Servers

Cloudflare Realtime is designed to operate efficiently without the need for TURN servers in most scenarios, as Cloudflare exposes a publicly routable IP address for Realtime. However, integrating a STUN server can be necessary for facilitating peer discovery and connectivity.

* **Cloudflare STUN Server**: `stun.cloudflare.com:3478`

Utilizing Cloudflare's STUN server can help the connection process for Realtime applications.

## Lifecycle of a Simple Session

This section provides an overview of the typical lifecycle of a simple session, focusing on audio-only applications. It illustrates how clients are notified by the backend server as new remote clients join or leave, incorporating video would introduce additional tracks and considerations into the session.

sequenceDiagram
    participant WA as WebRTC Agent
    participant BS as Backend Server
    participant CA as Realtime API

    Note over BS: Client Joins

    WA->>BS: Request
    BS->>CA: POST /sessions/new
    CA->>BS: newSessionResponse
    BS->>WA: Response

    WA->>BS: Request
    BS->>CA: POST /sessions/<ID>/tracks/new (Offer)
    CA->>BS: newTracksResponse (Answer)
    BS->>WA: Response

    WA-->>CA: ICE Connectivity Check
    Note over WA: iceconnectionstatechange (connected)
    WA-->>CA: DTLS Handshake
    Note over WA: connectionstatechange (connected)

    WA<<->>CA: *Media Flow*

    Note over BS: Remote Client Joins

    WA->>BS: Request
    BS->>CA: POST /sessions/<ID>/tracks/new
    CA->>BS: newTracksResponse (Offer)
    BS->>WA: Response

    WA->>BS: Request
    BS->>CA: PUT /sessions/<ID>/renegotiate (Answer)
    CA->>BS: OK
    BS->>WA: Response

    Note over BS: Remote Client Leaves

    WA->>BS: Request
    BS->>CA: PUT /sessions/<ID>/tracks/close
    CA->>BS: closeTracksResponse
    BS->>WA: Response

    Note over BS: Client Leaves

    WA->>BS: Request
    BS->>CA: PUT /sessions/<ID>/tracks/close
    CA->>BS: closeTracksResponse
    BS->>WA: Response

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/https-api/","name":"Connection API"}}]}
```
---
title: Media Transport Adapters
description: Bridge WebRTC and other transport protocols using Realtime SFU media adapters.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Media Transport Adapters

Media Transport Adapters bridge WebRTC and other transport protocols. Adapters handle protocol conversion, codec transcoding, and bidirectional media flow between WebRTC sessions and external endpoints.

## What adapters do

Adapters extend Realtime beyond WebRTC-to-WebRTC communication:

* Ingest audio/video from external sources into WebRTC sessions
* Stream WebRTC media to external systems for processing or storage
* Integrate with AI services for transcription, translation, or generation
* Bridge WebRTC applications with legacy communication systems

## Available adapters

### WebSocket adapter (beta)

Stream audio and video between WebRTC tracks and WebSocket endpoints. Video is egress-only and is converted to JPEG. Currently in beta; the API may change.

[Learn more](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/websocket-adapter/)

## Architecture

Media Transport Adapters operate as intermediaries between Cloudflare Realtime SFU sessions and external endpoints:

graph LR
    A[WebRTC Client] <--> B[Realtime SFU Session]
    B <--> C[Media Transport Adapter]
    C <--> D[External Endpoint]

### Key concepts

**Adapter instance**: Each connection creates a unique instance with an `adapterId` to manage its lifecycle.

**Location types**:

* `local` (Ingest): Receives media from external endpoints to create new WebRTC tracks
* `remote` (Stream): Sends media from existing WebRTC tracks to external endpoints

**Codec support**: Adapters convert between WebRTC and external system formats.

## Common use cases

### AI processing

* Speech-to-text transcription
* Text-to-speech generation
* Real-time translation
* Audio enhancement

### Media recording

* Cloud recording
* Content delivery networks
* Media processing pipelines

### Legacy integration

* Traditional telephony
* Broadcasting infrastructure
* Custom media servers

## API overview

Media Transport Adapters are managed through the Realtime SFU API:

```

POST /v1/apps/{appId}/adapters/{adapterType}/new

POST /v1/apps/{appId}/adapters/{adapterType}/close


```

Each adapter type has specific configuration requirements and capabilities. Refer to individual adapter documentation for detailed API specifications.

## Best practices

* Close adapter instances when no longer needed
* Implement reconnection logic for network failures
* Choose codecs based on bandwidth and quality requirements
* Secure endpoints with authentication for sensitive media

## Limitations

* Each adapter type has specific codec and format support
* Network latency between Cloudflare edge and external endpoints affects real-time performance
* Maximum message size and streaming modes vary by adapter type

## Get started

[WebSocket adapter (beta)](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/websocket-adapter/) \- Stream audio and video between WebRTC and WebSocket endpoints (video egress to JPEG)

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/media-transport-adapters/","name":"Media Transport Adapters"}}]}
```
---
title: WebSocket adapter
description: Stream audio and video between WebRTC tracks and WebSocket endpoints using Realtime SFU.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# WebSocket adapter

Note

WebSocket adapter is in beta. The API may change.

Stream audio and video between WebRTC tracks and WebSocket endpoints. Supports ingesting audio from WebSocket sources and sending WebRTC audio and video to WebSocket consumers. Video egress is supported as JPEG at approximately 1 FPS.

## What you can build

* AI services with WebSocket APIs for audio processing
* Custom audio processing pipelines
* Legacy system bridges
* Server-side audio generation and consumption
* Video snapshotting and thumbnails
* Computer vision ingestion (low FPS)

## How it works

* [ Ingest (WebSocket → WebRTC) ](#tab-panel-9810)
* [ Stream (WebRTC → WebSocket) ](#tab-panel-9811)

### Create WebRTC tracks from external audio

Ingest audio from external sources via WebSocket to create WebRTC tracks for distribution.

graph LR
    A[External System] -->|Audio Data| B[WebSocket Endpoint]
    B -->|Adapter| C[Realtime SFU]
    C -->|New Session| D[WebRTC Track]
    D -->|WebRTC| E[WebRTC Clients]

**Use cases:**

* AI text-to-speech generation streaming into WebRTC
* Audio from backend services or databases
* Live audio feeds from external systems

**Key characteristics:**

* Creates a new session ID automatically
* Uses `buffer` mode for chunked audio transmission
* Maximum 32 KB per WebSocket message

### Stream WebRTC audio and video to external systems

Stream audio and video from existing WebRTC tracks to external systems via WebSocket for processing or storage.

graph LR
    A[WebRTC Source] -->|WebRTC| B[Realtime SFU Session]
    B -->|Adapter| C[WebSocket Endpoint]
    C -->|Media Data| D[External System]

**Use cases:**

* Real-time speech-to-text transcription
* Audio recording and archival
* Live audio processing pipelines
* Video snapshotting and thumbnails
* Computer vision ingestion (low FPS)

**Key characteristics:**

* Requires existing session ID with track
* Audio: Sends individual PCM frames as they are produced; each includes timestamp and sequence number
* Video: Sends individual JPEG frames at approximately 1 FPS; each includes timestamp (sequence number may be unset)
* Automatically retries the same WebSocket endpoint for up to 5 seconds after brief disconnects or endpoint restarts. Refer to [Automatic reconnection for streaming](#automatic-reconnection-for-streaming).

## API reference

### Create adapter

```

POST /v1/apps/{appId}/adapters/websocket/new


```

* [ Ingest ](#tab-panel-9812)
* [ Stream ](#tab-panel-9813)

#### Request body

```

{

  "tracks": [

    {

      "location": "local",

      "trackName": "string",

      "endpoint": "wss://...",

      "inputCodec": "pcm",

      "mode": "buffer"

    }

  ]

}


```

#### Parameters

| Parameter  | Type   | Description                                                 |
| ---------- | ------ | ----------------------------------------------------------- |
| location   | string | **Required**. Must be "local" for ingesting audio           |
| trackName  | string | **Required**. Name for the new WebRTC track to create       |
| endpoint   | string | **Required**. WebSocket URL to receive audio from           |
| inputCodec | string | **Required**. Codec of incoming audio. Currently only "pcm" |
| mode       | string | **Required**. Must be "buffer" for local mode               |

#### Response

```

{

  "tracks": [

    {

      "trackName": "string",

      "adapterId": "string",

      "sessionId": "string",    // New session ID generated

      "endpoint": "string"      // Echo of the requested endpoint

    }

  ]

}


```

Important

* A new session ID is automatically generated.
* The `sessionId` field in the request is ignored if provided.
* Send audio in chunks up to 32 KB per WebSocket message.

#### Request body

```

{

  "tracks": [

    {

      "location": "remote",

      "sessionId": "string",

      "trackName": "string",

      "endpoint": "wss://...",

      "outputCodec": "pcm"

    }

  ]

}


```

#### Parameters

| Parameter   | Type   | Description                                                                                 |
| ----------- | ------ | ------------------------------------------------------------------------------------------- |
| location    | string | **Required**. Must be "remote" for streaming media out                                      |
| sessionId   | string | **Required**. Existing session ID containing the track                                      |
| trackName   | string | **Required**. Name of the existing track to stream                                          |
| endpoint    | string | **Required**. WebSocket URL to send media to                                                |
| outputCodec | string | **Required**. Codec for outgoing media. Use "pcm" for audio, "jpeg" for video (egress only) |

#### Response

```

{

  "tracks": [

    {

      "trackName": "string",

      "adapterId": "string",

      "sessionId": "string",    // Same as request sessionId

      "endpoint": "string"      // Echo of the requested endpoint

    }

  ]

}


```

Important

* Requires an existing session with the specified track.
* Audio frames are sent individually with timestamp and sequence number.
* Video frames are sent individually as JPEG at approximately 1 FPS with timestamp; sequence number may be unset.
* Each frame is a separate WebSocket message.
* No mode parameter; frames are sent as produced.
* The SFU automatically retries the same WebSocket endpoint for up to 5 seconds after brief disconnects.

### Close adapter

```

POST /v1/apps/{appId}/adapters/websocket/close


```

#### Request body

```

{

  "tracks": [

    {

      "adapterId": "string"

    }

  ]

}


```

## Media formats

### WebRTC tracks

* **Codec**: Opus
* **Sample rate**: 48 kHz
* **Channels**: Stereo

### WebSocket binary format

Media uses Protocol Buffers. Audio uses PCM payloads; video uses JPEG payloads:

* 16-bit signed little-endian PCM
* 48 kHz sample rate
* Stereo (left/right interleaved)
* Video: JPEG image payload (one frame per message)

```

message Packet {

    uint32 sequenceNumber = 1;  // Used in Stream mode only

    uint32 timestamp = 2;       // Used in Stream mode only

    bytes payload = 5;          // Media data

}


```

**Ingest mode (buffer)**: Only the `payload` field is used, containing chunks of audio data.

**Stream mode (egress)**:

* For audio frames:  
   * `sequenceNumber`: Incremental packet counter  
   * `timestamp`: Timestamp for synchronization  
   * `payload`: Individual PCM audio frame data
* For video frames (JPEG):  
   * `timestamp`: Timestamp for synchronization  
   * `payload`: JPEG image data (one frame per message)  
   * Note: `sequenceNumber` may be unset for video frames

### Video (JPEG)

* Supported WebRTC input codecs: H264, H265, VP8, VP9
* Output over WebSocket: JPEG images at approximately 1 FPS

## Connection protocol

Connects to your WebSocket endpoint:

1. WebSocket upgrade handshake
2. Secure connection for `wss://` URLs
3. Media streaming begins

### Message format

#### Buffer mode (ingest)

* **Binary messages**: PCM audio data in chunks
* **Maximum message size**: 32 KB per WebSocket message
* **Important**: Account for serialization overhead when chunking audio buffers
* Send audio in small, frequent chunks rather than large batches

#### Stream mode (egress)

* **Binary messages**: Individual frames with metadata (audio or video)
* Audio frames include:  
   * Timestamp information  
   * Sequence number  
   * PCM audio frame data
* Video frames include:  
   * Timestamp information  
   * JPEG image data  
   * Note: Sequence number may be unset for video frames
* Frames are sent individually as they arrive from the WebRTC track
* Video frames are emitted at approximately 1 FPS

### Connection lifecycle

1. Connects to the WebSocket endpoint
2. Audio streaming begins
3. Video streaming begins (if configured)
4. For WebRTC to WebSocket streaming, briefly retries the same endpoint after disconnects
5. Connection closes when closed, on error, or after the automatic reconnect window is exhausted

## Automatic reconnection for streaming

When you use the WebSocket adapter in [Stream mode (egress)](#stream-mode-egress) to send live audio or video from the SFU to your own WebSocket endpoint (`WebRTC → WebSocket`), the SFU automatically reconnects after brief endpoint disconnects or restarts.

The SFU retries the same WebSocket endpoint for up to 5 seconds. No API changes are required. If the endpoint remains unavailable after the reconnect window, the adapter closes and your application must create a new adapter to resume streaming.

### Media buffering during reconnect

Automatic reconnection uses live-first buffering while the WebSocket endpoint is temporarily unavailable:

* **Audio buffering**: The SFU keeps a short, bounded backlog of audio frames. If the interruption lasts longer than the backlog can cover, older audio may be dropped so reconnect recovery stays bounded.
* **Video buffering**: The SFU keeps only the latest available JPEG frame. Newer frames replace older frames while reconnecting, so video resumes near-live instead of replaying stale frames.
* **Delivery behavior**: Buffering reduces media loss during brief interruptions, but it is not a replay mechanism and does not guarantee gapless or exactly-once delivery.

Automatic reconnection applies only when using [Stream mode (egress)](#stream-mode-egress). It retries the same endpoint only and does not provide multi-endpoint failover.

## Prici

Currently in beta and free to use.

Once generally available, billing will follow standard Cloudflare Realtime pricing at $0.05 per GB egress. Only traffic originating from Cloudflare towards WebSocket endpoints incurs charges. Traffic ingested from WebSocket endpoints into Cloudflare incurs no charge.

Usage counts towards your Cloudflare Realtime free tier of 1,000 GB.

## Best practices

### Connection management

* Closing an already-closed instance returns success
* Close when sessions end
* When using [Stream mode (egress)](#stream-mode-egress), handle adapter closure after the 5-second [automatic reconnect window](#automatic-reconnection-for-streaming) is exhausted.
* When ingesting from WebSocket to WebRTC, implement reconnection logic in your WebSocket client if the connection drops.
* Make your WebSocket endpoint restart-safe so it can accept reconnects to the same URL during brief restarts.

### Performance

* Deploy WebSocket endpoints close to Cloudflare edge
* Use appropriate buffer sizes
* Monitor connection quality

### Security

* Secure WebSocket endpoints with authentication
* Use `wss://` for production
* Implement rate limiting

## Limitations

* **WebSocket payloads**: PCM (audio) for ingest and stream; JPEG (video) for stream
* **Beta status**: API may change in future releases
* **Video support**: Egress only (JPEG)
* **Video frame rate**: Approximately 1 FPS (beta; not configurable)
* **Streaming reconnects**: When using [Stream mode (egress)](#stream-mode-egress), the SFU automatically retries the same WebSocket endpoint for short disconnects only. It does not fail over to alternate endpoints.
* **Best-effort recovery**: Brief reconnects reduce media loss, but do not guarantee gapless or exactly-once delivery.
* **Video reconnect behavior**: Video resumes from the latest available JPEG frame rather than replaying older frames.
* **Unidirectional flow**: Each instance handles one direction

## Error handling

| Error Code | Description                              |
| ---------- | ---------------------------------------- |
| 400        | Invalid request parameters               |
| 404        | Session or track not found               |
| 503        | Adapter not found (for close operations) |

## Reference implementations

* Audio (PCM over WebSocket): [Cloudflare Realtime Examples – ai-tts-stt ↗](https://github.com/cloudflare/realtime-examples/tree/main/ai-tts-stt)
* Video (JPEG egress): [Cloudflare Realtime Examples – video-to-jpeg ↗](https://github.com/cloudflare/realtime-examples/tree/main/video-to-jpeg)

## Migration from custom bridges

1. Replace custom signaling with adapter API calls
2. Update WebSocket endpoints to handle PCM format
3. Implement adapter lifecycle management
4. Remove custom STUN/TURN configuration

## FAQ

**Q: Can I use the same adapter for bidirectional audio?**A: No, each instance is unidirectional. Create separate adapters for send and receive.

**Q: What happens if the WebSocket connection drops?**

A: When using [Stream mode (egress)](#stream-mode-egress), the SFU automatically retries the same WebSocket endpoint for up to 5 seconds. If the endpoint comes back within that window, streaming resumes automatically.

Audio uses a short bounded backlog to reduce audible loss during brief interruptions. Video resumes from the latest available JPEG frame instead of replaying older frames.

If the endpoint remains unavailable after the 5-second [automatic reconnect window](#automatic-reconnection-for-streaming), the adapter closes and must be recreated.

When ingesting from WebSocket to WebRTC, your WebSocket client should reconnect and recreate the adapter as needed.

**Q: Is there a limit on concurrent adapters?**A: Limits follow standard Cloudflare Realtime quotas. Contact support for specific requirements.

**Q: Can I change the audio format after creating an adapter?**A: No, audio format is fixed at creation time. Create a new adapter for different formats.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/media-transport-adapters/","name":"Media Transport Adapters"}},{"@type":"ListItem","position":5,"item":{"@id":"/realtime/sfu/media-transport-adapters/websocket-adapter/","name":"WebSocket adapter"}}]}
```
---
title: Limits, timeouts and quotas
description: Realtime SFU rate limits, track timeouts, session constraints, and free tier quotas.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Limits, timeouts and quotas

Understanding the limits and timeouts of Cloudflare Realtime is crucial for optimizing the performance and reliability of your applications. This section outlines the key constraints and behaviors you should be aware of when integrating Cloudflare Realtime into your app.

## Free

* Each account gets 1,000GB/month of data transfer from Cloudflare to your client for free.
* Data transfer from your client to Cloudflare is always free of charge.

## Limits

* **API Realtime per Session**: You can make up to 50 API calls per second for each session. There is no ratelimit on a App basis, just sessions.
* **Tracks per API Call**: Up to 64 tracks can be added with a single API call. If you need to add more tracks to a session, you should distribute them across multiple API calls.
* **Tracks per Session**: There's no upper limit to the number of tracks a session can contain, the practical limit is governed by your connection's bandwidth to and from Cloudflare.

## Inactivity Timeout

* **Track Timeout**: Tracks will automatically timeout and be garbage collected after 30 seconds of inactivity, where inactivity is defined as no media packets being received by Cloudflare. This mechanism ensures efficient use of resources and session cleanliness across all Sessions that use a track.

## PeerConnection Requirements

* **Session State**: For any operation on a session (e.g., pulling or pushing tracks), the PeerConnection state must be `connected`. Operations will block for up to 5 seconds awaiting this state before timing out. This ensures that only active and viable sessions are engaged in media transmission.

## Handling Connectivity Issues

* **Internet Connectivity Considerations**: The potential for internet connectivity loss between the client and Cloudflare is an operational reality that must be addressed. Implementing a detection and reconnection strategy is recommended to maintain session continuity. This could involve periodic 'heartbeat' signals to your backend server to monitor connectivity status. Upon detecting connectivity issues, automatically attempting to reconnect and establish a new session is advised. Sessions and tracks will remain available for reuse for 30 seconds before timing out, providing a brief window for reconnection attempts.

Adhering to these limits and understanding the timeout behaviors will help ensure that your applications remain responsive and stable while providing a seamless user experience.

## Supported Codecs

Cloudflare Realtime supports the following codecs:

### Supported video codecs

* **H264**
* **H265**
* **VP8**
* **VP9**
* **AV1**

### Supported audio codecs

* **Opus**
* **G.711 PCM (A-law)**
* **G.711 PCM (µ-law)**

Note

For external 48kHz PCM support refer to the [WebSocket adapter](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/websocket-adapter/)

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/limits/","name":"Limits, timeouts and quotas"}}]}
```
---
title: DataChannels
description: Send arbitrary real-time data between clients using Realtime SFU DataChannels.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# DataChannels

DataChannels are a way to send arbitrary data, not just audio or video data, between client in low latency. DataChannels are useful for scenarios like chat, game state, or any other data that doesn't need to be encoded as audio or video but still needs to be sent between clients in real time.

While it is possible to send audio and video over DataChannels, it's not optimal because audio and video transfer includes media specific optimizations that DataChannels do not have, such as simulcast, forward error correction, better caching across the Cloudflare network for retransmissions.

graph LR
    A[Publisher] -->|Arbitrary data| B[Cloudflare Realtime SFU]
    B -->|Arbitrary data| C@{ shape: procs, label: "Subscribers"}

DataChannels on Cloudflare Realtime can scale up to many subscribers per publisher, there is no limit to the number of subscribers per publisher.

### How to use DataChannels

1. Create two Realtime sessions, one for the publisher and one for the subscribers.
2. Create a DataChannel by calling /datachannels/new with the location set to "local" and the dataChannelName set to the name of the DataChannel.
3. Create a DataChannel by calling /datachannels/new with the location set to "remote" and the sessionId set to the sessionId of the publisher.
4. Use the DataChannel to send data from the publisher to the subscribers.

### Unidirectional DataChannels

Cloudflare Realtime SFU DataChannels are one way only. This means that you can only send data from the publisher to the subscribers. Subscribers cannot send data back to the publisher. While regular MediaStream WebRTC DataChannels are bidirectional, this introduces a problem for Cloudflare Realtime because the SFU does not know which session to send the data back to. This is especially problematic for scenarios where you have multiple subscribers and you want to send data from the publisher to all subscribers at scale, such as distributing game score updates to all players in a multiplayer game.

To send data in a bidirectional way, you can use two DataChannels, one for sending data from the publisher to the subscribers and one for sending data the opposite direction.

## Example

An example of DataChannels in action can be found in the [Realtime Examples github repo ↗](https://github.com/cloudflare/calls-examples/tree/main/echo-datachannels).

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/datachannels/","name":"DataChannels"}}]}
```
---
title: Simulcast
description: Send multiple video quality levels with WebRTC simulcast on Realtime SFU.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Simulcast

Simulcast is a feature of WebRTC that allows a publisher to send multiple video streams of the same media at different qualities. For example, this is useful for scenarios where you want to send a high quality stream for desktop users and a lower quality stream for mobile users.

graph LR
    A[Publisher] -->|Low quality| B[Cloudflare Realtime SFU]
    A -->|Medium quality| B
    A -->|High quality| B
B -->|Low quality| C@{ shape: procs, label: "Subscribers"}
B -->|Medium quality| D@{ shape: procs, label: "Subscribers"}
B -->|High quality| E@{ shape: procs, label: "Subscribers"}

### How it works

Simulcast in WebRTC allows a single video source, like a camera or screen share, to be encoded at multiple quality levels and sent simultaneously, which is beneficial for subscribers with varying network conditions and device capabilities. The video source is encoded into multiple streams, each identified by RIDs (RTP Stream Identifiers) for different quality levels, such as low, medium, and high. These simulcast streams are described in the SDP you send to Cloudflare Realtime SFU. It's the responsibility of the Cloudflare Realtime SFU to ensure that the appropriate quality stream is delivered to each subscriber based on their network conditions and device capabilities.

Cloudflare Realtime SFU will automatically handle the simulcast configuration based on the SDP you send to it from the publisher. The SFU will then automatically switch between the different quality levels based on the subscriber's network conditions, or the quality level can be controlled manually via the API. You can control the quality switching behavior using the `simulcast` configuration object when you send an API call to start pulling a remote track.

### Quality Control

The `simulcast` configuration object in the API call when you start pulling a remote track allows you to specify:

* `preferredRid`: The preferred quality level for the video stream (RID for the simulcast stream. [RIDs can be specified by the publisher. ↗](https://developer.mozilla.org/en-US/docs/Web/API/RTCRtpSender/setParameters#encodings))
* `priorityOrdering`: Controls how the SFU handles bandwidth constraints.  
   * `none`: Keep sending the preferred layer, set via the preferredRid, even if there's not enough bandwidth.  
   * `asciibetical`: Use alphabetical ordering (a-z) to determine priority, where 'a' is most desirable and 'z' is least desirable.
* `ridNotAvailable`: Controls what happens when the preferred RID is no longer available, for example when the publisher stops sending it.  
   * `none`: Do nothing.  
   * `asciibetical`: Switch to the next available RID based on the priority ordering, where 'a' is most desirable and 'z' is least desirable.  
You will likely want to order the asciibetical RIDs based on your desired metric, such as highest resolution to lowest or highest bandwidth to lowest.

### Bandwidth Management across media tracks

Cloudflare Realtime treats all media tracks equally at the transport level. For example, if you have multiple video tracks (cameras, screen shares, etc.), they all have equal priority for bandwidth allocation. This means:

1. Each track's simulcast configuration is handled independently
2. The SFU performs automatic bandwidth estimation and layer switching based on network conditions independently for each track

### Layer Switching Behavior

When a layer switch is requested (through updating `preferredRid`) with the `/tracks/update` API:

1. The SFU will automatically generate a Full Intraframe Request (FIR)
2. PLI generation is debounced to prevent excessive requests

### Publisher Configuration

For publishers (local tracks), you only need to include the simulcast attributes in your SDP. The SFU will automatically handle the simulcast configuration based on the SDP. For example, the SDP should contain a section like this:

```

a=simulcast:send f;h;q

a=rid:f send

a=rid:h send

a=rid:q send


```

If the publisher endpoint is a browser you can include these by specifying `sendEncodings` when creating the transceiver like this:

JavaScript

```

const transceiver = peerConnection.addTransceiver(track, {

  direction: "sendonly",

  sendEncodings: [

    { scaleResolutionDownBy: 1, rid: "f" },

    { scaleResolutionDownBy: 2, rid: "h" },

    { scaleResolutionDownBy: 4, rid: "q" },

  ],

});


```

## Example

Here's an example of how to use simulcast with Cloudflare Realtime:

1. Create a new local track with simulcast configuration. There should be a section in the SDP with `a=simulcast:send`.
2. Use the [Cloudflare Realtime API](https://developers.cloudflare.com/realtime/sfu/https-api) to push this local track, by calling the /tracks/new endpoint.
3. Use the [Cloudflare Realtime API](https://developers.cloudflare.com/realtime/sfu/https-api) to start pulling a remote track (from another browser or device), by calling the /tracks/new endpoint and specifying the `simulcast` configuration object along with the remote track ID you get from step 2.

For more examples, check out the [Realtime Examples GitHub repository ↗](https://github.com/cloudflare/calls-examples/tree/main/echo-simulcast).

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/simulcast/","name":"Simulcast"}}]}
```
---
title: Demos
description: Explore demo applications and interactive visualizations for Cloudflare Realtime SFU.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Demos

Learn how you can use Realtime within your existing architecture.

## Interactive Demos

### Global SFU Network Visualization

An interactive visualization showing how Realtime uses Cloudflare's global network as a distributed SFU. Click anywhere on the map to add participants and watch them connect to their nearest datacenter via anycast routing, with media tracks flowing along Cloudflare's private backbone.

[View Global SFU Visualization ↗](https://realtime-sfu.dev-demos.workers.dev)

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/demos/","name":"Demos"}}]}
```
---
title: Example architecture
description: Reference architecture for building a video calling application with Realtime SFU.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Example architecture

![Example Architecture](https://developers.cloudflare.com/_astro/video-calling-application.CIYa-lzM_2b10aI.webp)

1. Clients connect to the backend service
2. Backend service manages the relationship between the clients and the tracks they should subscribe to
3. Backend service contacts the Cloudflare Realtime API to pass the SDP from the clients to establish the WebRTC connection.
4. Realtime API relays back the Realtime API SDP reply and renegotiation messages.
5. If desired, headless clients can be used to record the content from other clients or publish content.
6. Admin manages the rooms and room members.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/example-architecture/","name":"Example architecture"}}]}
```
---
title: Pricing
description: Cloudflare Realtime SFU and TURN pricing, free tier details, and billing information.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Pricing

Cloudflare Realtime billing is based on data sent from Cloudflare edge to your application.

Cloudflare Realtime SFU and TURN services cost $0.05 per GB of data egress.

There is a free tier of 1,000 GB before any charges start. This free tier includes usage from both SFU and TURN services, not two independent free tiers. Cloudflare Realtime billing appears as a single line item on your Cloudflare bill, covering both SFU and TURN.

Traffic between Cloudflare Realtime TURN and Cloudflare Realtime SFU or Cloudflare Stream (WHIP/WHEP) does not get double charged, so if you are using both SFU and TURN at the same time, you will get charged for only one.

### TURN

Please see the [TURN FAQ page](https://developers.cloudflare.com/realtime/turn/faq), where there is additional information on specifically which traffic path from RFC8656 is measured and counts towards billing.

### SFU

Only traffic originating from Cloudflare towards clients incurs charges. Traffic pushed to Cloudflare incurs no charge even if there is no client pulling same traffic from Cloudflare.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/pricing/","name":"Pricing"}}]}
```
---
title: Changelog
description: Changelog and release notes for the Cloudflare Realtime SFU platform.
image: https://developers.cloudflare.com/dev-products-preview.png
---

> Documentation Index  
> Fetch the complete documentation index at: https://developers.cloudflare.com/realtime/llms.txt  
> Use this file to discover all available pages before exploring further.

[Skip to content](#%5Ftop) 

# Changelog

[ Subscribe to RSS ](https://developers.cloudflare.com/realtime/sfu/changelog/index.xml)

## 2025-11-21

**WebSocket adapter video (JPEG) support**

Updated Media Transport Adapters (WebSocket adapter) to support video egress as JPEG frames in addition to audio.

* Stream audio and video between WebRTC tracks and WebSocket endpoints
* Video egress-only as JPEG at approximately 1 FPS for snapshots, thumbnails, and computer vision pipelines
* Clarified media formats for PCM audio and JPEG video over Protocol Buffers
* Updated docs: [Adapters](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/), [WebSocket adapter](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/websocket-adapter/)

## 2025-08-29

**Media Transport Adapters (WebSocket) open beta**

Open beta for Media Transport Adapters (WebSocket adapter) to bridge audio between WebRTC and WebSocket.

* Ingest (WebSocket → WebRTC) and Stream (WebRTC → WebSocket)
* Opus for WebRTC tracks; PCM over WebSocket via Protocol Buffers

Docs: [Adapters](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/), [WebSocket adapter](https://developers.cloudflare.com/realtime/sfu/media-transport-adapters/websocket-adapter/)

## 2024-09-25

**TURN service is generally available (GA)**

Cloudflare Realtime TURN service is generally available and helps address common challenges with real-time communication. For more information, refer to the [blog post](https://blog.cloudflare.com/webrtc-turn-using-anycast/) or [TURN documentation](https://developers.cloudflare.com/realtime/turn/).

## 2024-04-04

**Orange Meets availability**

Orange Meets, Cloudflare's internal video conferencing app, is open source and available for use from [Github](https://github.com/cloudflare/orange?cf%5Ftarget%5Fid=40DF7321015C5928F9359DD01303E8C2).

## 2024-04-04

**Cloudflare Realtime open beta**

Cloudflare Realtime is in open beta and available from the Cloudflare Dashboard.

## 2022-09-27

**Cloudflare Realtime closed beta**

Cloudflare Realtime is available as a closed beta for users who request an invitation. Refer to the [blog post](https://blog.cloudflare.com/announcing-cloudflare-calls/) for more information.

```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"@id":"/directory/","name":"Directory"}},{"@type":"ListItem","position":2,"item":{"@id":"/realtime/","name":"Realtime"}},{"@type":"ListItem","position":3,"item":{"@id":"/realtime/sfu/","name":"Realtime SFU"}},{"@type":"ListItem","position":4,"item":{"@id":"/realtime/sfu/changelog/","name":"Changelog"}}]}
```
