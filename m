Return-Path: <linux-iio+bounces-26298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D94C6A746
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6F1F12C9CA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7801B368291;
	Tue, 18 Nov 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTmizjH4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B036826B;
	Tue, 18 Nov 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481549; cv=none; b=okOZRssyKy/v+znOWw6272EUePV3DZ9NQHCxz5E86oGYJcmRfBWLB+l8OmNWd0CqMClLL09ZWZjScNtYV5iS6lMjXz/poHVUQaqlzOQTX1M3TqBI3ISCE+cwoXs4YvAhnsChIugjWnxvlkOT79zS3aVqpl0FrUY7thSofV3keSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481549; c=relaxed/simple;
	bh=mu+F5dcHgAQNH4gip4qm7MaAGlv17GgF0Odh5VKbdTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR9DVfm7lnVhi96S+8XrMIqDQXIsd6K1LZQWFZbc7YtSGls2otIIK5xADOQo5H0r6xzfTffcVfhc4nDMZS7hmcbuKjPVBbc/i4P0TtXPQqNGkt9lQUzVNMECZP8YuLq+27ty/TDhPnq+97dVT1AxAX3FemmWM6KMR1mK0aahiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTmizjH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFB8C19422;
	Tue, 18 Nov 2025 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481548;
	bh=mu+F5dcHgAQNH4gip4qm7MaAGlv17GgF0Odh5VKbdTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTmizjH4fh1B/8G+7+ffhUVRojiXbbtEID2v4Lh74MW4myiDMBc8vDUkqEO2RPaze
	 UXk+0eMD/ODSpN6mzFlIuZQVcB6dly3QCDX2xXps/57kgifPhvYmRa9pC4dsItUWcJ
	 MOXnCqYjpeHTUzjlzteTAlNDJu2aSaFLiwQg79RKJLShbOK0ulyPK+O/p7jQgz8IKd
	 dGOEQPhsk/cOfSLZGpReMgC7c1JnkzWEEn/d/Y8fVLaBAFE5xelhjs28Hm/81PwKz1
	 AHLlwzi/h6rD5kiCYPei8/loB3DNHTUjWnkO3CgHNX7T+iwBTkwOarXXjz29IQAVXc
	 3VUUENIQS1Rvw==
Date: Tue, 18 Nov 2025 09:59:05 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
Message-ID: <20251118155905.GB3236324-robh@kernel.org>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>

On Fri, Nov 07, 2025 at 02:52:51PM -0600, David Lechner wrote:
> Add spi-buses property to describe how many SDO lines are wired up on
> the ADC. These chips are simultaneous sampling ADCs and have one SDO
> line per channel, either 2 or 4 total depending on the part number.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fbc345f58c5b09083385 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> @@ -62,6 +62,10 @@ properties:
>    spi-cpol: true
>    spi-cpha: true
>  
> +  spi-data-buses:
> +    minItems: 1
> +    maxItems: 4
> +

As the property is not required, what's the default?

>    vcc-supply:
>      description: A 3V to 3.6V supply that powers the chip.
>  
> @@ -245,6 +249,22 @@ allOf:
>        patternProperties:
>          "^channel@[0-3]$": false
>  
> +  # 2-channel chip can only have up to 2 buses
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,ad7380
> +            - adi,ad7381
> +            - adi,ad7386
> +            - adi,ad7387
> +            - adi,ad7388
> +            - adi,ad7389
> +    then:
> +      properties:
> +        spi-data-buses:
> +          maxItems: 2
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> @@ -260,6 +280,7 @@ examples:
>              spi-cpol;
>              spi-cpha;
>              spi-max-frequency = <80000000>;
> +            spi-data-buses = <0>, <1>;
>  
>              interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>              interrupt-parent = <&gpio0>;
> @@ -284,6 +305,7 @@ examples:
>              spi-cpol;
>              spi-cpha;
>              spi-max-frequency = <80000000>;
> +            spi-data-buses = <0>, <1>, <2>, <3>;

An example that doesn't look like a 1 to 1 mapping would be better. 
Otherwise, it still looks to me like you could just define the bus 
width.

>  
>              interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>              interrupt-parent = <&gpio0>;
> 
> -- 
> 2.43.0
> 

