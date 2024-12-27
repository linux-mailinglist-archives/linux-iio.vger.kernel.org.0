Return-Path: <linux-iio+bounces-13817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C04E9FD241
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B114A188391F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2401552ED;
	Fri, 27 Dec 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3wynKlI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679831876;
	Fri, 27 Dec 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289597; cv=none; b=IgvxuILCuMsOqZ40JMvHWhZyubQaOrutDhehFRm/B4pSMA3Bqx5JqR+LiKhxzai9HHtnoWVPyvdN4XuAsXACUDEOoEFURfXktK+gkqIrT60H7FveXe8RyWBGVQTVVC5uxGqhU3hXGCPX1Z0TXy3/cZ472rI5CiqtQB1NEqz9DEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289597; c=relaxed/simple;
	bh=2YEjN+pa/+LiRhJ86F+dGAvxc5hDpgRch3epyZwtoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yekz/OuLaQS4FIT+KyG0heWjb2SKP8sMO4bWn15Ku47IBG956JYNFThuACgr37TZTf0Y0K9txKo1rJp2gzMjtPLKyVUOviBdnihuA6v3nO3gyxBQhdXhsptGAak+qelqEuM0wWvO2CapEH1etoiwDT2Qlv2nBiQWwX4L4XH4nOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3wynKlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3142BC4CED0;
	Fri, 27 Dec 2024 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735289597;
	bh=2YEjN+pa/+LiRhJ86F+dGAvxc5hDpgRch3epyZwtoI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3wynKlIyliRs/fAvTft+JWoOzeRwWEKaPVEPGXAYMpn5sjQTNwjS/y3lOcDAE/1y
	 PwgOy/7ElRJNSHAQQgDoW+dVznl5hpycoE1q+hOiS+l2wxrsKwp3rfTxzmVrdVP9vW
	 QlYb9iHOOn4Jdfqfzo+ge9wM/58ld8gxbIJ+M+AG5xzEHQShYuMKS6pL6X38+j7Gko
	 WbXGqJNzdRuIl5mVocaUPfSSHNyFMBfZAtTCUnh6jS1IcZA2sdANKk+7eIOAfjYxDU
	 V04Gwoz0IELfBKr75NrkPAJ3+1J820mPvgW0j5snp5oa/Ds4WUsjLR9eXGd/xuJ4/2
	 A+iojb0knCVIg==
Date: Fri, 27 Dec 2024 09:53:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: add AD7191
Message-ID: <6ls6e7a6muzzd2gzjek3iqifsp26ecqt75d3oy5yrxrbt75tyh@dncuvziq6wcv>
References: <20241221155926.81954-1-alisa.roman@analog.com>
 <20241221155926.81954-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221155926.81954-3-alisa.roman@analog.com>

On Sat, Dec 21, 2024 at 05:56:01PM +0200, Alisa-Dariana Roman wrote:
> AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Sob mismatch.

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also 'scripts/checkpatch.pl --strict' and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.

> +  odr1-gpios:
> +    description: GPIO connected to ODR1 pin for output data rate selection

a/GPIO connected to//
That's just obvious, cannot be "SPI MOSI line connected to ODR1 pin",
right? Samee in all other places.

> +    maxItems: 1
> +
> +  odr2-gpios:
> +    description: GPIO connected to ODR2 pin for output data rate selection
> +    maxItems: 1
> +
> +  pga1-gpios:
> +    description: GPIO connected to PGA1 pin for gain selection
> +    maxItems: 1
> +
> +  pga2-gpios:
> +    description: GPIO connected to PGA2 pin for gain selection
> +    maxItems: 1
> +
> +  temp-gpios:
> +    description: GPIO connected to TEMP pin for temperature sensor enable
> +    maxItems: 1
> +
> +  chan-gpios:
> +    description: GPIO connected to CHAN pin for input channel selection
> +    maxItems: 1
> +
> +  clksel-gpios:
> +    description: GPIO connected to CLKSEL pin for clock source selection
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - avdd-supply
> +  - dvdd-supply
> +  - vref-supply
> +  - spi-cpol
> +  - spi-cpha
> +  - odr1-gpios
> +  - odr2-gpios
> +  - pga1-gpios
> +  - pga2-gpios
> +  - temp-gpios
> +  - chan-gpios
> +  - clksel-gpios
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi0 {

spi

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad7191";

Best regards,
Krzysztof


