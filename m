Return-Path: <linux-iio+bounces-19878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17258AC34A6
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EAA3B3EC6
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E61F30A9;
	Sun, 25 May 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfeTPwpf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7FB282F1;
	Sun, 25 May 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748177321; cv=none; b=OpK6ufnNFAsC8Zmlr8FNUpTxIzAWCk7A7toySYv81khYNjj+f/W/joNawNhjpK234Yq7Klmmh2h5ztbXqSmj4v82NzcaPRERRulBPccFZ3oNk/icnBgwTCFq+ZeSztIVLRIheYMtuDbrjQrDVBv3L9JWbzPzWPKTwuX7XZTxK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748177321; c=relaxed/simple;
	bh=u9/4XIHZBrCOuCXoikwRXSkA3my/nbnLHX1nE95Jvpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuJDus/ya0C7XyQy6ZNHgCZJcAhBCEHW+k93tOXtMn6MhSnW/+qB0MAR2kgIZXhDLvT9tGx7Crx14RLdnfP9a3xJgMWBJ4C7tJ11s+NCKh9d2B8Cl5gDNOpYy83+ZwRJeSOlq0xg09BLh2LoN3NQ6Tx9cE9ajbYum4G+0naQtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfeTPwpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C219C4CEEA;
	Sun, 25 May 2025 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748177320;
	bh=u9/4XIHZBrCOuCXoikwRXSkA3my/nbnLHX1nE95Jvpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OfeTPwpfQ87/YWshKJRQudj2SxzWKUiGnkxUxPLdIaYE3VanwD0UaWgCZeVO8KA6g
	 cHcHfYC+YKWpHMRgom85nHNSM2qM6OEGgf7ylm8m7rmRoeUlG5TNJHwJl7Kq92QiXg
	 zTgHlanlaOxIwW0laTMV7t+ErVgS+ggJm0QHRNiDR1k0QrAqRlZrgYOgR+xei/3+6B
	 9Nd9cPnPkdqiN0uAg28iOoo1bMkZibZt1tIuQ8mRiMB6u+ynN7PdqBAPZgg+0IFEHX
	 t9THGnGfbzOVcwIC7VAcxFYxnTu09QB7dkirsfP/AJZ/vLr4dVh/Vw0URSvfIokQE7
	 2nAP3Dk2Uh8bw==
Date: Sun, 25 May 2025 13:48:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] iio: accel: adxl313: add basic interrupt
 handling
Message-ID: <20250525134831.68b3c905@jic23-huawei>
In-Reply-To: <20250523223523.35218-8-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:18 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Prepare the interrupt handler. Add register entries to evaluate the
> incoming interrupt. Add functions to clear status registers and reset the
> FIFO.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

A few comments inline.

> ---
>  drivers/iio/accel/adxl313.h      |  16 ++++
>  drivers/iio/accel/adxl313_core.c | 134 +++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)



>  struct adxl313_chip_info {
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 9db318a03eea..1e085f0c61a0 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -10,15 +10,24 @@
>  #include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>

This is an odd selection of headers to add now. Why do we need them but didn't
before?  Some of these aren't used yet so drop them (events.h, sysfs.h I think)

> +

>  static const struct regmap_range adxl312_readable_reg_range[] = {
>  	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
>  	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> @@ -62,6 +71,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
>  	case ADXL313_REG_DATA_AXIS(4):
>  	case ADXL313_REG_DATA_AXIS(5):
>  	case ADXL313_REG_FIFO_STATUS:
> +	case ADXL313_REG_INT_SOURCE:
>  		return true;
>  	default:
>  		return false;
> @@ -363,6 +373,118 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int adxl313_get_samples(struct adxl313_data *data)

I doubt this gets called from multiple places. I'd just put
the code inline and no have this helper at all.

> +{
> +	unsigned int regval = 0;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_FIFO_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> +}
> +
> +static int adxl313_set_fifo(struct adxl313_data *data)
> +{
> +	unsigned int int_line;
> +	int ret;
> +
> +	ret = adxl313_set_measure_en(data, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_INT_MAP, &int_line);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
> +			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, data->fifo_mode));

Check ret.

> +
> +	return adxl313_set_measure_en(data, true);
> +}
> +
> +static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
> +{
> +	size_t count;
> +	unsigned int i;
> +	int ret;
> +
> +	count = array_size(sizeof(data->fifo_buf[0]), ADXL313_NUM_AXIS);
> +	for (i = 0; i < samples; i++) {
> +		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
> +				       data->fifo_buf + (i * count / 2), count);

that 2 is I'd guessed based on size of some data store element?  
I'd guess sizeof(data->fifo_buf[0]) is appropriate.


> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * adxl313_fifo_reset() - Reset the FIFO and interrupt status registers.
> + * @data: The device data.
> + *
> + * Reset the FIFO status registers. Reading out status registers clears the

I think you already read it before calling this. So how is it ever set?

> + * FIFO and interrupt configuration. Thus do not evaluate regmap return values.
> + * Ignore particular read register content. Register content is not processed
> + * any further. Therefore the function returns void.
> + */
> +static void adxl313_fifo_reset(struct adxl313_data *data)

As below.  This isn't a reset.  Fifo reset is normally the term used
for when we have lost tracking of what is in the fifo and drop all data,
not normal readback.

> +{
> +	unsigned int regval;
> +	int samples;
> +
> +	adxl313_set_measure_en(data, false);
Disabling measurement to read a fifo is unusual -  is this really necessary
as it presumably puts a gap in the data, which is what we are trying
to avoid by using a fifo.

> +
> +	samples = adxl313_get_samples(data);
> +	if (samples > 0)
> +		adxl313_fifo_transfer(data, samples);
> +
> +	regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &regval);

Not processing the convents of INT_SOURCE every time you read it
introduces race conditions.  This logic needs a rethink so that
never happens.  I guess this is why you are disabling measurement
to stop the status changing?  Just whatever each read of INT_SOURCE
tells us we need to handle and all should be fine without disabling
measurement.  That read should only clear bits that are set, so no
race conditions.

> +
> +	adxl313_set_measure_en(data, true);
> +}
> +
> +static int adxl313_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +
> +	data->fifo_mode = ADXL313_FIFO_STREAM;

If you always set fifo_mode before calling _set_fifo() probably better
to pass the value in as a separate parameter and store it as necessary
inside that function.

> +	return adxl313_set_fifo(data);
> +}
> +
> +static int adxl313_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	data->fifo_mode = ADXL313_FIFO_BYPASS;
> +	ret = adxl313_set_fifo(data);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->regmap, ADXL313_REG_INT_ENABLE, 0);
> +}
> +
> +static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
> +	.postenable = adxl313_buffer_postenable,
> +	.predisable = adxl313_buffer_predisable,
> +};
> +
> +static irqreturn_t adxl313_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int int_stat;
> +
> +	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))

Failure to read is one thing we should handle, but also we should handle
int_stat telling us there were no interrupts set for this device.

> +		return IRQ_NONE;
> +
> +	adxl313_fifo_reset(data);

Given we don't know it had anything to do with the fifo at this point
resetting the fifo doesn't make much sense.  I'd expect a check
on int_status, probably for overrun, before doing this.

Ah. On closer inspection this isn't resetting the fifo, it's just
reading it.  Rename that function and make it dependent on what
was in int_stat.


> +
> +	return IRQ_HANDLED;
> +}


