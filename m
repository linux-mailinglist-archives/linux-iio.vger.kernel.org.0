Return-Path: <linux-iio+bounces-26915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA5CAB96A
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 20:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89AE93017677
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799925F995;
	Sun,  7 Dec 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7lVxxx5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3B1D5147;
	Sun,  7 Dec 2025 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765136000; cv=none; b=gUej0RC1DQjvzEnbUM5fLecH8CcfmgoKESgTVsmz/b4bbhGFenLBonAWRK4PwgEuz2H6dY/CErSjgSiJcwf8TLeKMF0K2j/Q9/Aj0Xef6JAg1Tk65V1pMR8jE5mvZl9aEm8WhdjimTg1qDa5V6UGQKtufMPc7MzCaiZHkItm3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765136000; c=relaxed/simple;
	bh=Wew3Tkkd72lI0vJkrNIBhy/HAu3GIoiuVNyTvl8eY8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6x/tHzXJ5WlxXdaOyrmcuk2D4IleGbT3SYxzvDoF+M57f0MmK0DMpl7FWZOKdvhsg3WRQvTffalyj1HRq2d1CHSoa3+9GFi33RteJhPWYt6Q0Dp7qhJZb7b0iSbDlljUUyK4omOxwiKtSpO3UjT9r+N+v1IamBrC2CKII01dbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7lVxxx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55259C4CEFB;
	Sun,  7 Dec 2025 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765135999;
	bh=Wew3Tkkd72lI0vJkrNIBhy/HAu3GIoiuVNyTvl8eY8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7lVxxx5S21rqY0s8FYfoyy4/+dOZktvoeOO7axENeiBEJtzdcayRHqk0tn8ErC0l
	 DKqxf3gKYyTuHgChHs/7eRh76p55skKpd5c4zacZWC/miAAqzZ1q9eEuoEKuG9OWj6
	 +Eo0/xNWMs8k1V7bVmml0Uyely5ti+eZATZW3I8NMSC6lfCR7nm45U3HK9kmHaWteo
	 Ee/wBaWTCgZakFah5cOqaDAtsyOhRDzYHYeihoPS5+AJJxDUupEpZBAWRYW8iHX/dQ
	 43w0P1BErfLYzCMi/l7Xt0J/MkmbMnQhQkzcGPwjF76obsn2RYlE/IPYEgx+0F510i
	 JO0pJzOYuykmg==
Date: Sun, 7 Dec 2025 19:33:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Jander <david@protonic.nl>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <20251207193313.794ea339@jic23-huawei>
In-Reply-To: <20251118141821.907364-3-o.rempel@pengutronix.de>
References: <20251118141821.907364-1-o.rempel@pengutronix.de>
	<20251118141821.907364-3-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 15:18:21 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> From: David Jander <david@protonic.nl>
> 
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
> 
> Highlights:
> - Supports 2/3/4/6/8-channel variants with per-channel RAW and SCALE.
> - Implements device-required full-duplex fixed-frame transfers.
> - Handles both input and output CRC
> 
> Note: Despite the almost identical name, this hardware is not
> compatible with the ADS131E0x series handled by
> drivers/iio/adc/ti-ads131e08.c.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Hi Oleksij,

Series applied, but one comment inline on some code that surprised
me. I'm curious whether anyone else agrees the devm_clk_get_enabled()
stub returning NULL is an odd choice?

For now applied to my local branch. I will push it out only as testing until
I can rebase on rc1.

> +/**
> + * ads131m_parse_clock - enable clock and detect "xtal" selection
> + * @priv: Device private data structure.
> + * @is_xtal: result flag (true if "xtal", false if default "clkin")
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_parse_clock(struct ads131m_priv *priv, bool *is_xtal)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get_enabled(dev, NULL);

This surprised me, so I went digging.  Anyone know why
the stub returns NULL?  Given that the normal function doesn't have
that as an allowed return value that seems really odd.

Still, it does, so this code is fine if odd.

> +	if (IS_ERR_OR_NULL(clk)) {
> +		if (IS_ERR(clk))
> +			ret = PTR_ERR(clk);
> +		else
> +			ret = -ENODEV;
> +
> +		return dev_err_probe(dev, ret, "clk get enabled failed\n");
> +	}
> +
> +	ret = device_property_match_string(dev, "clock-names", "xtal");
> +	if (ret > 0)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "'xtal' must be the only or first clock name");
> +
> +	if (ret < 0 && ret != -ENODATA)
> +		return dev_err_probe(dev, ret,
> +				     "failed to read 'clock-names' property");
> +
> +	if (ret == 0 && !priv->config->supports_xtal)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "'xtal' clock not supported on this device");
> +
> +	*is_xtal = !ret;
> +
> +	return 0;
> +}

