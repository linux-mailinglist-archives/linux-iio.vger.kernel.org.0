Return-Path: <linux-iio+bounces-13836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4CB9FDAE2
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2893A1361
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229918A6BD;
	Sat, 28 Dec 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9QojSux"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDF1791F4;
	Sat, 28 Dec 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735395903; cv=none; b=t9CzlzNVoCM1qSTtHu287po0y0QbuQaFVdF/xBjbK43lFUi1F4psdQZ+awDqF8aRROXyDK0Ujx9EofiKzqr/mNr65WD8qK7ey5/CFUz5vBHUQSXvtoWk1DC/KqMnr0tc5fOKu9GCY4Fum/Hk1Xc15d/C8g4970Gj28F2juL94pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735395903; c=relaxed/simple;
	bh=L8r4iKf42OF4s0kPZf9n9HA1bRI/Sb4RnHGwV9CWuzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcgoRXkoymmcA8WEFL5jHUUcE8YlmQJcJEDJME79Wv8rJZQ7NLAz7ZBTclPCVdcyW9y53S7FsMJlHKQReZa9qyYfV+HzRb8n+xrvpgPcivSXHDplg6SxVQVhgSToBXt6wukO24KJVP0B3Sak3FqiqQlKwWY0+jfMnTyUdxqsZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9QojSux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7025C4CECD;
	Sat, 28 Dec 2024 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735395903;
	bh=L8r4iKf42OF4s0kPZf9n9HA1bRI/Sb4RnHGwV9CWuzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t9QojSuxT7wAwoBbIv2UnGXIuRI53o805vT+QOnk8rHpZJ3bm8gbHNuAF++vhaFGg
	 8u250gjaZ5a9P6oLp/7XeLyQ4VO+mmY/HtkhrYHvmBz6EbeTix/5Rh+Zjeb+X+m+tf
	 bLGbGZft7vouJTB1ScF0aiJEC+MCboE4a4+WYlUgfM3cydd+VeTDBQdHtBc7T33CFs
	 6GlbjrfsCVbfmzC3ihBv3oHKEgdMjmiForTuYyFs0i2aeHLqnnK51a7/F1bK+MkWGn
	 oIDZlCmwiKULQ8QJUeXD5QXOwsORE1dfavPKq3YWquxbZhqo9H3j/T/uYUcyh4jaWo
	 Izv5nl8GzkN1g==
Date: Sat, 28 Dec 2024 14:24:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] iio: adc: ad7380: add alert support
Message-ID: <20241228142457.576f47d4@jic23-huawei>
In-Reply-To: <20241224-ad7380-add-alert-support-v2-3-7c89b2bf7cb3@baylibre.com>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-3-7c89b2bf7cb3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 10:34:32 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> The alert functionality is an out of range indicator and can be used as an
> early indicator of an out of bounds conversion result.
> 
> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to all
> channels.
> 
> When using 1 SDO line (only mode supported by the driver right now), i.e
> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
> used as an alert pin. The alert pin is updated at the end of the
> conversion (set to low if an alert occurs) and is cleared on a falling
> edge of CS.
> 
> The ALERT register contains information about the exact alert status:
> channel and direction. Unfortunately we can't read this register because
> in buffered read we cannot claim for direct mode.
> 
> User can set high/low thresholds and enable event detection using the
> regular iio events:
> 
>   events/in_thresh_falling_value
>   events/in_thresh_rising_value
>   events/thresh_either_en
> 
> If the interrupt properties is present in the device tree, an IIO event
> will be generated for each interrupt received.
> Because we cannot read ALERT register, we can't determine the exact
> channel that triggers the alert, neither the direction (hight/low
> threshold violation), so we send and IIO_EV_DIR_EITHER event for all
> channels.
> 
> In buffered reads, if input stays out of thresholds limit, an interrupt
> will be generated for each sample read, because the alert pin is cleared
> on a falling edge of CS (i.e when starting a new conversion). To avoid
> generating to much interrupt, we introduce a reset_timeout that can be
> used to disable interrupt for a given time (in ms)
> 
>   events/thresh_either_reset_timeout
> 
> When an interrupt is received, interrupts are disabled and re-enabled
> after thresh_either_reset_timeout ms. If the reset timeout is set to 0,
> interrupt are re-enabled directly.
> Note: interrupts are always disabled at least during the handling of the
> previous interrupt, because each read triggers 2 transactions, that can
> lead to 2 interrupts for a single user read. IRQF_ONESHOT is not enough,
> because, it postpones the 2nd irq after the handling of the first one,
> which can still trigger 2 interrupts for a single user read.

After some of our recent discussions around interrupt handling and
the guarantees (that aren't) made, even disabling the interrupt doesn't
prevent some irq chips queuing up future interrupts.

https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc/

I'm not sure this alert can actually work as a result :(
I am struggling to come up with a scheme that will work.


> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/adc/ad7380.c | 354 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 350 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index b49067c36fdd1bb0e760faf71d7fa0c8c1f610e9..fb59c2c064f402ea797fc0e563bd535d0e0bf785 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -34,6 +34,7 @@

...

> +
>  enum {
>  	AD7380_SCAN_TYPE_NORMAL,
>  	AD7380_SCAN_TYPE_RESOLUTION_BOOST,
> @@ -214,6 +252,8 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
>  	.has_ext_scan_type = 1,							\
>  	.ext_scan_type = ad7380_scan_type_##bits##_##sign,			\
>  	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits##_##sign),	\
> +	.event_spec = ad7380_events,						\
> +	.num_event_specs = ARRAY_SIZE(ad7380_events),				\

These are set below. So why here as well?

>  }

>  static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
>  				     u32 writeval, u32 *readval)
>  {
> @@ -727,8 +791,8 @@ static int ad7380_regval_to_osr(int regval)
>  
>  static int ad7380_get_osr(struct ad7380_state *st, int *val)
>  {
> -	int tmp;
> -	int ret = 0;
> +	u32 tmp;
> +	int ret;

Why these changes?

>  
>  	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
>  	if (ret)
> @@ -834,6 +898,13 @@ static int ad7380_update_xfers(struct ad7380_state *st,
>  	return 0;
>  }


> @@ -1002,8 +1084,11 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		ret = ad7380_read_direct(st, chan->scan_index,
> -					 scan_type, val);
> +		ad7380_enable_irq(st);
> +
> +		ret = ad7380_read_direct(st, chan->scan_index, scan_type, val);

Avoid the reformat.  It's fine in principle but in practice it makes it
harder to see there is no change here, so not in a patching doing anything else.

> +
> +		ad7380_disable_irq(st);
>  
>  		iio_device_release_direct_mode(indio_dev);
>  
> @@ -1151,12 +1236,190 @@ static int ad7380_get_current_scan_type(const struct iio_dev *indio_dev,
>  					    : AD7380_SCAN_TYPE_NORMAL;

> +static int ad7380_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap,
> +				 AD7380_REG_ADDR_CONFIG1,
> +				 AD7380_CONFIG1_ALERTEN,
> +				 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
	return ret;

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ad7380_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	int ret, tmp;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +
Check ret

> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = regmap_read(st->regmap,
> +					  AD7380_REG_ADDR_ALERT_HIGH_TH,
> +					  &tmp);
> +			if (ret)
> +				return ret;
Holding direct mode.  As below. Factor out everything with direct mode
held into a separate function. That can then return directly
where it makes sense with the release handled by the caller.

> +
> +			*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			ret = regmap_read(st->regmap,
> +					  AD7380_REG_ADDR_ALERT_LOW_TH,
> +					  &tmp);
> +			if (ret)
> +				return ret;
> +
> +			FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	case IIO_EV_INFO_RESET_TIMEOUT:
> +		*val = st->alert_reset_timeout_ms;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7380_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	int ret;
> +	u16 th;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
Similar to earlier suggestion. I'd factor the contents of this out
as a helper.... Thus avoiding...
> +
> +		/*
> +		 * According to the datasheet,
> +		 * AD7380_REG_ADDR_ALERT_HIGH_TH[11:0] are the 12 MSB of the
> +		 * 16-bits internal alert high register. LSB are set to 0xf.
> +		 * AD7380_REG_ADDR_ALERT_LOW_TH[11:0] are the 12 MSB of the
> +		 * 16 bits internal alert low register. LSB are set to 0x0.
> +		 *
> +		 * When alert is enabled the conversion from the adc is compared

ADC

> +		 * immediately to the alert high/low thresholds, before any
> +		 * oversampling. This means that the thresholds are the same for
> +		 * normal mode and oversampling mode.
> +		 */
> +
> +		/* Extract the 12 MSB of val */
> +		scan_type = iio_get_current_scan_type(indio_dev, chan);
> +		if (IS_ERR(scan_type))

...this.  You are still holding the device in direct mode which it can never
leave.  With a helper direct returns here and below work fine giving
cleaner code.

> +			return PTR_ERR(scan_type);
> +
> +		th = val >> (scan_type->realbits - 12);
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = regmap_write(st->regmap,
> +					   AD7380_REG_ADDR_ALERT_HIGH_TH,
> +					   th);
> +			if (ret)
> +				return ret;
> +
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			ret = regmap_write(st->regmap,
> +					   AD7380_REG_ADDR_ALERT_LOW_TH,
> +					   th);
> +			if (ret)
> +				return ret;
> +
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	case IIO_EV_INFO_RESET_TIMEOUT:
> +		if (val < 0)
> +			return -EINVAL;
> +		st->alert_reset_timeout_ms = val;
> +		timer_reduce(&st->alert_timer, jiffies + msecs_to_jiffies(val));
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}

>  static int ad7380_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -1361,6 +1674,39 @@ static int ad7380_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->available_scan_masks = st->chip_info->available_scan_masks;
>  
> +	if (spi->irq) {
> +		struct iio_chan_spec *chans;
> +		size_t size;
> +		int ret;
> +
> +		ret = devm_request_threaded_irq(dev, spi->irq,
> +						&ad7380_primary_event_handler,
> +						&ad7380_event_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT

As Uwe mentioned. Normally we'd not have the direction here. The interrupt
may be wired to a different pin with an inverter in the path for example.
Hence this is left as a problem for DT.


> +						| IRQF_NO_AUTOEN,
> +						indio_dev->name,
> +						indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> +		atomic_set(&st->irq_enabled, 0);
> +
> +		/*
> +		 * Copy channels to be able to update the event_spec, since some
> +		 * attributes are visible only when irq are configured
> +		 */
> +		size = indio_dev->num_channels * sizeof(*indio_dev->channels);
> +		chans = devm_kzalloc(dev, size, GFP_KERNEL);

devm_kmemdup()

Normally I'd argue for multiple static const arrays, but I guess there are a lot
of options here so that would become huge so this seems reasonable.


> +		if (!chans)
> +			return -ENOMEM;
> +
> +		memcpy(chans, indio_dev->channels, size);
> +		chans->event_spec = ad7380_events_irq;
> +		chans->num_event_specs = ARRAY_SIZE(ad7380_events_irq);
> +
> +		indio_dev->channels = chans;
> +	}
> +
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
>  					      ad7380_trigger_handler,
> 


