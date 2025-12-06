Return-Path: <linux-iio+bounces-26838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3CCAAB8C
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 18:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A460A3010E3F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4526ED48;
	Sat,  6 Dec 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6GHQNnl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1939FD9;
	Sat,  6 Dec 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765043563; cv=none; b=jafQMbDdvUeeEl3mmQuL3nHjGBVb/2FY8lwT7RB6hGayMYw7IslM9BitRm3juCTwHy0KC+ZrjNv88qbaflddzHW1ryqOwPwAubYN6970YT/FPg3n+Y8CDxqQEweouCmcnm1UL1wwEld6jhhSAccJnf/OcmU4x73ay+qRwQmCXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765043563; c=relaxed/simple;
	bh=LmO6Rt3Z4h6MBy0Vo63R9mVy7WXJNGMDkNamlXBNVoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt3foWhLqzFBPq8uP4fQYnFpon10d6TCg4kLZ4zl6lkqoqaIBMZ4woiYQdOoNZcEiReIJkDXq6vI3SwwL2ots80tn4vZVqhIjrXKB6OZ3Zs/LvUc1Zumq64+ne9UCeZr4MNNpC+d5PRaMNr9JBRdQ+159dZlz0ZPCYMh2I50g40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6GHQNnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B189DC4CEF5;
	Sat,  6 Dec 2025 17:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765043562;
	bh=LmO6Rt3Z4h6MBy0Vo63R9mVy7WXJNGMDkNamlXBNVoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O6GHQNnl5MbLHjd61zNWpZzx620KFy/41Sd6UZ5pB8NUe5FL719nd5UnTyTM2sq2d
	 3G4/O3dM06du3C4oqYvZDIPwcj3H8U0Sp07g6yVUGKTaZ9ZdorkvsFsQYX5qAIvcyq
	 YT2gLf/Yutbm1qoehtg21dqqWEq4SnjDgWf4OuccLyHqBPGQbjr1DYZNupV0nT9mkM
	 9cJDJhah/nhAO+129b5uRI5aXTi49x+NV76Pgtejld/j5jt1ZKlC+8K9cjTlRWSiVP
	 4eMEngx3196bmjZC32rvBtr0764rs/EZi382mT7NJLN78OtmzweJZtE1cNocrKxuiq
	 Iws5Gi85trPgg==
Date: Sat, 6 Dec 2025 17:52:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] iio: adc: ad4062: Add IIO Events support
Message-ID: <20251206175231.3522233f@jic23-huawei>
In-Reply-To: <20251205-staging-ad4062-v3-7-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
	<20251205-staging-ad4062-v3-7-8761355f9c66@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 16:12:08 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
> Either signal, if not present, fallback to an I3C IBI with the same
> role.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
Various comments inline.

Thanks,

Jonathan

> +static ssize_t sampling_frequency_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	if (st->wait_event) {
> +		ret = -EBUSY;
> +		goto out_release;
> +	}
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret < 0)

if (ret)
 would make the following bit about ret == 0 if this isn't true
more obvious.

> +		goto out_release;
> +
> +	st->events_frequency = find_closest_descending(val, ad4062_conversion_freqs,
> +						       ARRAY_SIZE(ad4062_conversion_freqs));
> +	ret = 0;
If you get here it's zero anyway.
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret ?: len;
> +}

>  static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -432,6 +549,14 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
>  {
>  	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
>  
> +	if (st->wait_event) {
> +		iio_push_event(st->indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(st->indio_dev));
> +		return;
> +	}
>  	if (iio_buffer_enabled(st->indio_dev))
>  		iio_trigger_poll_nested(st->trigger);
>  	else
> @@ -523,6 +648,24 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
>  	struct device *dev = &st->i3cdev->dev;
>  	int ret;
>  
> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp0");
> +	if (ret == -EPROBE_DEFER) {
> +		return ret;
> +	} else if (ret < 0) {

no need for else.

> +		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
> +					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN,
> +					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = devm_request_threaded_irq(dev, ret, NULL,
> +						ad4062_irq_handler_thresh,
> +						IRQF_ONESHOT, indio_dev->name,
> +						indio_dev);
> +		if (ret)
> +			return ret;
> +	}

> +static int ad4062_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;

Similar to below. Consider factoring out this stuff or I guess wait
for an ACQUIRE() based standard solution.

> +	if (st->wait_event) {
> +		ret = -EBUSY;
> +		goto out_release;
> +	}
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = __ad4062_read_event_info_value(st, dir, val);
> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		ret = __ad4062_read_event_info_hysteresis(st, dir, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret ?: IIO_VAL_INT;
> +}
> +
> +static int __ad4062_write_event_info_value(struct ad4062_state *st,
> +					   enum iio_event_direction dir, int val)
> +{
> +	u8 reg;
> +
> +	if (val != sign_extend32(val, AD4062_LIMIT_BITS - 1))
> +		return -EINVAL;
> +	if (dir == IIO_EV_DIR_RISING)
> +		reg = AD4062_REG_MAX_LIMIT;
> +	else
> +		reg = AD4062_REG_MIN_LIMIT;
> +	put_unaligned_be16(val, st->buf.bytes);

I'll stop comment on this now an assume you'll find all these places
where we know it is aligned and so don't need to use these less efficient
functions.

> +
> +	return regmap_bulk_write(st->regmap, reg, &st->buf.be16,
> +				 sizeof(st->buf.be16));
> +}

> +
> +static int ad4062_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val,
> +				    int val2)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;

Whilst I do plan to take a look at whether we can do an ACQUIRE pattern
like the runtime pm ones, for now (unless you fancy taking that on)
I'd be tempted to factor out this stuff under the direct mode claim into
a helper that can then do direct returns. That should end up easier to ready
that this.

> +	if (st->wait_event) {
> +		ret = -EBUSY;
> +		goto out_release;
> +	}
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = __ad4062_write_event_info_value(st, dir, val);
> +			break;
> +		case IIO_EV_INFO_HYSTERESIS:
> +			ret = __ad4062_write_event_info_hysteresis(st, dir, val);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +out_release:
>  	iio_device_release_direct(indio_dev);
>  	return ret;
>  }

