Return-Path: <linux-iio+bounces-8041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E894081F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ABBB22568
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 06:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1D1684A5;
	Tue, 30 Jul 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n94dmUvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17F161914;
	Tue, 30 Jul 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320109; cv=none; b=e9TxzcwkNjQQFNOJNRw1yrAGOZBOaULAp37YTU3y3GHIq3L5184nK72WihI/mkCk+wF3l+dfcTfRAzq9XJjpAB76wJvNOuHUIkYPup4KyTJ0bEsaViyODvMeNmoNSPmL/QT2PBR6XLAqYeV31khT8pqpKjzWAHJffM3dSfmD6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320109; c=relaxed/simple;
	bh=Oej+fPpzXjgqOHYOYKIC4KwEdSHy7A5a1zk/PCs4epQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DZuolQlETkNihJZPLHnw/OhYE3ItE+1iBaVJCBK73iV3rMIsfSHk/6pFnmYvJ34GCmnjeYuIk+cL6CGND0WEx4pKxbCtk4Jg65b3TfwlKa2V8oT0P7PxgpqzzonY7YE+WtuQRwtjUNRxTjZO1dJ6yPao7llnxyPW78H0ElxGXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n94dmUvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F9EC32782;
	Tue, 30 Jul 2024 06:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722320109;
	bh=Oej+fPpzXjgqOHYOYKIC4KwEdSHy7A5a1zk/PCs4epQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=n94dmUvSFz4+yTb7QQvlcmXeM3yUX3zYyFXxK5DM6SG1ZLYqlmbQGxM2+BwSNJLwt
	 NsrNqbUgwa0GKDI2ve158JWh18SUKJ1+5xvyRrNgzbSCkC+leUgDjtZJQbpSt48YBR
	 4UbG0zBpxKg2gcMiKMx9L+PstGRsnEXy060m+A2bMCzIXYt5noY9yDIXSRtLqp2DBD
	 Hh+IqpbO63L8jDE408SsU4W2hlu8nM5P6sPaUkq6hh3hRRGf1R2snXiAL7FqI+6iBT
	 9zpF4MYgzv8o2aTGNXi618c4GIwSJliRy/6C5VZ4gY2v0SOzh0Sim89EJWRSsLq2Th
	 JHC9dxM6ufABQ==
Message-ID: <71cbe674-b232-4327-929b-351630907540@kernel.org>
Date: Tue, 30 Jul 2024 08:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
 <20240730030509.57834-2-Mariel.Tinaco@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240730030509.57834-2-Mariel.Tinaco@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 05:05, Mariel Tinaco wrote:
> This adds the bindings documentation for the 14-bit
> High Voltage, High Current, Waveform Generator
> Digital-to-Analog converter.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>

> +
> +  refio-1p2v-supply:
> +    description: Drive voltage in the range of 1.2V maximum to as low as
> +      low as 0.12V through the REF_IO pin to adjust full scale output span
> +
> +  clocks:

maxItems: 1
and drop description (or use items: - description, but then do not
repeat redundant parts)

> +    description: The clock for the DAC. This is the sync clock
> +
> +  adi,rset-ohms:
> +    description: Specify value of external resistor connected to FS_ADJ pin
> +      to establish internal HVDAC's reference current I_REF
> +    default: 2000
> +    minimum: 2000
> +    maximum: 20000
> +
> +  adi,range-microvolt:
> +    description: |
> +      Voltage output range specified as <minimum, maximum>
> +    oneOf:

Not an oneOf.

> +      - items:
> +          - const: -40000000
> +          - const: 40000000

Why do you need this property if this cannot be anything else? Drop.

> +
> +  adi,range-microamp:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Current output range specified as <minimum, maximum>
> +    oneOf:
> +      - items:
> +          - const: 0
> +          - const: 50000
> +      - items:
> +          - const: -50000
> +          - const: 50000
> +
> +  adi,temp-max-millicelsius:
> +    description: Overtemperature threshold
> +    default: 50000
> +    minimum: 20000
> +    maximum: 150000
> +
> +  sdn-reset-gpios:

reset-gpios or shutdown-gpios or anything from gpio-consumer-common
which is not deprecated.

> +    description: GPIO spec for the SHUTDOWN RESET pin. As the line is active high,

Do not repeat the obvious or redundant parts. There is no point in
saying that "GPIO spec is a GPIO spec for ...". It cannot be anything
else than GPIO spec. Instead say something useful. It's confusing to
have two reset pins, so explain what is the purpose of this pin.

> +      it should be marked GPIO_ACTIVE_HIGH.

Drop last part "it should be marked", because it is clearly incorrect.
Different board designs can have it differently.


> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. As the line is active low, it
> +      should be marked GPIO_ACTIVE_LOW.

Again, marking it always as active low is not correct. It is enough to
say that line is active low.

> +    maxItems: 1
> +
> +  sdn-io-gpios:
> +    description: GPIO spec for the SHUTDOWN INPUT/OUTPUT pin. As the line is
> +      active high, it should be marked GPIO_ACTIVE_HIGH.

What's the purpose?

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad8460";
> +            reg = <0>;
> +            spi-max-frequency = <8000000>;
> +            adi,rset-ohms = <2000>;
> +            adi,range-microvolt = <(-40000000) 40000000>;
> +            adi,range-microamp = <0 50000>;
> +            adi,temp-max-millicelsius = <50000>;

Custom properties go to the end. See DTS coding style.

> +
> +            dmas = <&tx_dma 0>;
> +            dma-names = "tx";


Best regards,
Krzysztof


