Return-Path: <linux-iio+bounces-10523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C699B60A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56B41F21ED5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D6542AA5;
	Sat, 12 Oct 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxHFxlkg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D52E401;
	Sat, 12 Oct 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749312; cv=none; b=goHih8SQg/afLnBUaVhn1ihwhkHGn+tu7kvNhSBPaX90aTgsed1KRiPbA6BNX+E9a/vJAOEVgSRSFKgJw12KEZcPXifQsnm0TkePyhcxdzor8VPgUynJ3grwkzXkLzT45Xe+wNkEDYIP2xJCErzc+DAOFsDhv7S3SsiKeptdeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749312; c=relaxed/simple;
	bh=KyM2WeJo+Oc9zR3gSGuNiRtdbPq4sGgsdLpizlOopAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkJ1y/hxkFgovjvLz+oISJHXn0zgc9NtRwH0ZIQllwUgOiWjtdP4HYCMrqEDnbf0drf8BaoVBvSZnUAGVKPQ4kGXjwdOLxlgQV/aknNaUiqhilFjJOkVKXtaL7stO17177e4Tcpjxm5O9JkkJWXZ+/x6uD8uJBhZrriW2WA2YFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxHFxlkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B855C4CEC6;
	Sat, 12 Oct 2024 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728749312;
	bh=KyM2WeJo+Oc9zR3gSGuNiRtdbPq4sGgsdLpizlOopAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxHFxlkg+cR4xCAlNL74cm57dxaGzW8ltbmA1UHbumPihQWCMRxYrxH17phTtlrxx
	 JUejNT5GT5i9L7M5AevTb+UekMn9TXhIYnbFq6h+vEjBFNAdsvRkBU/1q1ijgK16FW
	 xumrLOIWd0xyulTAYsoErDmTv8P/uarmVxiQZqmfYdbLgqdxuXJ7CB/fAq14I1gv+/
	 p33pzzFaymeGtc/EtUazHXUicyl0kspmBOHu6qx2BRKmo/lOfTPrWG+LnLGsIWJrOh
	 CX+r5h2L8gKl8hCH3wBc7Y4eiphdlbWtfBFYKCAkJ6BiovAs1eClW2zkdgaQuwSgKg
	 1BesdtJJ6Pj/w==
Date: Sat, 12 Oct 2024 17:08:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 3/4] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20241012170823.3c6d3df9@jic23-huawei>
In-Reply-To: <20241007194945.66192-4-vassilisamir@gmail.com>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
	<20241007194945.66192-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 21:49:44 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> a trigger for when there are data ready in the sensor for pick up.
> 
> This use case is used along with NORMAL_MODE in the sensor, which allows
> the sensor to do consecutive measurements depending on the ODR rate value.
> 
> The trigger pin can be configured to be open-drain or push-pull and either
> rising or falling edge.
> 
> No support is added yet for interrupts for FIFO, WATERMARK and out of range
> values.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Hi Vasileios,

One questing about locking below.  What you have is probably correct
but might be tighter than it needs to be, or need a comment to say why
for future readers.

I hate register reads with side effects btw.  It's an 'optimization'
hardware designers thing is nice, but makes for really ugly software
interfaces.

> @@ -2429,6 +2564,88 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  	return 0;
>  }
>  
> +static void bmp580_trigger_reenable(struct iio_trigger *trig)
> +{
> +	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
> +	unsigned int tmp;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &tmp);
As below. Seems this read has side effects (horrible!)
I'm not sure if this is related to the locking though.
> +	if (ret)
> +		dev_err(data->dev, "Failed to reset interrupt.\n");
> +}

> +static int bmp580_int_pin_config(struct bmp280_data *data)
> +{
> +	int pin_drive_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
> +				       data->trig_open_drain);
> +	int pin_level_cfg = FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
> +				       data->trig_active_high);
> +	int ret, int_pin_cfg = pin_drive_cfg | pin_level_cfg;
	int int_pin_cfg = pin...
	int ret;

Is easier to follow.

> +
> +	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
> +				 BMP580_INT_CONFIG_MASK, int_pin_cfg);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set interrupt settings.\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_set_bits(data->regmap, BMP580_REG_INT_SOURCE,
> +			      BMP580_INT_SOURCE_DRDY);
> +	if (ret)
> +		dev_err(data->dev, "Could not set interrupt source.\n");
> +
> +	return ret;
> +}
> +
> +static irqreturn_t bmp580_irq_thread_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	unsigned int int_ctrl;
> +	int ret;
> +
> +	scoped_guard(mutex, &data->lock) {
> +		ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
What are you locking against here?  Seems this read may have side effects?
If not the regmap internal locking should be enough for a register read.
> +		if (ret)
> +			return IRQ_NONE;
> +	}



