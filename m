Return-Path: <linux-iio+bounces-26370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8ABC7B71D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94B93A3C2F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE82F39A1;
	Fri, 21 Nov 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCnNJxCk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B921B9C0;
	Fri, 21 Nov 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752245; cv=none; b=CQXuziCweg74yEBE7cGI/e0+hWYYTQFp3et4WKIP9b1AEwkWGdKy3W2LbBCTcHVoejkSmZqTyaa01uplnQzrRmEZqLrlzt45y44l7xmQ4f0vxx5oOUVEU0qGEO9qJ7UdwfNVyylXBlbL2Owu8YMP6dVDl8ILNVplbo0OQywNGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752245; c=relaxed/simple;
	bh=03+ZOzTwF9M4v7K3yjvU7O+FHmJzYKVJyK5NJUcBwrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhUB6rMGaVGoOrPZghIZMyw1N2kc2gxAFaaEgVhmxrIQ78/IdRzvU3kxOh733edOtvmp/8CKiyuN7CxL6FVqSknVtxmib88THO8SHbKfazLW0zD47isc8GOs+m9jtAh666A11wn1muvqEeSZevx9ZYdJR5rexIicgAz2C0oYk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCnNJxCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E843C4CEF1;
	Fri, 21 Nov 2025 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763752244;
	bh=03+ZOzTwF9M4v7K3yjvU7O+FHmJzYKVJyK5NJUcBwrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bCnNJxCkHjiwFQqNKxiK4AaEZLWZQCecg6kqo7VJYy15G7e9xaCwg9f9DzC7HPYHx
	 F5qFluKMOilG49i/BapdTOf8TDHrw5Fo15ow7NeBKdnUaOGM8ozOvJ0IjgmGAXriyH
	 M+ap81zirCiXu3w9x2iJ4Ql4IZ7+bjqHNNQBZpDPss4aN9CjCymNKR7d1oguqECrup
	 xTGeJ/zHtKNVksKTToKmfTsZohUcfBwfX6fAlHOGqUym0N3r4wPqTucKGYVBENASVa
	 FKcChonpAL7KCv8/pR9pR/OQSqkceQvDHW4eHPITbO3k3syJ/KudOmBoN3Ef+j/s3r
	 85ZrJNgrLJOVg==
Message-ID: <32e76bff-f535-40ce-88e2-7bbf7da87620@kernel.org>
Date: Fri, 21 Nov 2025 20:10:40 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2025 18:16, Kurt Borja wrote:
> Add documentation for Texas Instruments ADS1018 and ADS1118
> analog-to-digital converters.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

You did not test it before sending, so no full review but few nits to
save you one round of reviews:

> ---
>  .../devicetree/bindings/iio/adc/ti,ads1118.yaml    | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml
> new file mode 100644
> index 000000000000..eb7228ed6ddb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1118.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1018/ADS1118 SPI analog to digital converter
> +
> +maintainers:
> +  - Kurt Borja <kuurtb@gmail.com>
> +
> +description: |
> +  The ADS1018/ADS1118 is a precision, low-power, 12-bit or 16-bit, noise-free,
> +  analog-to-digital converter (ADC). It integrates a programmable gain amplifier
> +  (PGA), voltage reference, oscillator and high-accuracy temperature sensor.
> +
> +  Datasheets:
> +    - ADS1018: https://www.ti.com/lit/ds/symlink/ads1018.pdf
> +    - ADS1118: https://www.ti.com/lit/ds/symlink/ads1118.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1018
> +      - ti,ads1118
> +
> +  reg:
> +    maxitems: 1
> +
> +  interrupts:
> +    description: DOUT/DRDY (Data Out/Data Ready) line.
> +    maxitems: 1
> +
> +  drdy-gpios:
> +    description:
> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
> +      distinguishing between latched and real DRDY IRQs.

I have feeling that you miss proper handling of IRQs (e.g. active level)
on your board.

> +    maxitems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +required:

This goes after patternProperties.

> +  - compatible
> +  - reg
> +  - drdy-gpios
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description: Properties for a single ADC channel.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +        description: The channel index (0-7).
> +
> +      ti,gain:

Use common property units.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +        description:
> +          Programmable gain amplifier configuration, as described in the PGA
> +          Config Register Field description. If not present, the default is
> +          used.
> +
> +      ti,datarate:

Use common property units.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7
> +        description:
> +          Data rate configuration, as described in the DR Config Register Field
> +          description. If not present, the default is used.

default:

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +    properties:
> +      compatible:
> +        contains:
> +          const: ti,ads1018
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            ti,datarate:
> +              maximum: 6
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi0 {

spi

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ads1118@0 {


Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

e.g. adc


> +            compatible = "ti,ads1118";
Best regards,
Krzysztof

