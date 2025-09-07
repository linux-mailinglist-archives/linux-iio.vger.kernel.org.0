Return-Path: <linux-iio+bounces-23858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BAB47B67
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663233B65BC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8EF315D2B;
	Sun,  7 Sep 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H64Ov2A3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22653A926;
	Sun,  7 Sep 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249114; cv=none; b=D2GCkVPf8u2IdVbwk55pQ1yW8RzVnvrm4XUamlgUE0hqLkJtoZq64mMOUw44f7i++twymTdW6ZZtuWxgZQSUqFs3wFLNLO5OOraUVHadsY9H4NWmzUh/kVkvBU/yPY+pbMo6TGVA4+hQl/H8yHOkr26h+WhR5IdV6MwW4ye/BKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249114; c=relaxed/simple;
	bh=F8uNtGNfOi/fhZtdHKn/ryhrWpq/lRAT/NMO3s8pGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBI3vQU+Oty3gqO9miQbpW1dvNgoxO77/MbV+mYCT34SkytJyj79YOwtQVxpCYTtCQGnadDg4H5D2OgcfTfAPqIFSTRN8c7UrxdJbCcA+fhtNrhbx762ru2pMYTpaQN5ENk6eVybGAIk0I7oZb5UTt27wPlW0Oh0gRPl6Y8lLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H64Ov2A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7272FC4CEF0;
	Sun,  7 Sep 2025 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757249113;
	bh=F8uNtGNfOi/fhZtdHKn/ryhrWpq/lRAT/NMO3s8pGBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H64Ov2A3idHbxstsiDVDzm2VViOidutUhtdhZfBiq5h1QcdbgEoC3RN9owcPs5+8P
	 pGzr1l3IjnWGgw0M3XQStGeeR2QsFtIwZ3k0ve7M401X+X8WT33fBXrlfq09bkRAve
	 poz6T+Rxvkbobd+OLnnjkzNkUR4gGKLhJZmQo6nRDD2ohRcE3bTkapszNbp7f+WVHk
	 8wULMpYVNtOAQ1ZpocRj+AvJdftJpESUaA0TY7mF9NbyG5e6Rxt0n42tVKBBpzmuRf
	 zNRRqHpadK5SLMyk75PRqeXJjRabdYpvlP9+1q+ry4K9aF44D6l3HLgh8Mo2tiLMOB
	 aCv1HrDMM5oEg==
Date: Sun, 7 Sep 2025 13:45:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 03/10] iio: accel: BMA220 migrate to regmap API
Message-ID: <20250907134506.580de654@jic23-huawei>
In-Reply-To: <20250901194742.11599-4-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-4-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 22:47:29 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Switch to regmap API.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre,

Various comments inline.  Biggest one is that the addition of the stuff
for irqs doesn't belong in the patch adding regmap.


> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 60fd35637d2d..e6dac2e1cf4d 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -3,31 +3,133 @@
>   * BMA220 Digital triaxial acceleration sensor driver
>   *
>   * Copyright (c) 2016,2020 Intel Corporation.
> + * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
>   */
> 
>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

This feels like an unrelated change.
Good to fix up the headers but for this patch I'd just
expect to see regmap related ones.  Do a precursor patch
just before this one to add the others.

>  #include <linux/types.h>
> -#include <linux/spi/spi.h>

Can't you drop that in previous patch?

> 
> -#include <linux/iio/buffer.h>

Why move this?  We tend to keep these in alphabetical order.

>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>

This is related to the irq stuff that shouldn't be in this patch. 

>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> 
> +#include "bma220.h"
> +
> +/*
> + * Read-Only Registers
Here as well. Not seeing this as beneficial over the the look
up in the regmap callback that already tells use which are in what
state.

> + */
> +
> +/* ID registers */
>  #define BMA220_REG_ID				0x00
> +#define BMA220_REG_REVISION_ID			0x01
> +
> +/* Acceleration registers */
>  #define BMA220_REG_ACCEL_X			0x02
>  #define BMA220_REG_ACCEL_Y			0x03
>  #define BMA220_REG_ACCEL_Z			0x04
> +
> +/*
> + * Read-write configuration registers
I'm not sure we need the read-write part of these comments.
That should be obvious once the regmap config is in place.

> + */

> +static bool bma220_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* Don't cache any registers. */

I assume this changes in later patches as setting cache_type is a bit pointless
otherwise!

> +	return true;
> +}
> +
> +const struct regmap_config bma220_spi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +	.max_register = BMA220_REG_SOFTRESET,
> +	.cache_type = REGCACHE_MAPLE,
> +	.writeable_reg = bma220_is_writable_reg,
> +	.volatile_reg = bma220_is_volatile_reg,
> +};
> +EXPORT_SYMBOL_NS(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");

Any reason not to go NS_GPL?  I'd prefer that ideally.

> @@ -199,69 +356,150 @@ static const struct iio_info bma220_info = {
>  	.read_avail		= bma220_read_avail,
>  };
> 
> -static int bma220_init(struct spi_device *spi)
> +static int bma220_reset(struct bma220_data *data, bool up)
>  {
> -	int ret;
> +	int i, ret;
> +	unsigned int val;
> 
> -	ret = bma220_read_reg(spi, BMA220_REG_ID);
> -	if (ret != BMA220_CHIP_ID)
> -		return -ENODEV;
> +	guard(mutex)(&data->lock);
> 
> -	/* Make sure the chip is powered on */
> -	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
> -	if (ret == BMA220_SUSPEND_WAKE)
> -		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
> -	if (ret < 0)
> -		return ret;
> -	if (ret == BMA220_SUSPEND_WAKE)
> -		return -EBUSY;
> +	/**
> +	 * The chip can be reset by a simple register read.
> +	 * We need up to 2 register reads of the softreset register

May need?  Given you return early if the first one succeeds. If you actually
need two drop the loop and only check values on second read.

> +	 * to make sure that the device is in the desired state.
> +	 */
> +	for (i = 0; i < 2; i++) {
> +		ret = regmap_read(data->regmap, BMA220_REG_SOFTRESET, &val);
> +		if (ret < 0)
> +			return ret;
> 
> -	return 0;
> +		if (up && (val == BMA220_SUSPEND_SLEEP))
> +			return 0;
> +
> +		if (!up && (val == BMA220_SUSPEND_WAKE))
> +			return 0;
> +	}
> +
> +	return -EBUSY;
>  }

> 
> -static void bma220_deinit(void *spi)
> +static int bma220_init(struct bma220_data *data)
> +{
> +	int ret;
> +	unsigned int val;
> +	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
> +
> +	ret = devm_regulator_bulk_get_enable(data->dev,
> +					     ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to get regulators\n");
I'd have a local struct device *dev = data->dev;
just to shorten the various lines.
> +
> +	/* Try to read chip_id register. It must return 0xdd. */
> +	ret = regmap_read(data->regmap, BMA220_REG_ID, &val);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to read chip id register\n");

Use return dev_err_probe().  For things that can't defer it just brings
prettier prints and simpler code.  Still worth having!

> +		return ret;
> +	}
> +
> +	if (val != BMA220_CHIP_ID)
> +		return -ENODEV;
> +
> +	ret = bma220_power(data, true);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to power-on chip\n");
> +		return ret;

return dev_err_probe() here as well..

> +	}
> +
> +	ret = bma220_reset(data, true);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to soft reset chip\n");
> +		return ret;
and here.

> +	}
> +
> +	return 0;
> +}
> +

> +static irqreturn_t bma220_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	int rv;
> +	u8 bma220_reg_if[2];
> +
> +	guard(mutex)(&data->lock);
> +	rv = regmap_bulk_read(data->regmap, BMA220_REG_IF0, bma220_reg_if,
> +			      sizeof(bma220_reg_if));
> +	if (rv)
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if[1])) {
> +		iio_trigger_poll_nested(data->trig);
> +		goto done;
> +	}
> +
> +done:
> +
> +	return IRQ_HANDLED;
>  }
> 
> -int bma220_common_probe(struct spi_device *spi)
> +int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct bma220_data *data;
> 
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> 
>  	data = iio_priv(indio_dev);
> -	data->spi_device = spi;
> -	mutex_init(&data->lock);
> +	data->regmap = regmap;
> +	data->dev = dev;
> +
> +	ret = bma220_init(data);
> +	if (ret)
> +		return ret;
> 
> +	mutex_init(&data->lock);
#Whilst you are here perhaps switch this to 
	ret = devm_mutex_init(dev, 7data->lock);
	if (ret)
		return ret;

It brings only a small benefit in lock debugging but doesn't cost much either
so I'm encouraging it's use in new code or code we are touching anyway.
Fine to just slip that in with this patch rather than spinning another one.

>  	indio_dev->info = &bma220_info;
>  	indio_dev->name = BMA220_DEVICE_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -269,38 +507,59 @@ int bma220_common_probe(struct spi_device *spi)
>  	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
>  	indio_dev->available_scan_masks = bma220_accel_scan_masks;
> 
> -	ret = bma220_init(data->spi_device);
> -	if (ret)
> -		return ret;
> +	if (irq > 0) {

This next block doesn't seem to have much to do with regmap API conversion.
Wrong patch?

> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &bma220_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(data->dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(data->dev, ret,
> +					     "iio trigger register fail\n");
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&bma220_irq_handler,
> +						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret)
> +			return dev_err_probe(data->dev, ret,
> +					     "request irq %d failed\n", irq);
> +	}
> 
> -	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
> +	ret = devm_add_action_or_reset(data->dev, bma220_deinit, data);
>  	if (ret)
>  		return ret;
> 
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					      iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      bma220_trigger_handler, NULL);
>  	if (ret < 0) {
> -		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +		dev_err(dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
> 
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS(bma220_common_probe, "IIO_BOSCH_BMA220");

> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index be8348ad0a93..00e3fba9436d 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -9,17 +9,25 @@
>  #include <linux/errno.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/types.h>
>  #include <linux/spi/spi.h>
> 
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> 
>  #include "bma220.h"
> 
>  static int bma220_spi_probe(struct spi_device *spi)
>  {
> -	return bma220_common_probe(spi);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &bma220_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "failed to create regmap\n");

		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "failed to create regmap\n");

If there are other similar cases in things only called from probe please
switch them to this interface as well (in a separate patch if touching
existing code)

Thanks,

Jonathan

> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bma220_common_probe(&spi->dev, regmap, spi->irq);
>  }

