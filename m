Return-Path: <linux-iio+bounces-7935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE593D28B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552591C20DD4
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5561179658;
	Fri, 26 Jul 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkeUIeZF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87937219EA;
	Fri, 26 Jul 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994478; cv=none; b=SWMye6zPGuSMeP7AIha0Ao7LP9Y5PoCx4dojMn8Pj1yTbiVL2BXm3NZufI8I1d/lO249Y+YSE8ZEaC7J5cQs6jm8fZS6eDb5oAPRq8Kp4pKgWS33MKjyCdOj74YSHDK8ueYJslaAINgajcfbALFv8PcPhL1P3S3FW1JwmUPmUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994478; c=relaxed/simple;
	bh=AJV3jdHmfcDdWezRW7h9NN67//21E0RY2qnfL7YGT+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZyWaTKbYUDsQSXgG5vyOSsS33RpfwbAIER+C9vOcMZlwYOIOEBIY4HnopiZNBlJtZ7EEtBh2ikWhNXFTsOP0OV3dpuFWkPfCy1es8WJ4tuTRHMxdi9MXjBV1Kt7B86Gf9EqqZwhjB+QAE81xOpNe8qfHbywxkvKxB8U7guS/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkeUIeZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0408C32782;
	Fri, 26 Jul 2024 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721994478;
	bh=AJV3jdHmfcDdWezRW7h9NN67//21E0RY2qnfL7YGT+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkeUIeZF6AgayX0Jefc70l9RPMO4JUTL7wweyp8SR34bd/IYPsAzNrHkwK4Xuj6pY
	 RcYhCQUQKsrh0BVCEgaGpQw1hkt255i23v2RR4bDJwA3CB4PYtIqvEfmjNkm40k2b+
	 9JzDdF4ag7rcnhMoGWEAfiAjnWzwHWhIXgEMqWqlrXuOqaIVidLWCjd4tUdcN9Sclg
	 RbllQCwDXJxSW11SilNRatypKjLLkQLsZbdeVPSQjSBjrpvL+SXuQTGUVLqMJRkMc0
	 +EKppelAg6zgPl2U0d03dfThiGfl9ZktOGp1aB4WwSjPTdHQTxkv9/7PB8rNxztUDS
	 +VyXkflhQEaZg==
Date: Fri, 26 Jul 2024 06:47:55 -0500
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
Subject: Re: [PATCH RFC v3 1/9] spi: dt-bindings: add spi-offload properties
Message-ID: <20240726114755.GA985744-robh@kernel.org>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-1-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-1-7420e45df69b@baylibre.com>

On Mon, Jul 22, 2024 at 04:57:08PM -0500, David Lechner wrote:
> This adds a new provider/consumer property pair to the generic SPI
> bindings for use with peripherals connected to controllers that support
> offloading.
> 
> Here, offloading means that the controller has the ability to perform
> SPI transactions without any CPU intervention in some shape or form.
> 
> The spi-offloads property will be used to assign controller offload
> resources to each peripheral that needs them. What these resources are
> will be defined by each specific controller binding by specifying the
> value of the #spi-offload-cells property.
> 
> SPI peripherals that use multiple offload instances at the same time
> for different functions can describe the functions using the
> spi-offload-names property, for example, for a SPI flash memory, this
> might be "read", "erase" and "write" functions.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v3 changes:
> * Added #spi-offload-cells property to the controller binding.
> * Changed spi-offloads to phandle-array.
> * Added spi-offload-names property.
> 
> v2 changes:
> 
> In v1, instead of generic SPI bindings, there were only controller-
> specific bindings, so this is a new patch.
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml     |  5 +++++
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml         | 11 +++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 093150c0cb87..0af9cce80be9 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -105,6 +105,11 @@ properties:
>      required:
>        - compatible
>  
> +  '#spi-offload-cells':
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Number of cells in a SPI offload specifier.
> +

This is the SPI controller/bus schema, but this is likely not part of 
the SPI controller. So needs its own schema.

Some description around what you think would typically be in these cells 
would be good.

Rob


