Return-Path: <linux-iio+bounces-24488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC0BA6072
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA62C380E57
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A032E1C7A;
	Sat, 27 Sep 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmCLdZMQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF51AA7BF;
	Sat, 27 Sep 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758982379; cv=none; b=jg9xG8S6wNeUxyBePBRxcmh39wsaV5jtH7GlYWZoGaMlwdkakV2OLqZ09FUAmcqCxRA7nvlwCJrPrJ0SPlCDLU/2G6NEVaRwPwLk9jOWykXjuFeAt2v7b5pCbCowh2ynvv1ayPtcdzmcBLFMi5zi97SCKPbitlFPorw+dWM10aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758982379; c=relaxed/simple;
	bh=pXCLWy+hA0SgtfmjceZdOECgqhlcKU5dHFkqwThzxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP08q1AjljoTMLnBDBrEH2mzirAQNKvOLa96e8L2AAzJ5TN7cR7g1MUgA5ZWK36NhYwyjGwtiDpT4NoolqGqAlr+jJRw6wQo9EMmkK3WOrksIx1peXAwUrULY8Faw6gf6wfL65aYDQFfBdYMZHTs4U0wqHxnWyzxqg1Mg3t1Ru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmCLdZMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8530DC4CEE7;
	Sat, 27 Sep 2025 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758982378;
	bh=pXCLWy+hA0SgtfmjceZdOECgqhlcKU5dHFkqwThzxw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hmCLdZMQV78i4kpnsRPwJi1AGvJUuxtdankDxFRSn3f1ESKqvlP5IgHKjPg2YSyAj
	 os9NhczGPWaPTW68/jAG2FJwxRZqnm1z3fGBDyc51wqPD2vM+p3SBi9XiCE9cFvT9T
	 GdGn5iqvO4nTnJ8pgqR8hg1PvxI7yLiKLq+Mbh5XH5Ez+Tzhwsp+K5vyeakyljGbQD
	 dGWuT09YdnPE1y8u+T3CXlhfnZartAN6ra2v+D4ybEIoJbVPBcVmQNJ4fBoUeNie8W
	 ZkyEUbix5/La2EKrHNoYyz94lHr6Xrrbu4ALg8+VNEVYQwFnb33e08QVtlC0qi5R8/
	 lapDjEQS0JJOg==
Date: Sat, 27 Sep 2025 15:12:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
Message-ID: <20250927151248.6c784f7c@jic23-huawei>
In-Reply-To: <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
	<20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Sep 2025 18:39:36 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add interrupt trigger.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre

A few lock questions from a fresh look.
Sorry for delay - busy few weeks and a few days lain up in bed with
a cold.

> ---
> v1->v2 no change, just patch split
> v2->v3 replace regmap_bulk_read with regmap_read (Jonathan)
>  (I just realized BMA220_REG_IF0 is never used, even by future event
> patches)
> ---
>  drivers/iio/accel/bma220_core.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 425a8b981e141aa496351f29df0597c989aa4a0a..6297882bcf1b955291a2d8747984648bc6ee8512 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> @@ -125,6 +126,7 @@ struct bma220_data {
>  	struct regmap *regmap;
>  	struct mutex lock;
>  	u8 range_idx;
> +	struct iio_trigger *trig;
>  	struct {
>  		s8 chans[3];
>  		/* Ensure timestamp is naturally aligned. */
> @@ -193,6 +195,23 @@ const struct regmap_config bma220_i2c_regmap_config = {
>  };
>  EXPORT_SYMBOL_NS_GPL(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
>  
> +static int bma220_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bma220_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);

What is this lock protecting? 

> +	return regmap_update_bits(data->regmap, BMA220_REG_IE0,
> +				  BMA220_INT_EN_DRDY_MSK,
> +				  FIELD_PREP(BMA220_INT_EN_DRDY_MSK, state));
> +}

> @@ -417,6 +436,24 @@ static void bma220_deinit(void *data_ptr)
>  			 ERR_PTR(ret));
>  }
>  
> +static irqreturn_t bma220_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct bma220_data *data = iio_priv(indio_dev);
> +	int rv;
> +	unsigned int bma220_reg_if1;
> +
> +	guard(mutex)(&data->lock);

What is the lock protecting here?  The internal locks in regmap
superficially look like they'd be enough given we only have a single
read.  I'd expect any necessary locking to be on the otherside
of that use of the iio trigger framework (so the poll function thread).

> +	rv = regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
> +	if (rv)
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
> +		iio_trigger_poll_nested(data->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  {
>  	int ret;
> @@ -446,6 +483,30 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
>  	indio_dev->available_scan_masks = bma220_accel_scan_masks;
>  
> +	if (irq > 0) {
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &bma220_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "iio trigger register fail\n");
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&bma220_irq_handler,
> +						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
Interrupt polarity should be coming from firmware.

It's a historically common mistake to encode it in the driver as it breaks
fairly standard things like using an inverter as a cheap level converter
in front of the interrupt pin.

So IRQF_ONEHSOT only should be all that is needed here.

> +						indio_dev->name, indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "request irq %d failed\n", irq);
> +	}
> +
>  	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
>  	if (ret)
>  		return ret;
> 


