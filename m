Return-Path: <linux-iio+bounces-5107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A778C94F4
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A45281F28
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B444AECB;
	Sun, 19 May 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGr7nDlJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0731481A5;
	Sun, 19 May 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128302; cv=none; b=gt2T8pcF6E1x9UK/q7XvWKIxl3fEhL7ky4BrOqyT1+tCVFu8qtuM6aAukWjfk/cEFgV6LxDl3dbeRmiyWBzd9qrgVs2FCCIN9G5YK88v+77dQGxTJpYvRZXUO47x0ccVIacgtdeLERlWNdWE/MntA5a+58Tzi0I/AKEruaUSrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128302; c=relaxed/simple;
	bh=xjkewc1l0PQ/Sm/ArXEkgi0zRDEeMwDg/sOgETDwA6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNuJg6qT5Jh+Ks/b/ZEd+YDueRZLLcjzgu0PYfwkNSlnhrCIJUAu3t0cSAvuE1A3T9YBf0nSM4j7rLqLKxlbBSjakn2WWfftIzDTkO/9qOvfBXHAxc4wNuMkS8RAIAfJ2Mc3DFG412HpijK+qbjf0K9u5LWiLNvh/sm/CVllMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGr7nDlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7B3C32781;
	Sun, 19 May 2024 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716128302;
	bh=xjkewc1l0PQ/Sm/ArXEkgi0zRDEeMwDg/sOgETDwA6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PGr7nDlJv3LY7yz1v/ZyaLrG+hr4S1KrxeKv6CXNsl07jdO8UplLX2KVwylJZCn4Z
	 eN6/ZIJGcE9w95fU0DGsixik0wEVgOAIBEptxZWh8RD35qpFldXU2KQpLzR5xnz1FV
	 wGiiV8vgblUCOSyRAUiSXblJ5VkbWUGSPqBMsMdqyizxQ7BBc5hw+hOJy89//0BGQk
	 tRtPus0W8bWyCkl/Zz4C6XM1TjNC5AwzRjOR4Jp3qh3W8hiT5BVDdbAs2vwEjXD5cm
	 cL8PJj3kKAIRlAkaZdtR0Xy2LFeXnafZEHbNd19SQPfQVbNIJv6GmJLwmSjxmmy7b/
	 y5Vk7XhHVg4jQ==
Date: Sun, 19 May 2024 15:18:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr,
 gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
Message-ID: <20240519151809.192448d1@jic23-huawei>
In-Reply-To: <20240512210444.30824-5-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-5-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 18:04:40 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> ENS160 supports a data ready interrupt. Use it in combination with
> triggered buffer for continuous data readings.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Hi Gustavo,

Various comments inline. Mostly simplifications you can probably make.

Jonathan

> ---
>  drivers/iio/chemical/ens160.h      |   2 +-
>  drivers/iio/chemical/ens160_core.c | 155 ++++++++++++++++++++++++++++-
>  drivers/iio/chemical/ens160_i2c.c  |   2 +-
>  drivers/iio/chemical/ens160_spi.c  |   2 +-
>  4 files changed, 156 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ens160.h b/drivers/iio/chemical/ens160.h
> index 3fd079bc4..a8a2f1263 100644
> --- a/drivers/iio/chemical/ens160.h
> +++ b/drivers/iio/chemical/ens160.h
> @@ -2,7 +2,7 @@
>  #ifndef ENS160_H_
>  #define ENS160_H_
>  
> -int ens160_core_probe(struct device *dev, struct regmap *regmap,
> +int ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		      const char *name);
>  void ens160_core_remove(struct device *dev);
>  
> diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
> index 25593420d..4b960ef00 100644
> --- a/drivers/iio/chemical/ens160_core.c
> +++ b/drivers/iio/chemical/ens160_core.c
> @@ -11,6 +11,9 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> @@ -24,6 +27,11 @@
>  
>  #define ENS160_REG_OPMODE	0x10
>  
> +#define ENS160_REG_CONFIG		0x11
> +#define ENS160_REG_CONFIG_INTEN		BIT(0)
> +#define ENS160_REG_CONFIG_INTDAT	BIT(1)
> +#define ENS160_REG_CONFIG_INT_CFG	BIT(5)
> +
>  #define ENS160_REG_MODE_DEEP_SLEEP	0x00
>  #define ENS160_REG_MODE_IDLE		0x01
>  #define ENS160_REG_MODE_STANDARD	0x02
> @@ -48,6 +56,12 @@
>  
>  struct ens160_data {
>  	struct regmap *regmap;
> +	struct mutex mutex;
> +	struct {
> +		u16 chans[2];

As per the bot reply. This should be __le16.
> +		s64 timestamp __aligned(8);
> +	} scan;

You can do spi read directly into here but if you do
move it to the end of the structure and align it to IIO_DMA_MINALIGN.

> +	int irq;
As below - not sure there is any advantage in keeping a copy
of this after probe. I'd just pass it into the functions that need it.
>  };

>  
>  static int ens160_read_raw(struct iio_dev *indio_dev,
> @@ -79,10 +108,19 @@ static int ens160_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);

Use iio_device_claim_direct_scoped() and guard() for the mutex
as will automate the unwinding of the two types of lock and avoid
you having to do it by hand.


> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->mutex);
>  		ret = regmap_bulk_read(data->regmap, chan->address,
>  					&buf, sizeof(buf));
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&data->mutex);
> +			iio_device_release_direct_mode(indio_dev);
>  			return ret;
> +		}
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(indio_dev);
>  		*val = le16_to_cpu(buf);
>  		return IIO_VAL_INT;
>  
> @@ -182,7 +220,104 @@ static const struct iio_info ens160_info = {
>  	.read_raw = ens160_read_raw,
>  };
>  
> -int ens160_core_probe(struct device *dev, struct regmap *regmap,
> +static irqreturn_t ens160_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +
> +	if (iio_buffer_enabled(indio_dev))

How else did you get here?  Either you should use a threaded interrupt
to check the status registers on the device, or you should assume
there is no other way of getting here (and hence no sharing of interrupt
etc) in which case this check is unnecessary and you can use
iio_trigger_generic_data_rdy_poll().



> +		iio_trigger_poll(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ens160_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ens160_data *data = iio_priv(indio_dev);
> +	__le16 val;
> +	int ret, i, j = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		ret = regmap_bulk_read(data->regmap,
> +				       ENS160_REG_DATA_TVOC + 2 * i, &val, 2U);

sizeof(val) instead of hardcoded 2. Though better still to just bulk
read the lot ever time and loose this loop in favour of the demux in the IIO
core handling the rare occasion of people wanting one channel.

> +		if (ret)
> +			goto err;
> +
> +		data->scan.chans[j++] = val;

Read directly into the data->scan.chans[]

Also, I'd assume that 90% of the time, people want all the channels.  A such
can you just bulk read them all?  Then you can use available_scan_masks
to let the IIO core handle the 10% of the time when only one channel is requested.


> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   pf->timestamp);
> +err:
> +	mutex_unlock(&data->mutex);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ens160_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ens160_data *data = iio_priv(indio_dev);
> +	unsigned int int_bits = ENS160_REG_CONFIG_INTEN |
> +				ENS160_REG_CONFIG_INTDAT |
> +				ENS160_REG_CONFIG_INT_CFG;
> +	int ret;
> +
> +	if (state)
> +		ret = regmap_set_bits(data->regmap, ENS160_REG_CONFIG,
> +				      int_bits);
		return ...
> +	else
> +		ret = regmap_clear_bits(data->regmap, ENS160_REG_CONFIG,
> +					int_bits);
		return ...

> +
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops ens160_trigger_ops = {
> +	.set_trigger_state = ens160_set_trigger_state,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int ens160_setup_trigger(struct iio_dev *indio_dev)
> +{
> +	struct ens160_data *data = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_trigger *trig;
> +	int ret;
> +
> +	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +				      iio_device_id(indio_dev));
> +	if (!trig)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to allocate trigger\n");
> +
> +	trig->ops = &ens160_trigger_ops;
> +	iio_trigger_set_drvdata(trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(dev, trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(trig);
> +
> +	ret = devm_request_threaded_irq(dev, data->irq,
> +					ens160_irq_handler,
> +					NULL,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
Generally, for new drivers we leave the direction control up to firmware.
A nasty, but common trick is to use an inverter to do level conversion.
That results in the polarity being switched but is not explicitly described
in the firmware. So we rely in those cases on the firmware settings for
the interrupt not being modified by the driver.

IRQF_ONESHOT, only here.

> +					indio_dev->name,
> +					indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request irq\n");
> +
> +	return 0;
> +}
> +
> +int ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		      const char *name)
>  {
>  	struct ens160_data *data;
> @@ -196,6 +331,7 @@ int ens160_core_probe(struct device *dev, struct regmap *regmap,
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
> +	data->irq = irq;

As below. This stashing of a copy of irq is an unnecessary complication.

>  
>  	indio_dev->name = name;
>  	indio_dev->info = &ens160_info;
> @@ -203,12 +339,27 @@ int ens160_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->channels = ens160_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
>  
> +	if (data->irq > 0) {

Pass the irq into the setup_trigger call. You don't need it other than for
registration so no point in keeping it in the data structure.

> +		ret = ens160_setup_trigger(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to setup trigger\n");
> +	}
> +
>  	ret = ens160_chip_init(data);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "chip initialization failed\n");
>  		return ret;
>  	}
>  
> +	mutex_init(&data->mutex);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ens160_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS(ens160_core_probe, IIO_ENS160);

