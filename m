Return-Path: <linux-iio+bounces-7937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14393D31E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC831C22D3F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430017B4E9;
	Fri, 26 Jul 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThrUPTGu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355B225D4;
	Fri, 26 Jul 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997519; cv=none; b=khFf6Nub767hQ9vPGs9JpOfNqBK2hM7DVBuA4dL2+hFfFfJQOTgnKdE87A6t//8eNWCzawgLduAqP933ynJBSDJlxR5QPHUiQ4TGw+ojgbzZk0foH3H+rmN6B6f9qQyH52txk8L3BGHrAV0by6e+i0aXnj9b9bP4oHWovUAJEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997519; c=relaxed/simple;
	bh=aIgrrvN0tG/F61Hot3ipl4hWqwfIHUiLpR8AE2P0AqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfHYtoWMOY4e24fcl689xitlW0OhVuSAUo+ckCOocXn+1jBHeyPxUppuZmMq5feJG380uZm3TW/bEnFqA6fvFRbkZe9DjoGl0bSFrM2CfU2DNQv8MU5yVL0tLognv+QSireFBPgRouTPnrBWMUUgpfA4blk9ZIUMTxrhk7LmOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThrUPTGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64E5C32782;
	Fri, 26 Jul 2024 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721997519;
	bh=aIgrrvN0tG/F61Hot3ipl4hWqwfIHUiLpR8AE2P0AqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThrUPTGuPAHMBQg7kyHhzCBCvGDLEv2ETPUPPthKEfE6g4hPoOvXLEFuZs+YaQaxL
	 Se4APoYj9m2uA3HcIIKStsZ8kv2Vzb3bRPlk4lgfmcXdMCM+74GHDAP8M7IM+rnwO+
	 We8lKTRzmQKVzgNJgttnHCkfC8XS30fXbZNM1A1B1q89rLh80jjfNIBJH0nNUVAaP2
	 A1VoL0y6jaI2WjCPQkh7Rp73g/0ERCjJbFZ3DZGpQaFUrwXN/9pvUij/QHMaitwL2a
	 3lljmFm39SProHsDlcUzfNA8c2o5rFxVJ7i5D4GsXfKCGoRrT+zhd7bEYwPbp3xL9u
	 wJ58IXk8+V+bw==
Date: Fri, 26 Jul 2024 07:38:36 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 5/9] spi: dt-bindings: axi-spi-engine: document
 spi-offloads
Message-ID: <20240726123836.GA998909-robh@kernel.org>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>

On Mon, Jul 22, 2024 at 04:57:12PM -0500, David Lechner wrote:
> The AXI SPI Engine has support for hardware offloading capabilities.
> There can be up to 32 offload instances per SPI controller, so the
> bindings limit the value accordingly.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> RFC: I have a few questions about this one...
> 
> 1.  The trigger-source properties are borrowed from the leds bindings.
>     Do we want to promote this to a generic binding that can be used by
>     any type of device?

I would make it specific to spi-offload.

> 
> 2.  Some folks are working on adding DMA to TX stream support to the
>     AXI SPI Engine hardware. I assume that the `dmas` property is like
>     others where the order/index in the phandle array matters. So this
>     would mean that for device that only uses 1 out of the 32 offloads
>     and only uses 1 TX DMA channel, we would have to have 32 <0>s for
>     each of the possible RX dmas in the array. Any way to do some kind
>     of mapping to avoid this?

That's why -names exists.

> 
> 3.  In v2, we discussed about having some sort of data processing unit
>     between the AXI SPI Engine RX stream interface and the DMA channel
>     interface on the DMA controller. I haven't included this in the
>     bindings yet because we don't have a user yet. But it was suggested
>     that we could use the graph bindings for this. So here is what that
>     might look like:
> 
>     Additional property for the AXI SPI Engine controller bindings:
> 
>         out-ports:
>             $ref: /schemas/graph.yaml#/properties/ports
>             unevaluatedProperties: false
>             patternProperties:
>             "^port@1?[0-9a-f]$":
>                 $ref: /schemas/graph.yaml#/properties/port
>                 unevaluatedProperties: false
> 
>     And this would be connected to a device node similar to this:
> 
>         ip-block@3000 {
>             // Something similar to, but not exactly like
>             // http://analogdevicesinc.github.io/hdl/library/util_extract/index.html
>             compatible = "adi,crc-check";
>             // clock that runs this IP block
>             clocks = <&sysclk 15>;
>             // interrupt raised on bad CRC
>             interrupts = <&intc 99>;
>             interrupt-names = "crc";
>             // output stream with CRC byte removed piped to DMA
>             dmas = <&adc_dma 0>;
>             dma-names = "rx";
> 
>             port {
>                 adc_crc_check: endpoint {
>                     remote-endpoint: <&offload0_rx>;
>                 };
>             };
>         };
> 
>     Does this sound reasonable?

Shrug.

Unlike the offload which is internal to the controller driver?, isn't 
this specific to the device because it needs to be aware of any 
processing done or not done. Or maybe it wants to configure the 
processing.

OTOH, maybe this isn't any different than offload?

Rob

