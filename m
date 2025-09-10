Return-Path: <linux-iio+bounces-23958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45380B52005
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED047A1AC6
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EC327A07;
	Wed, 10 Sep 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnlZKG8X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842B329F18;
	Wed, 10 Sep 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527955; cv=none; b=L1OYkDL4bnzq0+/ayzkL8Kdw/O6Mrb+xg+ZcNtJTFNpj6Q7ykd2VnXwQ7XcW2iEfCjYKj7gkPDJkFKay7m5XfdhZpF+rg8D8nESb70Mf06dYnBc96QGG5oHvG6utmI/BAhDaKUZTDggdzNfwP7j9OFSj4OISGE/Tj2+ZG0uXbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527955; c=relaxed/simple;
	bh=BBFG9kR7ACE7CDWmj2ZIFianAmeoqDx+/gxbP0zb3zE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b33bw8gX6Hje9vqXAvEVyPKaYdSnkOdHqNLdMI2G5PO/GUdLNmeKCl7WiDrtdsCMdIarksdn+mhN3xsADDjHrI4c382vipgmucM5XmoA2Mi5SHD7YAKbmqRCwX1iN7anxp/LJeKP1lnmv8vurOwjJPpdIE2126w8aS/67I955G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnlZKG8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4BCC4CEEB;
	Wed, 10 Sep 2025 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527955;
	bh=BBFG9kR7ACE7CDWmj2ZIFianAmeoqDx+/gxbP0zb3zE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YnlZKG8XZSOWppkOv+vDsgNw81Wfix945wv5Mbd/IcIADxKIt0yH6NiZtOgrYoRV7
	 iGS2StajNBxb44u+oie8PiL2nR9krLazUJDZCRkQV/AEBDgY6+0LuXdlTkiljgpXxs
	 +fu3UfhXZ4c9fpHmrCTp+ptIU35rAWWnEnE+HCz4LiDTa2BbVcvtjnL0YSKJWiLx2W
	 uH6I3yG0ZKuoIpWlxS6ILuSl5qlArrM8Bmh5CoptHYQ1z5fuEjyPdIiWqiJB9+yRPT
	 RrTgznWtU5hGOXA9wSf4tGf8k/0iisbD2/cE3V9/yaiU9SLy4DOILhfPWxcJ0y5u2T
	 CCgwoR4FUDhcA==
Date: Wed, 10 Sep 2025 19:12:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] iio: accel: bma220: migrate to regmap API
Message-ID: <20250910191225.43a89a1f@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-8-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-8-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:13 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Switch to regmap API.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Hi Petre

There are a few things in here that seem unrelated to the regmap change
and should be in separate patches where we can review and discuss them more easily.

Thanks,

Jonathan

> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 322df516c90a7c645eeca579cae9803eb31caad1..4d8b65ea737a2d5fe74f98da13a582a80874a5af 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c

> +#define BMA220_INT_LATCH_MSK			GENMASK(6, 4)
> +#define BMA220_INT_LATCH_MAX			0x7

Not particular important here but if this is used in later patches how I'd expect
you can use FIELD_FIT() to achieve the same without an extra define.


>>  static irqreturn_t bma220_trigger_handler(int irq, void *p)
>  {
>  	int ret;
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bma220_data *data = iio_priv(indio_dev);
> -	struct spi_device *spi = data->spi_device;
>  
> -	mutex_lock(&data->lock);
> -	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
> -	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
> -				  ARRAY_SIZE(bma220_channels) - 1);
> +	ret = regmap_bulk_read(data->regmap, BMA220_REG_ACCEL_X,
> +			       &data->scan.chans,
> +			       sizeof(data->scan.chans));
>  	if (ret < 0)
> -		goto err;
> +		return IRQ_NONE;
>  
>  	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> -				    pf->timestamp);

Why the move to grabbing timestamps in the thread rather than the top half?

I don't necessarily mind that change but doesn't feel appropriate to have
it in the same patch as the regmap change.

> -err:
> -	mutex_unlock(&data->lock);
> +				    iio_get_time_ns(indio_dev));
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;


>  static int bma220_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long mask)
>  {
> -	int i;
>  	int ret;
>  	int index = -1;
>  	struct bma220_data *data = iio_priv(indio_dev);
>  
> +	guard(mutex)(&data->lock);
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
> -			if (val == bma220_scale_table[i][0] &&
> -			    val2 == bma220_scale_table[i][1]) {
> -				index = i;
> -				break;
> -			}
> +		index = bma220_find_match_2dt(bma220_scale_table,
> +					      ARRAY_SIZE(bma220_scale_table),
> +					      val, val2);

This feels like an unrelated change that belongs in a different patch.

>  		if (index < 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		data->tx_buf[0] = BMA220_REG_RANGE;
> -		data->tx_buf[1] = index;
> -		ret = spi_write(data->spi_device, data->tx_buf,
> -				sizeof(data->tx_buf));
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_RANGE,
> +					 BMA220_RANGE_MASK,
> +					 FIELD_PREP(BMA220_RANGE_MASK, index));
>  		if (ret < 0)
>  			return ret;
> -		mutex_unlock(&data->lock);
> +		data->range_idx = index;
>  
>  		return 0;
>  	}
> @@ -206,9 +288,12 @@ static const struct iio_info bma220_info = {
>  
> -static int bma220_init(struct spi_device *spi)
> +

one blank line enough and will tidy up the diff a little.

> +static int bma220_init(struct bma220_data *data)
...

> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					      iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      bma220_trigger_handler, NULL);

As above, I wasn't expecting the switch from iio_pollfunc_store_time in this
patch.

>  	if (ret < 0) {
> -		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +		dev_err(dev, "iio triggered buffer setup failed\n");
>  		return ret;

Can use dev_err_probe() to shorten this a little.

>  	}
>  
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
> -EXPORT_SYMBOL_NS(bma220_common_probe, "IIO_BOSCH_BMA220");
> +EXPORT_SYMBOL_NS_GPL(bma220_common_probe, "IIO_BOSCH_BMA220");

