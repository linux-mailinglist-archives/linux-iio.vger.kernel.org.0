Return-Path: <linux-iio+bounces-24358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6CB936A3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 23:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B162A47DC
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB231771E;
	Mon, 22 Sep 2025 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PTyUHbk0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961963115A5
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578362; cv=none; b=RJkLXuvM+LPrkRXXMPKqD2ZS9KUU5+gsIP6ceOrd1cJxlxmiC1wplAXDglyOpVFs1wZyf+uasGPlO6humQmdESgMYozNhZ8mslOcKp2rs/XRgjWnKmJxDT3iiFbb7Ks/k3ZrfPJ/QRuVDxMhOg5t9ssxDIecWr/G5rcmFHCrRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578362; c=relaxed/simple;
	bh=lPFkSA4urPrryk0oH1I0ODDGcpZpW1YuO+eJG87x5/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK9ZNutP9hIeNwR0LtEiK44c3IUq5LVcPlNsqiFI766Z789Qs3TmxkL+g1BzZ5OeBlcAJz31yyZbczmskswIfDdhb7a2VGpW52hBGdkzzrxPRklC/GGl26Mykk6N1O3+r6ZeHFyE8sR821GA+RyXnQVmhQZGKqbtbmTO2tZ3oiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PTyUHbk0; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74c7d98935eso2527344a34.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758578358; x=1759183158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQFriecXyyC8g9C9fp+Jbl0vuN1bPs3xTfIEODghZ8c=;
        b=PTyUHbk0hnTFMTiS5xqcPzXH7ZViHucV3IImNPaqo0atHVmPB0pV1tw4Ghr/ZOn54K
         gwaUKO9GMYTaZ32/Cws3DzVOLOf5FSZ9XWEw9TEHvB+L/BBJt4rtxEDPqAxMHFAEF/QH
         Fg7oZ6Zt7nTpnjE3A/j0SSvpZD3cs/LDaKwSEgEsyYGNtHXP3bxMC0CJHl4Rf3ajOlmr
         D+eSm95//F0az9tQEuHf4WIK1rP0VtRde4f4JYv8JwPKU5A7EuwTlO0WOzJJppjQ4oYs
         +Yk9ElvqYZYoXq7sng7TczN9+/JD6DJyCRNMyzk/b2+dVXpanIrwl6Nax6f3CgpldaQM
         6ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578358; x=1759183158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQFriecXyyC8g9C9fp+Jbl0vuN1bPs3xTfIEODghZ8c=;
        b=VSWPtZpDHdBtiZLozK+053lHH4oug59mYaswxWDzLmgK4tWFNaC1W6J4BrRH1Fs4+6
         bYfmvTL7cYxK7ev8sG48yd+MdFsr9h2u985C8gUNiXRyS7Nu8iA3atR0aeq5d4BBS7iH
         MIWfyAB7PPUosFks5FpuSeXfHJ59fmIewdsNzTBozuilr7UhTaHM/UM1YTgwQ63MyW7y
         7fXQFwsXuBgBkjTw6x601L9ahWjWgJvpSScJEyTQ0M0mc62pungNmIiCo4o29h6fzWXH
         BNLZ7dhmrVP60gMMaS4BpPE9Dpr0LO88l91XMJuk8PObQyA+GIOOD/arZIQI6siAajCV
         H/zQ==
X-Gm-Message-State: AOJu0Yxcq+HfKly+QUeNTxeQSpJx+mMNd3HYur7MniiW571U3hzMbr1o
	LomRv4AVHlAtFhAk4EVfw/4PWH5stdUZb/EHjxK0pV3iZe6zIVIJm1yOjbnNRlX6t4w=
X-Gm-Gg: ASbGncvg+r9IYia1flZgQOwd4sMtTl0Y48p5hVhCujlInv2uwJg9BRaE430GhwChHZ7
	+nEWsYuXfJQePmUDV/KCgSQzVS5ZLgpZv1N072Y+vLrZa+VnGfHuYjHi/NheuiXC/d6YYYgGaIf
	NAFIKng25j+Brlezvlp6ynuNvDTvWvEnNW7ZUOMTn5D5pQQMrW8w5O98IoIh6D88hDK1hOi9xZ6
	GuwqnADTs9Tq2J+oexS8IjRnZiQf47FMxwWYD0iKsVHNpVHop/7TgiS/sJJ16Ap8D5hvdU8aFIz
	lhBtv20M0ZaJUVUhqElE52mlVG5j63w3rn0/a8VjXfrgNni2G6tX/VL3jpjPFBQZugT85uQsrBT
	J77XHxh4pxAnDh57muEXf0vkkwE2VNIHwqgtvWw/oI0qY99h6nFhpQ19OKpL8vJhPOOjQkYNfJ/
	0=
X-Google-Smtp-Source: AGHT+IF4Zg64S4aMZbd52FqAlHa6Y4jsFMYO1DZaZDxK8iMMiuU2UfjpCvAUqb8C14Wa5++Dt4DliQ==
X-Received: by 2002:a05:6830:3784:b0:749:fac2:92fe with SMTP id 46e09a7af769-7912f920a14mr216371a34.0.1758578358464;
        Mon, 22 Sep 2025 14:59:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625dbab5cf1sm4209952eaf.22.2025.09.22.14.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:59:18 -0700 (PDT)
Message-ID: <7836f862-5320-4a81-b15b-4ada08e78077@baylibre.com>
Date: Mon, 22 Sep 2025 16:59:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
 <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 6:30 AM, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and
> MCP47F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 305 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 311 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d05ddafa37540bc1f6b6ce65a466b95913925c10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -0,0 +1,305 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp47feb02.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP47F(E/V)B(0/1/2)(1/2/4/8) DAC with I2C Interface Families
> +
> +maintainers:
> +  - Ariana Lazar <ariana.lazar@microchip.com>
> +
> +description: |
> +  Datasheet for MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
> +  MCP47FEB22 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
> +  Datasheet for MCP47FVBXX can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
> +  Datasheet for MCP47FEB04, MCP47FEB14, MCP47FEB24, MCP47FEB08, MCP47FEB18,
> +  MCP47FEB28, MCP47FVB04, MCP47FVB14, MCP47FVB24, MCP47FVB08, MCP47FVB18,
> +  MCP47FVB28 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
> +
> +  +------------+--------------+-------------+-------------+------------+
> +  | Device     |  Resolution  |   Channels  | Vref number | Memory     |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB01 |     8-bit    |      1      |      1      |   EEPROM   |
> +  | MCP47FEB11 |    10-bit    |      1      |      1      |   EEPROM   |
> +  | MCP47FEB21 |    12-bit    |      1      |      1      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB02 |     8-bit    |      2      |      1      |   EEPROM   |
> +  | MCP47FEB12 |    10-bit    |      2      |      1      |   EEPROM   |
> +  | MCP47FEB22 |    12-bit    |      2      |      1      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB01 |     8-bit    |      1      |      1      |      RAM   |
> +  | MCP47FVB11 |    10-bit    |      1      |      1      |      RAM   |
> +  | MCP47FVB21 |    12-bit    |      1      |      1      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB02 |     8-bit    |      2      |      1      |      RAM   |
> +  | MCP47FVB12 |    10-bit    |      2      |      1      |      RAM   |
> +  | MCP47FVB22 |    12-bit    |      2      |      1      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB04 |     8-bit    |      4      |      2      |      RAM   |
> +  | MCP47FVB14 |    10-bit    |      4      |      2      |      RAM   |
> +  | MCP47FVB24 |    12-bit    |      4      |      2      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB08 |     8-bit    |      8      |      2      |      RAM   |
> +  | MCP47FVB18 |    10-bit    |      8      |      2      |      RAM   |
> +  | MCP47FVB28 |    12-bit    |      8      |      2      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB04 |     8-bit    |      4      |      2      |   EEPROM   |
> +  | MCP47FEB14 |    10-bit    |      4      |      2      |   EEPROM   |
> +  | MCP47FEB24 |    12-bit    |      4      |      2      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB08 |     8-bit    |      8      |      2      |   EEPROM   |
> +  | MCP47FEB18 |    10-bit    |      8      |      2      |   EEPROM   |
> +  | MCP47FEB28 |    12-bit    |      8      |      2      |   EEPROM   |
> +  +------------+--------------+-------------+-------------+------------+
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp47feb01
> +      - microchip,mcp47feb11
> +      - microchip,mcp47feb21
> +      - microchip,mcp47feb02
> +      - microchip,mcp47feb12
> +      - microchip,mcp47feb22
> +      - microchip,mcp47fvb01
> +      - microchip,mcp47fvb11
> +      - microchip,mcp47fvb21
> +      - microchip,mcp47fvb02
> +      - microchip,mcp47fvb12
> +      - microchip,mcp47fvb22
> +      - microchip,mcp47fvb04
> +      - microchip,mcp47fvb14
> +      - microchip,mcp47fvb24
> +      - microchip,mcp47fvb08
> +      - microchip,mcp47fvb18
> +      - microchip,mcp47fvb28
> +      - microchip,mcp47feb04
> +      - microchip,mcp47feb14
> +      - microchip,mcp47feb24
> +      - microchip,mcp47feb08
> +      - microchip,mcp47feb18
> +      - microchip,mcp47feb28
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  vdd-supply:
> +    description: |

Don't need `|` unless formatting needs to be preserved, like for the table in
the description above or the bullet lists below.

> +      Provides power and it will be used as the reference voltage if vref-supply
> +      is not provided.
> +
> +  vref-supply:
> +    description: |
> +      Vref pin is used as a voltage reference when this supply is specified.
> +      Into the datasheet it could be found as a Vref0.
> +      If it does not exists the internal reference will be used.

It looks like there is also the possibility to use V_DD as the reference
voltage. Not sure the best way to handle that though.

> +      This will be used as a reference voltage for the following outputs:
> +        - for single-channel device: Vout0;
> +        - for dual-channel device: Vout0, Vout1;
> +        - for quad-channel device: Vout0, Vout2;
> +        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
> +
> +  vref1-supply:
> +    description: |
> +      Vref1 pin is used as a voltage reference when this supply is specified.
> +      If it does not exists the internal reference will be used.
> +      This will be used as a reference voltage for the following outputs:
> +        - for quad-channel device: Vout1, Vout3;
> +        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
> +
> +  lat-gpios:
> +    description: |
> +      LAT pin to be used as a hardware trigger to synchronously update the DAC
> +      channels and the pin is active Low. It could be also found as lat0 in
> +      datasheet.
> +    maxItems: 1
> +
> +  lat1-gpios:
> +    description: |
> +     LAT1 pin to be used as a hardware trigger to synchronously update the odd
> +     DAC channels on devices with 4 and 8 channels. The pin is active Low.
> +    maxItems: 1
> +
> +  microchip,vref-buffered:
> +    type: boolean
> +    description: |
> +      Enable buffering of the external Vref/Vref0 pin in cases where the
> +      external reference voltage does not have sufficient current capability in
> +      order not to drop it’s voltage when connected to the internal resistor
> +      ladder circuit.
> +
> +  microchip,vref1-buffered:
> +    type: boolean
> +    description: |
> +      Enable buffering of the external Vref1 pin in cases where the external
> +      reference voltage does not have sufficient current capability in order not
> +      to drop it’s voltage when connected to the internal resistor ladder
> +      circuit.
> +
> +  microchip,output-gain-2x:
> +    type: boolean
> +    description: |
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: dac.yaml
> +    type: object
> +    description: Voltage output channel.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        minimum: 1
> +        maximum: 7
> +
> +      label:
> +        description: Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47feb01
> +              - microchip,mcp47feb11
> +              - microchip,mcp47feb21
> +              - microchip,mcp47fvb01
> +              - microchip,mcp47fvb11
> +              - microchip,mcp47fvb21
> +    then:
> +      properties:
> +        lat-gpios: true
> +        lat1-gpios: false
> +        vref-supply: true
> +        vref1-supply: false
> +        microchip,vref-buffered: true

Everything is already true, so we can leave out all of those
lines. It make it hard to see what is actually being modified.

> +        microchip,vref1-buffered: false
> +      patternProperties:
> +       "^channel@[1]$":
> +        properties:
> +         reg:
> +          items:

No items: here.

> +            maximum: 1
> +        "^channel@[2-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47feb02
> +              - microchip,mcp47feb12
> +              - microchip,mcp47feb22
> +              - microchip,mcp47fvb02
> +              - microchip,mcp47fvb12
> +              - microchip,mcp47fvb22
> +    then:
> +      properties:
> +        lat-gpios: true
> +        lat1-gpios: false
> +        vref-supply: true
> +        vref1-supply: false
> +        microchip,vref-buffered: true
> +        microchip,vref1-buffered: false
> +      patternProperties:
> +       "^channel@[1-2]$":
> +        properties:
> +         reg:
> +          items:
> +            maximum: 1

Isn't maximum 2 in this case?

> +        "^channel@[3-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47fvb04
> +              - microchip,mcp47fvb14
> +              - microchip,mcp47fvb24
> +              - microchip,mcp47fvb08
> +              - microchip,mcp47fvb18
> +              - microchip,mcp47fvb28
> +              - microchip,mcp47feb04
> +              - microchip,mcp47feb14
> +              - microchip,mcp47feb24
> +              - microchip,mcp47feb08
> +              - microchip,mcp47feb18
> +              - microchip,mcp47feb28

Should the 8-channel chips be include here? This
limits the channel@ to 1-4, so that doesn't jive
with having 8 channels.

> +    then:
> +      properties:
> +        lat-gpios: true
> +        lat1-gpios: true
> +        vref-supply: true
> +        vref1-supply: true
> +        microchip,vref-buffered: true
> +        microchip,vref1-buffered: true
> +      patternProperties:
> +       "^channel@[1-4]$":
> +        properties:
> +         reg:
> +          items:
> +            maximum: 1

And 4 here?

> +       "^channel@[5-7]$": false
> +  - if:
> +      not:
> +        required:
> +          - vref-supply
> +    then:
> +      properties:
> +        microchip,vref-buffered: false
> +  - if:
> +      not:
> +        required:
> +          - vref1-supply
> +    then:
> +      properties:
> +        microchip,vref1-buffered: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        dac@0 {
> +          compatible = "microchip,mcp47feb02";
> +          reg = <0>;
> +          vdd-supply = <&vdac_vdd>;
> +          vref-supply = <&vref_reg>;
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          channel@0 {
> +            reg = <0>;
> +            label = "DAC_OUTPUT_0";

These aren't particularly useful labels. It gives
the same info as the register number.

> +          };
> +
> +          channel@1 {
> +            reg = <0x1>;
> +            label = "DAC_OUTPUT_1";
> +          };
> +      };
> +    };
> +...


