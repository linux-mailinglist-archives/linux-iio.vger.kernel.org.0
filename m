Return-Path: <linux-iio+bounces-27074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47743CBBBB5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 568333009114
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA651B81CA;
	Sun, 14 Dec 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWJ6S4Zj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D741C72;
	Sun, 14 Dec 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765723729; cv=none; b=MngE9SYaPzNbZCoNAuXgbPNNW1umNpSQaH8THVD7TUcj2EwyZlS46N3SDxD56qnahXK5K8heKyMMw335kUmtSSKVuZO60Icht+8GiyVYP3gZjHx1SZTv6CMj/QkYp1OG6lJrbEG4kMtpaDyolwczAuQC/1d+0OD1uRLtTRBxPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765723729; c=relaxed/simple;
	bh=xFKsuig1p11Hi+asDXDjOoc+F13m61ehJo9EJKbLRdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mO2DkZoV1hTRNuSRWajoxzCZQazeAB9+FeMyTxQ+MhWjeGYellleCELFmEmqpRv9JsuBCezLRQCFcyt5VVgLA8soeFFsPLrJ87mMZsUw5Weo37zdu5//49mH71OpVH7knuP8NsNkZgGt6TWKFzfGzlS9uvo2iBE8IWVGuwoGpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWJ6S4Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BA9C4CEF1;
	Sun, 14 Dec 2025 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765723728;
	bh=xFKsuig1p11Hi+asDXDjOoc+F13m61ehJo9EJKbLRdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mWJ6S4Zj4qLB2OhRRnhDdeDuKX/feWfImtu8M3zJB0CZovH8UoWfAQHJmkqwQ7hOK
	 tJLDkN+GIuUYDjNUwr940Kblo7Ji97mNNiK4gI6xC0jA53X380U1ZJ1By1PoDrUUKl
	 aXM3z1V4iDH+4TGDgeB5sV4t0uTd2D3LpUtl9G8trye6jE0drDqbZoEFliWcgl9lsw
	 fDjlWDjyz4y2gJiUXCBcy9/dqUL83HXPBRNqJ8g8P2JF2ar3NVqth/5Sg6UVEqAjkC
	 PLa4m/MU0EPVyYDO+Zmy5LogQ+XkdSFz40a+lO5FA/9DV41hXutosHLkT6pPIY6kr/
	 6wWoBNBsTTu0Q==
Date: Sun, 14 Dec 2025 14:48:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tobias Sperling
 <tobias.sperling@softing.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <20251214144839.2eec58f9@jic23-huawei>
In-Reply-To: <20251211-ads1x18-v8-2-5cd12ac556da@gmail.com>
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
	<20251211-ads1x18-v8-2-5cd12ac556da@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2025 23:25:44 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> analog-to-digital converters.
> 
> This chips' MOSI pin is shared with a data-ready interrupt. Defining
> this interrupt in devicetree is optional, therefore we only create an
> IIO trigger if one is found.
> 
> Handling this interrupt requires some considerations. When enabling the
> trigger the CS line is tied low (active), thus we need to hold
> spi_bus_lock() too, to avoid state corruption. This is done inside the
> set_trigger_state() callback, to let users use other triggers without
> wasting a bus lock.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Hi Kurt, 

A couple of minor formatting things. All trivial so I tweaked whilst
applying. Applied to the testing branch of iio.git. I'll rebase that
on rc1 once available then push out as togreg for linux-next to pick
it up.

Thanks,

Jonathan



> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> new file mode 100644
> index 000000000000..e3087bb47699
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1018.c

> +
> +static int
> +ads1018_write_raw_get_fmt(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, long mask)
I'm not immediately seeing why this particular line wrap mapes sense.
static int ads1018_write_raw_get_fmt(struct iio_dev *indio_dev,
			  	     struct iio_chan_spec const *chan,
				     long mask)

Is more common way to do this particular combination.

There are a few other places where the wrap choice wasn't quite what
I'd have gone with, so I tweaked those as well.


> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> +static const struct iio_info ads1018_iio_info = {
> +	.read_raw = ads1018_read_raw,
> +	.read_avail = ads1018_read_avail,
> +	.write_raw = ads1018_write_raw,
> +	.write_raw_get_fmt = ads1018_write_raw_get_fmt,
> +};


> +static int ads1018_spi_probe(struct spi_device *spi)
> +{
> +	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads1018 *ads1018;
> +	int ret;

...

> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ads1018_trigger_handler,
> +					      &ads1018_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);

You have dev, so makes sense to use it here too.

> +}


