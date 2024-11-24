Return-Path: <linux-iio+bounces-12615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDE9D77BF
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015A1281351
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9619145A0B;
	Sun, 24 Nov 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoWV4alX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F012F26;
	Sun, 24 Nov 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475495; cv=none; b=g7Sso25WE/GmoP/cLRWmS4UhAj+e+U/q1nFcCrndCFSQYBDLQwagvwTSy2dW+NkJUSDotRovdnFdunNAL07LTgcO3AZ4Q+vGQUIzM8twSNSZ890HuwXw9WWClrFYyd3aG6X6t8BzznWZ1pyl/Nf+EYSwOQQMHSKFSiejxEfRg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475495; c=relaxed/simple;
	bh=F4dT1tZ81W1k6vnw549sjhuRzMek1xYPSMZK3igRCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfEV7bZ9obOW8BnIvijFI6HQmexPGrN0gvzmRCGYwQ/yQxX2pHaekHN2E5Yt63PyTLd1mB0MXLaaoeuoZZDwPY9Dtuh5E1BxcszkczNNAMlPOwe1Di4mC4P/Zy/SSq5LNpJNpFKzLrhxZkuTICG8jnNm6kaovsPJz6yVB4grMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoWV4alX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDCC4CECC;
	Sun, 24 Nov 2024 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732475495;
	bh=F4dT1tZ81W1k6vnw549sjhuRzMek1xYPSMZK3igRCZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CoWV4alXBeXgezmx/FhUy1Va3pOWRKMrBZ0PaRoit8daAoLvAwkPePwXc7ajaysK1
	 heTek1cUd6alkvuDyASDjcn3qLiu1MyeREJ0/OUaflk1dv3rlsa3xs1bboSz2sv3f0
	 gRU4Ye4XyULei5CnCEJZu4cdMm5sX6wmGGbhlUqdfORnIY8DXAxI8/4fCL8LrW3pYw
	 Un5SKX0kD6MMlfjSgsteA5AmHOP5MiPio1O86ZoojyxG8eg1qYujxq7Zf159tmEAVO
	 0/urxVhoZ94bgZXn6StzrSHEzo0yRyrYcUaRqMPLToODnsyjRpFK/u+AkdaK+E+JCr
	 oBLALcTKlshvw==
Date: Sun, 24 Nov 2024 19:11:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 22/22] iio: accel: adxl345: add debug printout
Message-ID: <20241124191127.455c0a8b@jic23-huawei>
In-Reply-To: <20241117182651.115056-23-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-23-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:51 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add debug prints to allow to debug the sensor based on dynamic debug.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
We have infrastructure to read registers stuff in debugfs. Use that not
prints to the kernel log.

For the others stuff only keep stuff that we can get via ftrace
or similar if we really want to know the fine detail of what ran.

Jonathan


> ---
>  drivers/iio/accel/adxl345_core.c | 95 ++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index c79f0f5e3b..8d2166a057 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -26,6 +26,9 @@
>  
>  #include "adxl345.h"
>  
> +/* debugging registers */
> +#define DEBUG_ADXL345 0
> +
>  /* ADXL345 register map */
>  #define ADXL345_REG_DEVID		0x00 /* r    Device ID */
>  #define ADXL345_REG_THRESH_TAP	0x1D /* r/w  Tap Threshold */
> @@ -181,6 +184,78 @@ static const struct iio_chan_spec adxl34x_channels[] = {
>  	ADXL34x_CHANNEL(2, chan_z, Z),
>  };
>  
> +/*
> + * Debugging
> + */
> +
> +__maybe_unused
> +static void adxl345_debug_registers(const char *func, struct adxl34x_state *st)
> +{
> +#if DEBUG_ADXL345 == 1
> +	struct regmap *regmap = st->regmap;
> +	unsigned int regval = 0;
> +
> +	regmap_read(regmap, ADXL345_REG_THRESH_TAP, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_THRESH_TAP\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_DUR, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_DUR\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_LATENT, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_LATENT\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_WINDOW, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_WINDOW\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_ACT_TAP_STATUS\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_POWER_CTL, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_POWER_CTL\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_INT_ENABLE\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_INT_MAP, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_INT_MAP\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_INT_SOURCE, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_INT_SOURCE\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_FIFO_CTL, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_FIFO_CTL\n",
> +			func, 0xff & regval);
> +
> +	regmap_read(regmap, ADXL345_REG_FIFO_STATUS, &regval);
> +	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_FIFO_STATUS\n",
> +			func, 0xff & regval);
> +# endif
> +}
> +
> +__maybe_unused
> +static void adxl345_debug_fifo(const char *func, s16 *fifo_buf, int entries_line)
> +{
> +#if DEBUG_ADXL345 == 1
> +	s16 xval, yval, zval;
> +
> +	xval = fifo_buf[0 + entries_line];
> +	yval = fifo_buf[1 + entries_line];
> +	zval = fifo_buf[2 + entries_line];
> +
> +	pr_debug("%s(): FIFO[%d] - x=%d, y=%d, z=%d\n",
> +		func, entries_line/3, xval, yval, zval);
> +#endif
> +}
> +
>  static int adxl345_set_interrupts(struct adxl34x_state *st)
>  {
>  	int ret;
> @@ -528,6 +603,8 @@ static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries
>  	size_t count, ndirs = 3;
>  	int i, ret;
>  
> +	pr_debug("%s(): fifo_entries = %d\n", __func__, fifo_entries);
> +
>  	count = 2 * ndirs; /* 2 byte per direction */
>  	for (i = 0; i < fifo_entries; i++) {
>  		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
> @@ -537,6 +614,7 @@ static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries
>  			return -EFAULT;
>  		}
>  	}
> +	adxl345_debug_registers(__func__, st);
>  
>  	return 0;
>  }
> @@ -656,6 +734,7 @@ static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
>  		if (st->fifo_delay && (fifo_entries > 1))
>  			udelay(3);
>  
> +		adxl345_debug_fifo(__func__, st->fifo_buf, i);
>  		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
>  	}
>  
> @@ -683,6 +762,7 @@ static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
>  			 __func__, st->int_map);
>  	}
>  
> +	adxl345_debug_registers(__func__, st);
>  	return 0;
>  }
>  
> @@ -713,6 +793,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  	int fifo_entries;
>  	int ret;
>  
> +	pr_debug("%s(): IRQ caught!\n", __func__);
>  	ret = adxl345_get_status(st, &int_stat);
>  	if (ret < 0)
>  		goto err;
> @@ -747,6 +828,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  
>  	goto done;
>  err:
> +	pr_debug("%s(): error termination\n", __func__);
>  	iio_trigger_notify_done(indio_dev->trig);
>  	adxl345_set_measure_en(st, false);
>  	adxl345_empty_fifo(st);
> @@ -754,6 +836,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  	return IRQ_NONE;
>  
>  done:
> +	pr_debug("%s(): regular termination\n", __func__);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -804,6 +887,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	st = iio_priv(indio_dev);
>  	st->regmap = regmap;
>  
> +	dev_dbg(dev, "irq '%d'\n", irq);
> +	if (!irq) /* fall back to bypass mode w/o IRQ */
> +		dev_dbg(dev, "no IRQ, FIFO mode will stay in BYPASS_MODE\n");
>  	st->irq = irq;
>  	st->info = device_get_match_data(dev);
>  	if (!st->info)
> @@ -831,7 +917,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->channels = adxl34x_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
>  
> +	dev_dbg(dev, "setting up indio_dev ok\n");
> +
>  	if (setup) {
> +		dev_dbg(dev, "setup() was provided\n");
> +
>  		/* Perform optional initial bus specific configuration */
>  		ret = setup(dev, st->regmap);
>  		if (ret)
> @@ -846,6 +936,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					     "Failed to set data range\n");
>  
>  	} else {
> +		dev_dbg(dev, "No setup() provided\n");
> +
>  		/* Enable full-resolution mode (init all data_format bits) */
>  		ret = regmap_write(st->regmap, ADXL345_REG_DATA_FORMAT,
>  				   ADXL345_DATA_FORMAT_FULL_RES);
> @@ -854,6 +946,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					     "Failed to set data range\n");
>  	}
>  
> +	dev_dbg(dev, "Retrieving DEVID\n");
>  	ret = regmap_read(st->regmap, ADXL345_REG_DEVID, &regval);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Error reading device ID\n");
> @@ -861,7 +954,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	if (regval != ADXL345_DEVID)
>  		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
>  				     regval, ADXL345_DEVID);
> +	dev_dbg(dev, "Retrieving DEVID ok\n");
>  
> +	dev_dbg(dev, "Registering power down function\n");
>  	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add action or reset\n");


