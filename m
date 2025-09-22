Return-Path: <linux-iio+bounces-24359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C6B936B7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 00:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A637A7EA3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DF2F617C;
	Mon, 22 Sep 2025 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJjF9VOW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8801E502;
	Mon, 22 Sep 2025 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578456; cv=none; b=JUgtu1ZF5W1kitdVRcIwHu+Y7yghZ+katLminIJBcySW3kvqLHsXenGCxBNg1navVPkUzAkMamYMuTHRBVkPc4LouOVExrndk0W5emk3gGDLqt7tV31HUvQhHOCWnUhVj187DOy4JxJLMb3CRg3ovGo2mifm45Z8eft4YtLwjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578456; c=relaxed/simple;
	bh=y4F5Q8UI8jEbr6PZWHKJIknJACl49zX4dkSjzhSSdUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c697YCvv1mQCKJ+Cq6h0smA63ETRTWMjxd5Ui0QVhwL4nqt8P6SE//LEG3GM+EwQJSZoFZqQh3gA8qYJkySPo3jAtyVk6OJapbHUe7L8c+ecLvhM6GijtjBDq4qwHvBNc6ltsEt/PPi2IjJI/efbuXhhrDCIwJxveRsBD2C7KYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJjF9VOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDBDC4CEF0;
	Mon, 22 Sep 2025 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758578455;
	bh=y4F5Q8UI8jEbr6PZWHKJIknJACl49zX4dkSjzhSSdUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJjF9VOWeSzHOb+WneKzU5dxiMzu00UXs0vHrJOIbuQs8Kgf9x5RD8W9e59PC306B
	 omrO557Q0o8NRon9DK6ElBf1tEukx3GX8EJ5Vq3hyj3/M/i0H0gj81qR2q88BuA65F
	 F+UAC98N9cd2RfidIsAHZnGfjTnhG4+HDrJtrroMtYnla84YHm9RcxrMVLCuWMW7k5
	 qhBS88EE4d1Q80SgN9YjkrWIQ6IbeShLN+WTOzncWL69DvYVOtHxzkWTe1b9DIESNQ
	 xSv6dyS0M7S+Ii5p1s47Cg5/aaGMSDUA15xee76uX+PQDvU/2vkdqIlGbDkmu1CNpt
	 QhQqJZFucgOXA==
Date: Mon, 22 Sep 2025 17:00:53 -0500
From: Rob Herring <robh@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
Message-ID: <20250922220053.GA1371364-robh@kernel.org>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
 <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>

On Mon, Sep 22, 2025 at 02:30:53PM +0300, Ariana Lazar wrote:
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

Don't need '|' if no formatting to preserve.

> +      Provides power and it will be used as the reference voltage if vref-supply
> +      is not provided.
> +
> +  vref-supply:
> +    description: |
> +      Vref pin is used as a voltage reference when this supply is specified.
> +      Into the datasheet it could be found as a Vref0.
> +      If it does not exists the internal reference will be used.

blank line between paragraphs. But is every sentence a paragraph?

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

?

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

true has no effect as the property is already allowed. Drop all the true 
cases.

> +        lat1-gpios: false
> +        vref-supply: true
> +        vref1-supply: false
> +        microchip,vref-buffered: true
> +        microchip,vref1-buffered: false
> +      patternProperties:
> +       "^channel@[1]$":

Did you mean "[01]"? If not, that's not a pattern, but a fixed string.


> +        properties:
> +         reg:
> +          items:
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

Based on the unit-address, the minimum is 1 and the maximum is 2. 
"enum: [ 1, 2 ]" is a bit more concise.

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

?

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
> +          };
> +
> +          channel@1 {
> +            reg = <0x1>;
> +            label = "DAC_OUTPUT_1";
> +          };
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa163f9fe8fe3f04bf66426f9a894409..6f51890cfc3081bc49c08fddc8af526c1ecc8d72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14938,6 +14938,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
>  F:	drivers/iio/potentiometer/mcp4018.c
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
> +MCP47FEB02 MICROCHIP DAC DRIVER
> +M:	Ariana Lazar <ariana.lazar@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +
>  MCP4821 DAC DRIVER
>  M:	Anshul Dalal <anshulusr@gmail.com>
>  L:	linux-iio@vger.kernel.org
> 
> -- 
> 2.43.0
> 

