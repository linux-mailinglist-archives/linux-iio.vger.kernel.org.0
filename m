Return-Path: <linux-iio+bounces-11576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C369B5327
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 21:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528EEB21890
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A99206E61;
	Tue, 29 Oct 2024 20:14:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693231DEFD0
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232860; cv=none; b=sDvH8MdIAhqff/cxgKHLChgQv68MIC15GYl8Gvqn+Hgrw/9qx0cTSo3dfMjc7ZQqV1Y/+16wkhx6j16eKGuQd0v6a9ghUWdJt6tYAzvALH753xRx/h0E0Mx5ocW7AEjxvIcIsJiK1wP4qlHQIJAiVQ1zch6mx40xIq9ww14htd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232860; c=relaxed/simple;
	bh=/WXO8zC1tMtIE11ww7hVOXlZN/bNRSd8hZhLxkXpuO4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+ZSHBntdTk7614tvCEIP2R3HXLNeyNqM/3tXzBLYQCCRGXu29r7hP+pN/yVFqw0ZYfXZDRcRAL0Ho7Nv64YGa4AdSjQPTtIBEBiTwbd3cdsKAn1m0AdMggAcJ220RgKHPbpEdMfxXXiuLTw5/R5i/247k5N/mRyBc6DSdtT4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 5852ce3b-9632-11ef-9a70-005056bd6ce9;
	Tue, 29 Oct 2024 22:14:04 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Oct 2024 22:14:04 +0200
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: adc: ad7380: add alert support
Message-ID: <ZyFCDHsA4hoVnNy2@surfacebook.localdomain>
References: <20241029-ad7380-add-alert-support-v1-1-d0359401b788@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-ad7380-add-alert-support-v1-1-d0359401b788@baylibre.com>

Tue, Oct 29, 2024 at 04:02:46PM +0100, Julien Stephan kirjoitti:
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
> Because we cannot read ALERT register, we can't determine the exact
> channel that triggers the alert, neither the direction (hight/low
> threshold violation), so we send and IIO_EV_DIR_EITHER event for all
> channels. This is ok, because the primary use case for this chip is to
> hardwire the alert line to shutdown the device.
> 
> When reading a channel raw data, we have to trigger 2 spi transactions: a
> first transaction that will trigger a conversion and a second
> transaction to read the conversion. By design a new conversion is
> initiated on each falling edge of CS. This will trigger a second
> interrupt. To avoid that we disable irq in the hard irq handler and
> re-enable them in thread handler.

...

>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/events.h>

Perhaps keep it ordered?

>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>

...

> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		struct ad7380_state *st = iio_priv(indio_dev);
> +		int ret;
> +
> +		if (state == st->alert_en)
> +			return 0;
> +
> +		/*
> +		 * According to the datasheet, high threshold must always be
> +		 * greater than low threshold

Missed period at the end.

> +		 */
> +		if (state && st->high_th < st->low_th)
> +			return -EINVAL;
> +
> +		ret = regmap_update_bits(st->regmap,
> +					 AD7380_REG_ADDR_CONFIG1,
> +					 AD7380_CONFIG1_ALERTEN,
> +					 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
> +
> +		if (ret)
> +			return ret;
> +
> +		st->alert_en = state;
> +
> +		return 0;
> +	}
> +	unreachable();
> +}

...

> +static int ad7380_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		struct ad7380_state *st = iio_priv(indio_dev);
> +		int ret;
> +
> +		/*
> +		 * According to the datasheet,
> +		 * AD7380_REG_ADDR_ALERT_HIGH_TH[11:0] are the MSB of the 16-bit
> +		 * internal alert high register. LSB are set to 0x0.
> +		 * AD7380_REG_ADDR_ALERT_LOW_TH[11:0] are the MSB of the 16 bit
> +		 * internal alert low register. LSB are set to 0xf.
> +		 *
> +		 * When alert is enabled the conversion from the adc is compared
> +		 * immediately to the alert high/low thresholds, before any
> +		 * oversampling. This means that the thresholds are the same for
> +		 * normal mode and oversampling mode.
> +		 * For 12 and 14 bits, the thresholds are still on 16 bits.
> +		 */
> +		if (val < 0 || val > 2047)

What about having val >= BIT(11) here?

> +			return -EINVAL;
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = regmap_write(st->regmap,
> +					   AD7380_REG_ADDR_ALERT_HIGH_TH,
> +					   val);
> +			if (!ret)
> +				st->high_th = val << 4 | 0xf;

GENMASK() ? Predefined constant?

> +			return ret;


			if (ret)
				return ret;
			...
			return 0;

(yes, more verbose, but better for reading and maintenance)

> +		case IIO_EV_DIR_FALLING:
> +			ret = regmap_write(st->regmap,
> +					   AD7380_REG_ADDR_ALERT_LOW_TH,
> +					   val);
> +			if (!ret)
> +				st->low_th = val << 4;
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	unreachable();
> +}

...

> +	st->high_th = 0x7ff;
> +	st->low_th = 0x800;

I would go with BIT(11) - 1 and BIT(11) as it seems related to the amount of
bits in the hardware.

...

> +static irqreturn_t ad7380_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan = &indio_dev->channels[0];
> +	int i = 0, j = 0;

Why signed? And for 'i' the assignment is redundant.

> +
> +	for (i = 0; i < st->chip_info->num_channels - 1; i++) {
> +		iio_push_event(indio_dev,
> +			       chan->differential ?
> +			       IIO_DIFF_EVENT_CODE(IIO_VOLTAGE,
> +						   j,
> +						   j + 1,
> +						   IIO_EV_TYPE_THRESH,
> +						   IIO_EV_DIR_EITHER) :
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +						    i,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       timestamp);
> +		j += 2;
> +	}
> +
> +	enable_irq(irq);
> +
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko



