Return-Path: <linux-iio+bounces-26837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A501CAAB53
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 18:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B39300FE0E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B628725C;
	Sat,  6 Dec 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwzZphN5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD327990A;
	Sat,  6 Dec 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765043115; cv=none; b=swIdG9khkrdfOx5LRgH8ZZhMBBo7Eb6kt3yDkRU9Xp5b4ic6F0aaZ7yAIc085i6fBx/m+LVKCRzQrAo5+mN+RAEKZLGNoyuJUFufdBMYvqveHWYdPvWfOs3rRnt+cykoceToJjY3W/F0qIzlpvG3EONlCz+bM097eRTGaZojdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765043115; c=relaxed/simple;
	bh=qwLr7pgjlOgWN0z/yK2r8RonIWg4eelYK+AKn1yiOfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxxTMF/bhWtsQ+GOeDFCSFXnm+8fjq6fQ9S+jFQ7iBzQwCMuc0uoLNJHGm+0WlYWhx7+v41cvqME1NwwvK5QwrtaJmgdog8TIEd8Vo1yXeASKkmtAxjvkzRbJZ3jur8E/EgveSMNTvkY54SgQ8DvGu8AluFIXUY5G11msmSDZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwzZphN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1728EC4CEF5;
	Sat,  6 Dec 2025 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765043114;
	bh=qwLr7pgjlOgWN0z/yK2r8RonIWg4eelYK+AKn1yiOfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwzZphN5eVl9sixtE8FTmLkfy02tLgRRKueNVaMslwM5nLMuDaUWi3X9RgMQiO7WN
	 gwXFkCHz56SEt2txQb54h27cgeI007mX60O+UIEFvLRVqCTYD872JuqNoa/eDLZGlH
	 gS0klKp3FxZN3xlwjxArO4//1buSSM5GciBuDK2MO57mQXDz5gV0E0P/F0/EyRL74p
	 vv9Oiprj9wK17dzDTNBuavRaD2f1az1jQn1hLHSxQH1l8qkr/ikzAdwklmE4uplxZN
	 vxegfjeWuxgxPLslGkp95DSudK4B59w4DbHxdAnzIzV8t7ibtdv6uXR9HCCWVBj4SE
	 3KYggHrr14jKg==
Date: Sat, 6 Dec 2025 17:45:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 5/9] iio: adc: ad4062: Add IIO Trigger support
Message-ID: <20251206174503.3c008cea@jic23-huawei>
In-Reply-To: <20251205-staging-ad4062-v3-5-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
	<20251205-staging-ad4062-v3-5-8761355f9c66@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 16:12:06 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
> signal, if not present, fallback to an I3C IBI with the same role.
> The software trigger is allocated by the device, but must be attached by
> the user before enabling the buffer. The purpose is to not impede
> removing the driver due to the increased reference count when
> iio_trigger_set_immutable() or iio_trigger_get() is used.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

+CC Rafael; I'd like input on the ACQUIRE + take extra reference pattern
and whether Rafael thinks it is a good idea!

> ---
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad4062.c | 188 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 175 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e506dbe83f488..ddb7820f0bdcc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -74,6 +74,8 @@ config AD4062
>  	tristate "Analog Devices AD4062 Driver"
>  	depends on I3C
>  	select REGMAP_I3C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD4062 I3C analog
>  	  to digital converters (ADC).
> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> index 54f7f69e40879..080dc80fd1621 100644
> --- a/drivers/iio/adc/ad4062.c
> +++ b/drivers/iio/adc/ad4062.c

> +static void ad4062_trigger_work(struct work_struct *work)
> +{
> +	struct ad4062_state *st =
> +		container_of(work, struct ad4062_state, trig_conv);
> +	int ret;
> +
> +	/*
> +	 * Read current conversion, if at reg CONV_READ, stop bit triggers
> +	 * next sample and does not need writing the address.
> +	 */
> +	struct i3c_priv_xfer t[2] = {
> +		{
> +			.data.in = &st->buf.be32,
> +			.len = sizeof(st->buf.be32),
> +			.rnw = true,
> +		},
> +		{
> +			.data.out = &st->reg_addr_conv,
> +			.len = sizeof(st->reg_addr_conv),
> +			.rnw = false,
> +		},
> +	};
> +
> +	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[0], 1);
> +	if (ret)
> +		return;
> +
> +	iio_push_to_buffers_with_timestamp(st->indio_dev, &st->buf.be32,
> +					   iio_get_time_ns(st->indio_dev));

Use push_to_buffers_with_ts() (this function is deprecated)
which would have had the helpful result here of pointing out the buffer
isn't big enough for the timestamp.  So this will write the timestamp
over later fields in the st structure.

Given that this sometimes fits in a be16 I wonder if it is worth
storing those in a be16 element of the kfifo. That will halve it's size
if the timestamp isn't enabled which would be a nice thing to have.
Storing in a be32 isn't an ABI issue, it's just a bit unusual
so if I'm missing some reason it makes more sense then fair enough.

> +	if (st->gpo_irq[1])
> +		return;
> +
> +	i3c_device_do_priv_xfers(st->i3cdev, &t[1], 1);
> +}

...

> @@ -572,15 +665,17 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
>  {
>  	int ret;
>  	struct i3c_device *i3cdev = st->i3cdev;
> -	struct i3c_priv_xfer t0 = {
> -		.data.out = &st->reg_addr_conv,
> -		.len = sizeof(st->reg_addr_conv),
> -		.rnw = false,
> -	};
> -	struct i3c_priv_xfer t1 = {
> -		.data.in = &st->buf.be32,
> -		.len = sizeof(st->buf.be32),
> -		.rnw = true,
> +	struct i3c_priv_xfer t[] = {

Do this in the earlier patch, not here.

> +		{
> +			.data.out = &st->reg_addr_conv,
> +			.len = sizeof(st->reg_addr_conv),
> +			.rnw = false,
> +		},
> +		{
> +			.data.in = &st->buf.be32,
> +			.len = sizeof(st->buf.be32),
> +			.rnw = true,
> +		}
>  	};

> @@ -687,6 +782,55 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> +	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);

This may also be affected by Rafael's patch set to provide some helpers
to make this more readable.


> +	if (ret)
> +		return ret;
> +
> +	ret = ad4062_set_operation_mode(st, st->mode);
> +	if (ret)
> +		return ret;
> +
> +	/* CONV_READ requires read to trigger first sample. */
> +	struct i3c_priv_xfer t[2] = {
> +		{
> +			.data.out = &st->reg_addr_conv,
> +			.len = sizeof(st->reg_addr_conv),
> +			.rnw = false,
> +		},
> +		{
> +			.data.in = &st->buf.be32,
> +			.len = sizeof(st->buf.be32),
> +			.rnw = true,
> +		}
> +	};
> +
> +	ret = i3c_device_do_priv_xfers(st->i3cdev, t, st->gpo_irq[1] ? 2 : 1);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(&st->i3cdev->dev);
As per my late reply I'm not keen on the double increment as a complex way
to steal the ACQUIRED() reference. Might be better to just factor the stuff
where you currently have acquired a reference out into a helper and use
the traditional runtime pm calls in this outer function.
 
> +	return 0;



