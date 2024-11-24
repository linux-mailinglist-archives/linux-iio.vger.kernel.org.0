Return-Path: <linux-iio+bounces-12605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B189D7775
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C66B22B14
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25C13BC0C;
	Sun, 24 Nov 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnu+xXad"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1D2F26;
	Sun, 24 Nov 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473968; cv=none; b=snmqkStpLlW1UplO09DyZRs9+icXtTdyyaBz/3m4GkhQmImARQOR7E3/76KEulHgSnHLHCDWJDPvnRM0dgx7pjYYFik+C7HHNFkzlUmYsBC5caYhDk5rzN0R9p/9tdOx/66L7jnT0XQ7PmjXdFHhYrNOE3bTpCwts6lAPCoqm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473968; c=relaxed/simple;
	bh=kubOsjnrGStGaOISdtZRFlOZWfB4tX2WzYQ2hudv3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uO4KBj8OvqR9N1tPk5tScQfMabbdjygIhwCSqm1MSFhjIVjMn1bX5km6HcO1s5mcpvn6Gg/c41VzoqjC8FQlbmoGCoxqksMidBaGJ1neG6HOtm1hKNeVD9zCF7eCtGkQ6xAdYMcPO877JD/813QzIQ4dkzPwvBk7cqAhfC+/3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnu+xXad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7C8C4CECC;
	Sun, 24 Nov 2024 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732473968;
	bh=kubOsjnrGStGaOISdtZRFlOZWfB4tX2WzYQ2hudv3jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qnu+xXad3JJ1Eqk8PjA+e19qD9CPJAHTMyBe/Es7O2dEm90cEHCcxviVCjNVD4jKR
	 taUQMxNqnpLfqwda/sG5FOCcHcd9UV1BQIN9Yyxqo6pwFnA1tw54tt3O/z6ZFjBin/
	 bA2ihPmudbhS9fXnHz8vdkNmyVEOtQG9kBAkfMMbEThLbJjD7GNNtBldrj51d12WDD
	 enCSC+zNE82coivuK3vL9jTnxqaAH0jT9+XHWUwem6s4yzU61y9vXK70dyp3nlivGq
	 EpbOulLOqkQjkVdxltCKR5OhkEnmOGMWirh2KpW7Lp6YnTUADnYk9BOQg9E9R/DGid
	 LMFdG9lDQ8oUA==
Date: Sun, 24 Nov 2024 18:46:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 13/22] iio: accel: adxl345: add trigger handler
Message-ID: <20241124184601.0846104c@jic23-huawei>
In-Reply-To: <20241117182651.115056-14-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-14-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:42 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add basic setup to the interrupt handler function and prepare probe
> for using and not using the FIFO on the adxl345. Interrupt handler and
> basic structure integration is needed to evaluate interrupt source
> register. This is crucial for implementing further features of the
> sensor.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 105 ++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index f98ddef4c5..508de81bb9 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -15,6 +15,9 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
Probably not appropriate to have a trigger here unless you make it work
with other triggers (e.g. Sysfs, hrtimer etc).
When a fifo is involved the usual control is no trigger means fifo, applying
a trigger means not through fifo.

>  
>  #include <linux/input/adxl34x.h>
>  
> @@ -137,6 +140,7 @@ struct adxl34x_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
>  	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
> +	u8 int_map;
Introduce only when used...
>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	u8 intio;
>  };
> @@ -302,6 +306,10 @@ static void adxl345_powerdown(void *ptr)
>  	adxl345_set_measure_en(st, false);
>  }
>  
> +static const struct iio_dev_attr *adxl345_fifo_attributes[] = {
> +	NULL,
Bring this in when it has content, not before.

> +};
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
>  );
> @@ -315,6 +323,75 @@ static const struct attribute_group adxl345_attrs_group = {
>  	.attrs = adxl345_attrs,
>  };
>  
> +static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
> +};
> +
> +static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	*int_stat = 0;

Why not return it?
Negative error, value if positive.

> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> +	if (ret) {
> +		pr_warn("%s(): Failed to read INT_SOURCE register\n", __func__);
dev_err()
Though odd to do that for this specific read and no others.

> +		return -EINVAL;
> +	}
> +
> +	*int_stat = 0xff & regval;
> +	pr_debug("%s(): int_stat 0x%02X (INT_SOURCE)\n", __func__, *int_stat);
Clean these debug statements out to only keep the particularly useful ones.
> +
> +	return 0;
> +}
> +
> +/**
> + * irqreturn_t adxl345_trigger_handler() - Interrupt handler used for several
> + *                                         features of the ADXL345.
If it is used for anything other than triggers, you should rethink that naming.

You are probably better off registering the interrupt directly.  See comments
on not using a trigger below. They aren't always appropriate.

> + * @irq: The interrupt number.
> + * @p: The iio poll function instance, used to derive the device and data.
> + *
> + * Having an interrupt imples FIFO_STREAM mode was enabled. Since this is given
> + * there will no be further test for being in FIFO_BYPASS mode. FIFO_TRIGGER
> + * and FIFO_FIFO mode (being similar to FIFO_STREAM mode) are not separately
> + * implemented so far. Both should be work smoothly with the same way of
> + * interrupt handling.
> + *
> + * Return: Describe if the interrupt was handled.
> + */
> +static irqreturn_t adxl345_trigger_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = ((struct iio_poll_func *) p)->indio_dev;
> +	struct adxl34x_state *st = iio_priv(indio_dev);
> +	u8 int_stat;
> +	int ret;
> +
> +	ret = adxl345_get_status(st, &int_stat);
> +	if (ret < 0)
> +		goto done;
> +
> +	/* Ignore already read event by reissued too fast */
> +	if (int_stat == 0x0)
> +		goto done;
> +
> +	/* evaluation */
Don't see this comment as useful. Probably drop it or expand to make
it more useful.
> +
> +	if (int_stat & ADXL345_INT_OVERRUN) {
> +		pr_debug("%s(): OVERRUN event detected\n", __func__);
dev_dbg()
> +		goto done;
> +	}
> +
> +	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK))
> +		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
Bring this in only when you actually do something in the handler.
Much better to supply a full function in one go so it can be easily reviewed.
> +
> +	goto done;
> +done:
> +
> +	if (indio_dev)
> +		iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info adxl345_info = {
>  	.attrs		= &adxl345_attrs_group,
>  	.read_raw	= adxl345_read_raw,
> @@ -351,6 +428,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
>  	const struct adxl34x_platform_data *data;
> +	u8 fifo_ctl;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -419,9 +497,32 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
>  
> -	/* Enable measurement mode */
> -	adxl345_set_measure_en(st, true);
> +	/* Basic common initialization of the driver is done now */

Code flow comments like this are rarely useful and often become wrong
as a driver evolves. Better to not add it.

> +
> +	if (st->irq) { /* Initialization to prepare for FIFO_STREAM mode */
> +		ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
If you are supporting only fifo mode, why use a triggered buffer?
Those require one interrupt (or trigger) per scan (here read of all the axes).

For a device using only fifo based accesses it is fine to have no trigger.
If you look around you will find various drivers calling 
devm_iio_kfifo_buffer_setup() directly - look at how they do things.
There is an ext version of that as well.


> +							  NULL,
> +							  adxl345_trigger_handler,
> +							  IIO_BUFFER_DIRECTION_IN,
> +							  &adxl345_buffer_ops,
> +							  adxl345_fifo_attributes);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
> +
> +	} else { /* Initialization to prepare for FIFO_BYPASS mode (fallback) */
>  
> +		/* The following defaults to 0x00, anyway */
Not a lot of point in an | with 0x00 
I'm not sure the comment adds any value.

> +		fifo_ctl = 0x00 | ADXL345_FIFO_CTL_MODE(ADXL_FIFO_BYPASS);
> +
> +		dev_dbg(dev, "fifo_ctl 0x%02X [0x00]\n", fifo_ctl);

Not generally worth keeping this level of low level dbg in driver. There is infrastructure
in regmap for tracing if you really need to know.

> +		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Enable measurement mode */
> +		adxl345_set_measure_en(st, true);
Check for errors.

> +	}
> +	dev_dbg(dev, "Driver operational\n");
Drop this from code for upstream. It is wrong anyway as if the next call fails
it is definitely not operational.

>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);


