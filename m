Return-Path: <linux-iio+bounces-27501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D610ACF9673
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A0D30303AA
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B93203BC;
	Tue,  6 Jan 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHefFzrB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F794261B83;
	Tue,  6 Jan 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717375; cv=none; b=ABeLHlUdXA7yK1PYlVWbNuTm7c0QDoIPnri2jMA20iayfPtzJeCH9oAJhwei1mida77b6S6aUbeY0cZrXKaFjEJxlGwjqIr274DUmizTjken//t45RwfMHzTVX2HTZ7NAMM5fKNJ1093tck3eDFnSTbUsoS9dYkqtTeTZSHzElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717375; c=relaxed/simple;
	bh=6NeC5B3RXH7gMhziiOuJTLCjFFUUsX2l5Ssof4Xas80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnr2KJjVdYRlnhG4YvmUkJgQwDKy6Fmoo/uA9MO+BCs9z8R5+PozEz90Gn2rQQ4yKCv/OtGfJ3Duf0/z1lkCR58+kKdk5cO/L7+p+LRAe9ciDIGKfW9pyw2zFfWm8phPyX8jwYx8hFBYHcovo/8Uw7WNbN42cwBlnikdCid0J2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHefFzrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86408C116C6;
	Tue,  6 Jan 2026 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717374;
	bh=6NeC5B3RXH7gMhziiOuJTLCjFFUUsX2l5Ssof4Xas80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHefFzrBYXA4m7kkjY9+OHkTgZN/0W9/bZlPS9d9wn1FMpQo9cNAse2PTOIHHIm+c
	 YGUzXnCpCNuUS7Mcs41sJfyU3Z+v53iXHSWX0Sn7vhoOOaXbgBw8M40MRP3RCYV2Dx
	 gxJW3s8EEse/7aqPrJBYEFlaorvuPs1J7Vtxop10YoDtsOWusPJ92yG+aHL6eJJKxs
	 q7QSpyhMPaJ1bxi8ydj5wAZ5ePGagpM8DjSJjlyIjMf48lIivXQEltlktU+FQE+VhA
	 IntvpEihFTuNft8VoG2F8sUAQBoS/vd70xTx2BvnlG2tbCFyLemEvg+5yZUBViDYuy
	 UnhtfSOrA7uzA==
Date: Tue, 6 Jan 2026 10:36:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	devicetree@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to
 arrays
Message-ID: <176771732187.2212863.8498767353794540092.robh@kernel.org>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>


On Fri, 19 Dec 2025 15:32:09 -0600, David Lechner wrote:
> Change spi-rx-bus-width and spi-tx-bus-width properties from single
> uint32 values to arrays of uint32 values. This allows describing SPI
> peripherals connected to controllers that have multiple data lanes for
> receiving or transmitting two or more words in parallel.
> 
> Each index in the array corresponds to a physical data lane (one or more
> wires depending on the bus width). Additional mapping properties will be
> needed in cases where a lane on the controller or peripheral is skipped.
> 
> Bindings that make use of this property are updated in the same commit
> to avoid validation errors.
> 
> The adi,ad4030 binding can now better describe the chips multi-lane
> capabilities, so that binding is refined and gets a new example.
> 
> Converting from single uint32 to array of uint32 does not break .dts/
> .dtb files since there is no difference between specifying a single
> uint32 value and an array with a single uint32 value in devicetree.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes:
> - New patch to replace data-lanes property patch.
> 
> In v3, Rob suggested possibly splitting the spi-controller.yaml file
> to have a way to make most SPI controllers have maxItems: 1 for these
> properties. I would like to avoid that because it doesn't seem scalable,
> e.g. if we need another similar split in the future, the number of
> combinations would grow exponentially (factorially?). I have an idea to
> instead do this using $dynamicAnchor and $dynamicRef, but dt-schema
> doesn't currently support that. So I propose we do the best we can for
> now with the current dt-schema and make further improvements later.
> 
> Also, in v3, I suggested that we could have leading 0s in the arrays
> to indicate unused lanes. But after further consideration, I think it's
> better to have separate lane-mapping properties for that purpose. It
> will be easier to explain and parse and be a bit more flexible that way.
> ---
>  .../bindings/display/panel/sitronix,st7789v.yaml   |  5 +--
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 42 +++++++++++++++++++++-
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  5 +--
>  .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |  6 ++--
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  6 ++--
>  .../bindings/spi/nvidia,tegra210-quad.yaml         |  6 ++--
>  .../bindings/spi/spi-peripheral-props.yaml         | 26 ++++++++++----
>  7 files changed, 79 insertions(+), 17 deletions(-)
> 

You'll need to add spi/andestech,ae350-spi.yaml which is only in Mark's 
tree, but otherwise:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


