Return-Path: <linux-iio+bounces-26297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E633C6A79D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51281356A6F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AAC36827D;
	Tue, 18 Nov 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwBleh9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0F365A05;
	Tue, 18 Nov 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481440; cv=none; b=fV+v9aSNrt6H3NlAPwEfXjh/dm3vOT+n6JKkYEmtTD4Jsvh56iu7UDNA/zxfA/9Zi1h5jnlDlIndnvz98Gm49SB9CuAAF4Ozp4450qvl+Ig3WhZoCrDIm+2V7ZTU6cF6hATCxIpV6GeHdofNCpLn2oB0RMlif/SDEaRUUPfPx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481440; c=relaxed/simple;
	bh=idRAsV6uM03dWhIhWg26jqhQuDz/mORf5Ur8q/hbScg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q336JjYbEQ320XYTAHW+xRMgr3qWBVmxiovB90NvK3763v39Erahnq7focBqQnFpknLPe7BE+xVFISoXygvmdRKI1xr5EQ/tf/I+rICw69aC/VofIR/9vG5k3lsglR9tjWIvJOi45lMjQCVGUwy9Meu6DZL8vm1eiLIZcroP65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwBleh9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D623C19422;
	Tue, 18 Nov 2025 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481439;
	bh=idRAsV6uM03dWhIhWg26jqhQuDz/mORf5Ur8q/hbScg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwBleh9mfK9U5pjZmr17Kt8MU8q2DFw3YzUEYBKLMB9R1wb+1iPczvO0N7a0TEysB
	 F+9v4sc8ZaBKZefpitsS4Dt2RZRMdxJhz3qUH1QyRfZP125VsvHoCdR6PtQ5RRakLl
	 Wk2771Y/Hk8U+PL2aRgSFi4Jq5V815XqCuJljd/voN6iazoOh9QeE7BtR9a3dy5qnf
	 ku0+Vk5sWAgpmyiT0S9ycJlh+pi5Bi8PxhU0Z60ifbNbG8ptQbMyvBOu0OjNbCyrsB
	 aJDY+4N9Avxaw3OLLYicAT2r9HEueeC3y6VP1u97UZVzmlIs9G88mKxTuzeEyGQtwK
	 KBIl7p3fSUXgg==
Date: Tue, 18 Nov 2025 09:57:17 -0600
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
Subject: Re: [PATCH v2 1/6] spi: dt-bindings: Add spi-data-buses property
Message-ID: <20251118155717.GA3236324-robh@kernel.org>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-1-8a92693314d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-1-8a92693314d9@baylibre.com>

On Fri, Nov 07, 2025 at 02:52:47PM -0600, David Lechner wrote:
> Add a spi-data-buses property to the spi-peripheral-props binding to
> allow specifying the SPI data bus or buses that a peripheral is
> connected to in cases where the SPI controller has more than one
> physical SPI data bus.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v2 changes:
> * Renamed property from spi-buses to spi-data-buses to make it clear
>   that we are only talking about the SDI/SDO lines and not the entire
>   SPI bus (SCK, CS, etc).
> * Fixed prefix order in subject.
> 
> This patch has been seen before in a different series from Sean [1].
> 
> [1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-2-sean.anderson@linux.dev/
> 
> Changes:
> * Added maxItems. (8 is the most I've seen so far on an ADC)
> * Tweaked the description a bit.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 8b6e8fc009dbdc80978f3afef84ddc688ade4348..6fe739eaf09876b9c5d8902f792ca02181d7266f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -89,6 +89,18 @@ properties:
>      description:
>        Delay, in microseconds, after a write transfer.
>  
> +  spi-data-buses:

I think spi-data-map would be better.

Or we could just reuse 'data-lanes' property. It seems like the same 
problem of mapping peripheral lanes/lines to controller/host 
lanes/lines.

> +    description:
> +      Array of data bus numbers that describes which SPI data buses of the
> +      controller are connected to the peripheral. This only applies to
> +      peripherals connected to specialized SPI controllers that have multiple
> +      SPI data buses (a set of independent SDI/SDO lines each with its own
> +      serializer) on a single controller.

Please make it clear what's the index and what's the value: "The index 
corresponds to the peripheral data line and the value corresponds to the 
controller data line."

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 8
> +    default: [0]
> +
>    stacked-memories:
>      description: Several SPI memories can be wired in stacked mode.
>        This basically means that either a device features several chip
> 
> -- 
> 2.43.0
> 

